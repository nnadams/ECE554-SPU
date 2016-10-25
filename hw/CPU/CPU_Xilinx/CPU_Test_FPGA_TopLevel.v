`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:37:30 10/25/2016 
// Design Name: 
// Module Name:    CPU_Test_FPGA_TopLevel 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module CPU_Test_FPGA_TopLevel(
	input clk, 
	input rst,
	output txd
);
	
   // Outputs From CPU 
   wire [31:0] data_mem_addr;
   wire [31:0] data_mem_write_data;
   wire data_mem_wr;
   wire data_mem_en;
   wire [31:0] PC_curr;
   
   // Inputs to CPU
   wire [31:0] data_mem_data;
   wire [31:0] instruction;

   	reg [2:0] state;
	reg [2:0] next_state; 
	reg HALT_CPU;
	
	wire [63:0] fifo_data; 
	wire  [7:0] tx_data;
	reg fifo_wr; 
	reg fifo_rd; 
	wire full;
	wire fifo_empty; 
	
	
	reg trmt; 
	wire tbr; 
	
	
	proc PROC (
		.clk(clk),
		.rst(rst),
		.data_mem_addr(data_mem_addr),
		.data_mem_write_data(data_mem_write_data),
		.data_mem_wr(data_mem_wr),
		.data_mem_en(data_mem_en),
		.PC_curr(PC_curr),
		.data_mem_data(data_mem_data),
		.instruction(instruction),
		
		// TEST signal only, used to stall proc until 
		// Theres room in the fifo to send more uart data_mem_addr
		.SPART_STALL_DBG_ONLY(HALT_CPU)
	);

	IMEM i_mem (
		.clka(clk),
		.addra(PC_curr),
		.douta(instruction)
	);
	
	DMEM d_mem(
		.clka(clk),
		.ena(data_mem_en),
		.wea({4{data_mem_wr}}),
		.addra(data_mem_addr),
		.dina(data_mem_write_data),
		.douta(data_mem_data)
	);

	// SPART Fifo Tx data
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
		.baud_val(16'h515f),
		.TBR(tbr), 
		.TX(txd)
	);
	

	// State machine for CPU Debug 
	always @(posedge clk, posedge rst) begin
		if(rst) state <= 0;
		else state <= next_state;
	end

	// Output and Transition Logic 
	always @(*) begin
		HALT_CPU = 0; 
		next_state = 2'b00;
		trmt = 0; 
		fifo_rd = 0; 
		fifo_wr = 0; 
		
		case(state) 
			3'b000: begin
				if(fifo_empty)begin
					next_state = 2'b01;
					HALT_CPU = 0; 
				end 
				else begin
					next_state = 2'b00;
					HALT_CPU = 1; 
					trmt = tbr;
					fifo_rd = tbr; 
				end
			end
			
			// Cpu runs for this cycle. Halt next and store instruction in fifo. 
			3'b001: begin
				HALT_CPU = 1; 
				next_state = 3'b010;
				fifo_wr = 1;
			end
			
			3'b010: begin
				HALT_CPU = 1;  
				next_state = 3'b010; 
				fifo_wr = 1;
			end 
			
			3'b011: begin 
				HALT_CPU = 1; 
				next_state = 3'b100; 
				fifo_wr = 1;
			end	
			
			3'b100: begin 
				HALT_CPU = 1; 
				next_state = 3'b000; 
				fifo_wr = 1;
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

	wire real_a7; 
	wire real_a6; 
	
	// Carrigae return 
	assign real_a7 = print_new_line ? 8'h0d : a7;
	// new line
	assign real_a6 = print_new_line ? 8'h0a : a6;
	
	assign fifo_data = {real_a7,real_a6,a5,a4,a3,a2,a1,a0};
	
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
			3'b001: begin 
				d7 = instruction[31:28];
				d6 = instruction[27:24];
				d5 = instruction[23:20];
				d4 = instruction[19:16];
				d3 = instruction[15:12];
				d2 = instruction[11:8];
				d1 = instruction[7:4];
				d0 = instruction[3:0];
			end 
			3'b010: begin 
				d7 = data_mem_addr[31:28];
				d6 = data_mem_addr[27:24];
				d5 = data_mem_addr[23:20];
				d4 = data_mem_addr[19:16];
				d3 = data_mem_addr[15:12];
				d2 = data_mem_addr[11:8];
				d1 = data_mem_addr[7:4];
				d0 = data_mem_addr[3:0];
			end 
			3'b011: begin 
				d7 = data_mem_write_data[31:28];
				d6 = data_mem_write_data[27:24];
				d5 = data_mem_write_data[23:20];
				d4 = data_mem_write_data[19:16];
				d3 = data_mem_write_data[15:12];
				d2 = data_mem_write_data[11:8];
				d1 = data_mem_write_data[7:4];
				d0 = data_mem_write_data[3:0];
			end 		
			3'b100: begin
				print_new_line = 1;
				d0 = {3'b000,data_mem_wr};
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
	
endmodule
