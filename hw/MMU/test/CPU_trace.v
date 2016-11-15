module cpu_trace(
	input clk, 
	input rst,
	input [31:0] data1, 
	input [31:0] data2,
	input [31:0] data3, 
	input [31:0] data4,
	input [31:0] data5, 
	input [31:0] data6,
	input data_mem_wr,
	input CPU_HALTED,
	output tx, 
	output HALT_CPU
);

   	reg [2:0] state;
	reg [2:0] next_state; 
	reg _HALT_CPU; 
	
	wire [63:0] fifo_data; 
	wire  [7:0] tx_data;
	reg fifo_wr; 
	reg fifo_rd; 
	wire full;
	wire fifo_empty; 
	reg [31:0] cnt; 
	reg trmt; 
	wire tbr; 
	reg rst_cnt;
	 
	assign HALT_CPU = _HALT_CPU;
	
	// State machine for CPU Debug 
	always @(posedge clk, posedge rst) begin
		if(rst) state <= 0;
		else state <= next_state;
	end
	
	// Counter so we dont overflow serial 
	always @(posedge clk, posedge rst) begin
		if(rst) cnt <= 0;
		else if(rst_cnt) cnt <= 0;
		else cnt <= cnt + 1;
	end
	
	// Output and Transition Logic 
	always @(*) begin
		_HALT_CPU = 1; 
		fifo_wr = 0; 
		fifo_rd = 0; 
		trmt = 0; 
		rst_cnt = 0; 
		next_state = 4'b000;
		
		case(state) 
			// WAIT State 
			4'b0000: begin
				if(fifo_empty & tbr & ~CPU_HALTED)begin
					_HALT_CPU = 0;
					next_state = 4'b0001;  //Run CPU state
				end 
				else if(~fifo_empty & tbr & ~CPU_HALTED) begin
					rst_cnt = 1; 
					next_state = 4'b1111; // WAIT WAIT state
				end
				else
					next_state = 4'b0000; // WAIT state
			end
			
			// WAIT WAIT 
			4'b1111: begin 
				if (cnt > 32'd00100000)
					next_state = 4'b1101; // Read FIFO state
				else 
					next_state = 4'b1111; // WAIT state
			end
			
			// Read FIFO State 
			4'b1101: begin
				fifo_rd = 1; 
				next_state = 4'b1110; // Transmite state
			end 
			
			// Initiate Transaction State
			4'b1110: begin 
				trmt = 1; 
				next_state = 4'b0000; // WAIT state
			end

			// Cpu runs for this cycle. Halt next and store data1 in fifo. 
			4'b0001: begin // write data1 to FIFO
				fifo_wr = 1;
				next_state = 4'b0010; // 
			end
			
			4'b0010: begin // write data2 to FIFO
				fifo_wr = 1;
				next_state = 4'b0011; // store state
			end 

			// Cpu runs for this cycle. Halt next and store data1 in fifo. 
			4'b0011: begin // write data3 to FIFO
				fifo_wr = 1;
				next_state = 4'b0111; // 
			end
			
			4'b0100: begin // write data4 to FIFO
				fifo_wr = 1;
				next_state = 4'b0101; // store state
			end 

			// Cpu runs for this cycle. Halt next and store data1 in fifo. 
			4'b0101: begin // write data5 to FIFO
				fifo_wr = 1;
				next_state = 4'b0110; // 
			end
			
			4'b0110: begin // write data6 to FIFO
				fifo_wr = 1;
				next_state = 4'b0111; // store state
			end
			
			4'b0111: begin // write new line to the FIFO
				fifo_wr = 1;
				next_state = 4'b0000; 
			end	
			
			default: begin 
				next_state = 0; 
			end
		endcase	
	end
	
	reg print_new_line; 
	
	reg [3:0] d0; 
	reg [3:0] d1; 
	reg [3:0] d2; 
	reg [3:0] d3; 
	reg [3:0] d4; 
	reg [3:0] d5; 
	reg [3:0] d6; 
	reg [3:0] d7; 
	
	wire [7:0] a0; 
	wire [7:0] a1; 
	wire [7:0] a2; 
	wire [7:0] a3; 
	wire [7:0] a4; 
	wire [7:0] a5; 
	wire [7:0] a6; 
	wire [7:0] a7; 
	
	Bin2Ascii b2a0 (.bin(d0), .ascii(a0));
	Bin2Ascii b2a1 (.bin(d1), .ascii(a1));
	Bin2Ascii b2a2 (.bin(d2), .ascii(a2));
	Bin2Ascii b2a3 (.bin(d3), .ascii(a3));
	Bin2Ascii b2a4 (.bin(d4), .ascii(a4));
	Bin2Ascii b2a5 (.bin(d5), .ascii(a5));
	Bin2Ascii b2a6 (.bin(d6), .ascii(a6));
	Bin2Ascii b2a7 (.bin(d7), .ascii(a7));

	wire [7:0] real_a0; 
	wire [7:0] real_a1; 
    
	// carraige return
	assign real_a0 = print_new_line ? 8'h0d : a0;
	// new line 
    assign real_a1 = print_new_line ? 8'h0a : a1;
    
	assign fifo_data = {a7,a6,a5,a4,a3,a2,real_a1,real_a0};
	
	// Fifo Data 
	always @(*) begin
		d7 = 0;
		d6 = 0;
		d5 = 0;
		d4 = 0;
		d3 = 0;
		d2 = 0;
		d1 = 0;
		d0 = 0;
		print_new_line = 0;
		
		case(state)
			4'b0001: begin 
				d7 = data1[31:28];
				d6 = data1[27:24];
				d5 = data1[23:20];
				d4 = data1[19:16];
				d3 = data1[15:12];
				d2 = data1[11:8];
				d1 = data1[7:4];
				d0 = data1[3:0];
			end 
			4'b0010: begin 
				d7 = data2[31:28];
				d6 = data2[27:24];
				d5 = data2[23:20];
				d4 = data2[19:16];
				d3 = data2[15:12];
				d2 = data2[11:8];
				d1 = data2[7:4];
				d0 = data2[3:0];
			end 
			4'b0011: begin 
				d7 = data3[31:28];
				d6 = data3[27:24];
				d5 = data3[23:20];
				d4 = data3[19:16];
				d3 = data3[15:12];
				d2 = data3[11:8];
				d1 = data3[7:4];
				d0 = data3[3:0];
			end 
			4'b0100: begin 
				d7 = data4[31:28];
				d6 = data4[27:24];
				d5 = data4[23:20];
				d4 = data4[19:16];
				d3 = data4[15:12];
				d2 = data4[11:8];
				d1 = data4[7:4];
				d0 = data4[3:0];
			end 
			4'b0101: begin 
				d7 = data5[31:28];
				d6 = data5[27:24];
				d5 = data5[23:20];
				d4 = data5[19:16];
				d3 = data5[15:12];
				d2 = data5[11:8];
				d1 = data5[7:4];
				d0 = data5[3:0];
			end
			4'b0110: begin 
				d7 = data6[31:28];
				d6 = data6[27:24];
				d5 = data6[23:20];
				d4 = data6[19:16];
				d3 = data6[15:12];
				d2 = data6[11:8];
				d1 = data6[7:4];
				d0 = data6[3:0];
			end
			4'b0111: begin 
				print_new_line = 1;
				d2 = {3'b000,data_mem_wr};
			end 
			default: begin 
				d7 = 0;
				d6 = 0;
				d5 = 0;
				d4 = 0;
				d3 = 0;
				d2 = 0;
				d1 = 0;
				d0 = 0;
			end 
		
		endcase 	
	end 

	// SPART Fifo Tx data
/*module SPART_FIFO(
  rst,
  wr_clk,
  rd_clk,
  din,
  wr_en,
  rd_en,
  dout,
  full,
  empty
);*/
	SPART_FIFO tx_fifo(
		.rst(rst),
		.wr_clk(clk),
		.rd_clk(clk),
		.din(fifo_data),
		.wr_en(fifo_wr),
		.rd_en(fifo_rd),
		.dout(tx_data),
		.full(full),
		.empty(fifo_empty)
	);

	spart_tx SPART(
		.clk(clk),
		.rst(rst),
		.trmt(trmt),
		.tx_data(tx_data),
		.load_baud(1'b1),
		.baud_val(16'h0a2c),
		.TBR(tbr), 
		.TX(tx)
	);
	
endmodule
