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
	wire HALTED; 
   
	// Inputs to CPU
	wire [31:0] data_mem_data;
	wire [31:0] instruction;
	wire HALT_CPU;
	
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
		.HALTED(HALTED),
		
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

	cpu_trace trace(
		.clk(clk),
		.rst(rst),
		.instruction(instruction),
		.data_mem_addr(data_mem_addr),
		.data_mem_write_data(data_mem_write_data),
		.data_mem_wr(data_mem_wr),
		.tx(txd),
		.HALT_CPU(HALT_CPU)
	);
	
endmodule
