module SPUCore (
  clk,
  rst,
  i_start,
  i_op,
  i_dest,
  i_imm,
  i_strAlocation,
  i_strBlocation,
  i_mem_data,
  o_mem_addr,
  o_mem_re,
  o_sreg_data,
  o_sreg_addr,
  o_sreg_we,
  o_done
);

input clk, rst, i_start;
input [3:0] i_op, i_dest;
input [7:0] i_imm;
input [31:0] i_strAlocation, i_strBlocation;
input [127:0] i_mem_data;

output reg o_done, o_mem_re, o_sreg_we;
output [3:0] o_sreg_addr;
output signed [31:0] o_sreg_data;
output reg [31:0] o_mem_addr;

localparam IDLE   = 3'd0;
localparam FTCHA  = 3'd1;
localparam FTCHB  = 3'd2;
localparam STRT   = 3'd3;
localparam WORK   = 3'd4;
localparam RSLT   = 3'd5;
localparam FTCHA2 = 3'd6;

localparam STRLEN  = 4'd0;
localparam STRCMP  = 4'd1;
localparam STRCHR  = 4'd2;
localparam STRRCHR = 4'd3;
localparam STRCCHR = 4'd4;
localparam STRSTR  = 4'd5;
localparam STRLST  = 4'd5;

reg noNullMatches;
reg [2:0] state, nxstate;
reg [3:0] operation, destination;
reg [7:0] immediate;
reg [31:0] strAloc, strBloc, strCounter, strChunks;
reg [127:0] stringB;
reg [255:0] stringA;

wire [4:0] zpenc_out, mpenc_out, zcnt_out, penc_out, zerospenc_out;

reg start_job, save_instr, working;
reg save_stringA, save_stringB, zero_stringB, load_stringB, shift_stringA, append_stringA, save_stringA2;
reg inc_strAloc, inc_strBloc, clr_strCounter, inc_strCounter, neg_strCounter, set_strCounter;
reg inc_strChunks, clr_strChunks;
reg return_strCmp, return_strCounter;
reg [7:0] searchChr;
reg [31:0] penc_value, amt_inc_strCounter, amt_strCounter;

wire cmpr_done, cmpr_strAgte;
wire [15:0] cmpr_out, cmpr_zerosA, cmpr_zerosB;
Comparator cmpr (
   .clk(clk),
   .rst(rst),
   .i_set(working),
   .i_stringA(stringA[127:0]),
   .i_stringB(stringB),
   .i_NullNeverMatches(noNullMatches),
   .o_result(cmpr_out),
   .o_zerosA(cmpr_zerosA),
   .o_zerosB(cmpr_zerosB),
   .o_greater(cmpr_strAgte),
   .o_done(cmpr_done)
);

reg clr_strALenCounter, en_strALenCounter;
wire strAFetch, strASave;
wire [3:0] strALenCounter_val;
UpCounter #(.LIMIT(15), .MAXBITS(4)) strALenCounter (
	.clk(clk),
	.rst(rst),
	.i_en(en_strALenCounter),
	.i_clear(clr_strALenCounter),
	.o_value(strALenCounter_val),
	.o_done()
);

assign strAFetch = strALenCounter_val == 4'd14;
assign strASave  = strALenCounter_val == 4'd15;

assign o_sreg_data = (return_strCounter ? strCounter : 
					return_strCmp	 ? (cmpr_strAgte ? {16'd0, (~cmpr_out)+1} : {16'd0, cmpr_out}) :
									   {16'd0, cmpr_out});
assign o_sreg_addr = destination;

assign isComparedAllZeros = (|cmpr_out) == 1'b0;
assign isComparedAllOnes = (&cmpr_out) == 1'b1;
assign isAllNullStrA = (&cmpr_zerosA) == 1'b1;
assign isAllNullStrB = (&cmpr_zerosB) == 1'b1;
assign isNullInStrA = (|cmpr_zerosA) != 1'b0;
assign isNullInStrB = (|cmpr_zerosB) != 1'b0;

always @(posedge clk or posedge rst) begin
	if (rst)
		noNullMatches <= 1'b0;
	else if (operation == STRSTR) begin
		noNullMatches <= 1'b1;
	end
	else begin
		noNullMatches <= 1'b0;
	end
end

always @(posedge clk or posedge rst) begin
	if (rst)
		strCounter <= 32'd0;
	else if (set_strCounter)
		strCounter <= amt_strCounter;
	else if (inc_strCounter)
		strCounter <= strCounter + amt_inc_strCounter;
	else if (neg_strCounter)
		strCounter <= {32{1'b1}};
	else if (clr_strCounter)
		strCounter <= 32'd0;
end

always @(posedge clk or posedge rst) begin
	if (rst)
		strChunks <= 32'd0;
	else if (inc_strChunks)
		strChunks <= strChunks + 32'd16;
	else if (clr_strChunks)
		strChunks <= 32'd0;
end

always @(posedge clk or posedge rst) begin
	if (rst)
		strAloc <= 32'd0;
	else if (save_instr)
		strAloc <= i_strAlocation;
	else if (inc_strAloc)
		strAloc <= strAloc + 1'b1;
end

always @(posedge clk or posedge rst) begin
	if (rst)
		strBloc <= 32'd0;
	else if (save_instr)
		strBloc <= i_strBlocation;
	else if (inc_strBloc)
		strBloc <= strBloc + 1'b1;
end

always @(posedge clk or posedge rst) begin
	if (rst) begin
		operation <= 4'd0;
		destination <= 4'd0;
		immediate <= 8'd0;
	end
	else if (save_instr) begin
		operation <= i_op;
		destination <= i_dest;
		immediate <= i_imm;
	end
end

always @(posedge clk or posedge rst) begin
	if (rst)
		working <= 1'b0;
	else if (start_job)
		working <= 1'b1;
	else if (o_done)
		working <= 1'b0;
end

always @(posedge clk or posedge rst) begin
	if (rst)
		stringA <= 128'd0;
	else if (save_stringA)
		stringA <= {{16{8'hff}}, i_mem_data};
	else if (save_stringA2)
		stringA <= {i_mem_data, stringA[127:0]};
	else if (shift_stringA)
		stringA <= {8'hff, stringA[255:8]};
	else if (append_stringA)
		stringA <= {i_mem_data, stringA[135:8]};
end

always @(posedge clk or posedge rst) begin
	if (rst)
		stringB <= 128'd0;
	else if (save_stringB)
		stringB <= i_mem_data;
	else if (zero_stringB)
		stringB <= 128'd0;
	else if (load_stringB)
		stringB <= {16{searchChr}};
end

PriorityEnc #(.WIDTH(16)) penc (
	.in(cmpr_out),
	.out(penc_out)
);

ZeroPriorityEnc #(.WIDTH(16)) zpenc (
	.in(cmpr_out),
	.out(zpenc_out)
);

ZeroPriorityEnc #(.WIDTH(16)) zzpenc (
	.in(~cmpr_zerosB),
	.out(zerospenc_out)
);
  
MSBZeroPriorityEnc #(.WIDTH(16)) mpenc (
	.in(cmpr_out),
	.out(mpenc_out)
);

ZeroCounter #(.WIDTH(16)) zcnt (
	.in(cmpr_out),
	.out(zcnt_out)
);

always @(*) begin
	nxstate = state;
	
	start_job = 1'b0;
	o_mem_addr = 32'h0000;
	o_mem_re = 1'b0;
	o_sreg_we = 1'b0;
	return_strCounter = 1'b0;
	return_strCmp = 1'b0;
	save_stringA = 1'b0;
	save_stringB = 1'b0;
	zero_stringB = 1'b0;
	load_stringB = 1'b0;
	shift_stringA = 1'b0;
	append_stringA = 1'b0;
	save_stringA2 = 1'b0;
	searchChr = 8'h00;
	save_instr = 1'b0;
	inc_strAloc = 1'b0;
	inc_strBloc = 1'b0;
	inc_strCounter = 1'b0;
	amt_inc_strCounter = 32'd16;
	clr_strCounter = 1'b0;
	neg_strCounter = 1'b0;
	set_strCounter = 1'b0;
	clr_strChunks = 1'b0;
	inc_strChunks = 1'b0;
	penc_value = 16'd0;
	clr_strALenCounter = 1'b0;
	en_strALenCounter = 1'b0;
	amt_strCounter = 32'd0;
	o_done = 1'b0;
	
	case (state)
		IDLE: begin
			if (i_start && i_op <= STRLST) begin
				nxstate = FTCHA;
				save_instr = 1'b1;
				o_mem_addr = i_strAlocation;
				o_mem_re = 1'b1;

				if (i_op == STRRCHR || i_op == STRSTR) begin
					clr_strChunks = 1'b1;
					neg_strCounter = 1'b1;
				end
				else begin
					clr_strCounter = 1'b1;
					clr_strALenCounter = 1'b1;
				end
			end
		end
		
		FTCHA: begin
			save_stringA = 1'b1;
			case (operation)
				STRLEN: begin
					nxstate = STRT;
					zero_stringB = 1'b1;
					start_job = 1'b1;
				end
				STRCMP: begin
					nxstate = FTCHB;
					o_mem_addr = strBloc;
					o_mem_re = 1'b1;
				end
				STRCHR: begin
					nxstate = STRT;
					searchChr = immediate;
					load_stringB = 1'b1;
					start_job = 1'b1;
				end
				STRRCHR: begin
					nxstate = STRT;
					searchChr = immediate;
					load_stringB = 1'b1;
					start_job = 1'b1;
				end
				STRCCHR: begin
					nxstate = STRT;
					searchChr = immediate;
					load_stringB = 1'b1;
					start_job = 1'b1;
				end
				STRSTR: begin
					nxstate = FTCHB;
					o_mem_addr = strBloc;
					o_mem_re = 1'b1;
					start_job = 1'b1;
				end
				default: nxstate = IDLE;
			endcase
		end
		
		FTCHB: begin
			if (operation == STRSTR && !isNullInStrA) begin
				nxstate = FTCHA2;
				save_stringB = 1'b1;
				inc_strAloc = 1'b1;
				o_mem_addr = strAloc + 1'b1;
				o_mem_re = 1'b1;
			end
			else begin
				nxstate = STRT;
				save_stringB = 1'b1;
				start_job = 1'b1;
			end
		end
		
		FTCHA2: begin
			nxstate = STRT;
			save_stringA2 = 1'b1;
		end

		STRT: begin
			nxstate = WORK;
		end
		
		WORK: begin
			nxstate = WORK;
			case (operation)
				STRLEN: begin
					if (isAllNullStrA) begin	   // The string ended last time
						nxstate = RSLT;
					end
					else if (!isNullInStrA) begin  // No null chr, so get the next chunk
						nxstate = FTCHA;
						inc_strAloc = 1'b1;
						o_mem_addr = strAloc + 1'b1;
						o_mem_re = 1'b1;
						inc_strCounter = 1'b1;
					end
					else begin					 // Must be done with the string
						nxstate = RSLT;
						amt_inc_strCounter = {28'd0, zpenc_out};
						inc_strCounter = 1'b1;
					end
				end
				STRCMP: begin
					if (isNullInStrA || isNullInStrB) begin  // One or both strings are finished
						nxstate = RSLT;
					end
					else if (!isComparedAllZeros) begin	  // Strings aren't done, but no match
						nxstate = RSLT;
					end
					else begin							   // Get the next chunk of strings
						nxstate = FTCHA;
						inc_strAloc = 1'b1;
						inc_strBloc = 1'b1;
						o_mem_addr = strAloc + 1'b1;
						o_mem_re = 1'b1;
					end
				end
				STRCHR: begin
					if (!isComparedAllOnes) begin
						nxstate = RSLT;
						amt_inc_strCounter = {28'd0, zpenc_out};
						inc_strCounter = 1'b1;
					end
					else if (!isNullInStrA) begin  // No null chr, so get the next chunk
						nxstate = FTCHA;
						inc_strAloc = 1'b1;
						o_mem_addr = strAloc + 1'b1;
						o_mem_re = 1'b1;
						inc_strCounter = 1'b1;
					end
					else begin					 // Didn't find the character
						nxstate = RSLT;
						neg_strCounter = 1'b1;
					end
				end
				STRRCHR: begin
					if (!isComparedAllOnes) begin
						amt_strCounter = {16'd0, mpenc_out} + strChunks;
						set_strCounter = 1'b1;
					end
					
					if (!isNullInStrA) begin  // No null chr, so get the next chunk
						nxstate = FTCHA;
						inc_strAloc = 1'b1;
						o_mem_addr = strAloc + 1'b1;
						o_mem_re = 1'b1;
						inc_strChunks = 1'b1;
					end
					else begin					 // Done
						nxstate = RSLT;
					end
				end
				STRCCHR: begin
					if (!isComparedAllOnes) begin
						amt_inc_strCounter = {27'd0, zcnt_out};
						inc_strCounter = 1'b1;
					end
					
					if (!isNullInStrA) begin  // No null chr, so get the next chunk
						nxstate = FTCHA;
						inc_strAloc = 1'b1;
						o_mem_addr = strAloc + 1'b1;
						o_mem_re = 1'b1;
					end
					else begin					 // Done
						nxstate = RSLT;
					end
				end
				STRSTR: begin // only supports 16 character substring
					if (isAllNullStrA) begin // no match
						nxstate = RSLT;
						neg_strCounter = 1'b1;
					end
					else if (isAllNullStrB) begin
						nxstate = RSLT; // use the result from previous
					end
					else if (!cmpr_out[0] && zerospenc_out == penc_out) begin // first null == first mismatch is a match
						nxstate = RSLT;
						if (strCounter == {32{1'b1}}) begin
							amt_strCounter = {16'd0, zpenc_out};// + strChunks;?
							set_strCounter = 1'b1;
						end
					end
					else if (!isComparedAllZeros) begin
						shift_stringA = 1'b1;
						inc_strCounter = 1'b1;
						amt_inc_strCounter = 32'd1;
						if (!isNullInStrA) begin
							en_strALenCounter = 1'b1;
							if (strAFetch) begin // going to need to get more of strA
								inc_strAloc = 1'b1;
								o_mem_addr = strAloc + 1'b1;
								o_mem_re = 1'b1;
							end
							else if (strASave) begin
								shift_stringA = 1'b0;
								append_stringA = 1'b1;
							end
						end
					end
					else begin
						nxstate = RSLT;
						neg_strCounter = 1'b1;
					end
				end
				default: nxstate = IDLE;
			endcase
		end

		RSLT: begin
			o_done = 1'b1;
			o_sreg_we = 1'b1;
			nxstate = IDLE;
			
			if (operation == STRCMP) begin
				return_strCmp = 1'b1;
			end
			else begin
				return_strCounter = 1'b1;
			end
			
			/*case (operation)
				STRLEN: begin
					return_strCounter = 1'b1;
				end
				STRCMP: begin
					return_strCmp = 1'b1;
				end
				STRCHR: begin
					return_strCounter = 1'b1;
				end
				STRRCHR: begin
					return_strCounter = 1'b1;
				end
				STRCCHR: begin
					return_strCounter = 1'b1;
				end
				STRSTR: begin
					return_strCounter = 1'b1;
				end
			endcase*/
		end
		
		default: nxstate = IDLE;
	endcase
end

always @(posedge clk or posedge rst) begin
	if (rst)
		state <= IDLE;
	else
		state <= nxstate;
end

endmodule
