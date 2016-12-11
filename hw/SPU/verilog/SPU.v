module SPU(
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

output o_done;
output o_sreg_we;
output [3:0] o_sreg_addr;
output [31:0] o_mem_addr, o_sreg_data;

localparam INIT  = 3'd0;
localparam IDLE  = 3'd1;
localparam WAIT  = 3'd2;

reg done;
reg nxtjob, start_job, rst_done, set_done, en_waitCounter, clr_waitCounter;
reg [2:0] state, nxstate;

wire instr_full, instr_empty, minWait_done, core1_done;
wire [3:0] operation, destination;
wire [7:0] immediate;
wire [31:0] strAloc, strBloc;
wire [79:0] fifo_in, fifo_out;

assign fifo_in = {i_op, i_dest, i_imm, i_strAlocation, i_strBlocation};
assign {operation, destination, immediate, strAloc, strBloc} = fifo_out;

reg prev_done;
assign o_done = done & !prev_done;
always @(posedge clk or posedge rst) begin
    if (rst)
      prev_done <= 1'b0;
    else
      prev_done <= done;
end


instr_fifo ififo (
  .clk(clk),
  .rst(rst),
  .din(fifo_in),
  .wr_en(i_start),
  .rd_en(nxtjob),
  .dout(fifo_out),
  .full(instr_full),
  .empty(instr_empty)
);

SPUCore core1 (
  .clk(clk),
  .rst(rst),
  .i_start(start_job),
  .i_op(operation),
  .i_dest(destination),
  .i_imm(immediate),
  .i_strAlocation(strAloc),
  .i_strBlocation(strBloc),
  .i_mem_data(i_mem_data),
  .o_mem_addr(o_mem_addr),
  .o_mem_re(), // no need for this?
  .o_sreg_data(o_sreg_data),
  .o_sreg_addr(o_sreg_addr),
  .o_sreg_we(o_sreg_we),
  .o_done(core1_done)
);

UpCounter #(.LIMIT(2), .MAXBITS(2)) waitcounter (
  .clk(clk),
  .rst(rst),
  .i_en(en_waitCounter),
  .i_clear(clr_waitCounter),
  .o_value(),
  .o_done(minWait_done)
);

always @(posedge clk or posedge rst) begin
	if (rst)
		done <= 1'b0;
	else if (set_done || core1_done)
		done <= 1'b1;
	else if (rst_done)
		done <= 1'b0;
end

always @(posedge clk or posedge rst) begin
	if (rst)
		state <= INIT;
	else
		state <= nxstate;
end

always @(*) begin
	nxstate = state;
	
	nxtjob = 1'b0;
	start_job = 1'b0;
	set_done = 1'b0;
	rst_done = 1'b0;
	en_waitCounter = 1'b0;
	clr_waitCounter = 1'b0;
	
	case (state)
		INIT: begin
			nxstate = IDLE;
			set_done = 1'b1;
		end
		IDLE: begin
			if (!instr_empty && done) begin
				nxstate = WAIT;
				nxtjob = 1'b1;
				rst_done = 1'b1;
				clr_waitCounter = 1'b1;
			end
		end
		
		WAIT: begin
			start_job = 1'b1;
			en_waitCounter = 1'b1;
			if (minWait_done) begin
				nxstate = IDLE;
			end
		end
		
		default: begin
			nxstate = INIT;
		end
	endcase
end

endmodule
