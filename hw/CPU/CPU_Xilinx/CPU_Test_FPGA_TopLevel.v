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
	output GPIO_LED_0, 
	output GPIO_LED_1, 
	output GPIO_LED_2, 
	output GPIO_LED_3, 
	output GPIO_LED_4, 
	output GPIO_LED_5, 
	output GPIO_LED_6, 
	output GPIO_LED_7, 
	output txd
);
	
	// Outputs From CPU 
	wire [31:0] data_mem_addr;
	wire [31:0] data_mem_write_data;
	wire data_mem_wr;
	wire data_mem_en;
	wire [31:0] instr_addr;
	wire HALTED; 
   
	// Inputs to CPU
	wire [31:0] data_mem_data;
	wire [31:0] instruction;
	wire HALT_CPU;
	
	// spart stuff
	wire trmt; 
	wire tbr; 
	wire real_data_mem_wr; 
	wire [31:0] real_data_read;
	
	assign real_data_mem_wr = (data_mem_addr != 32'h10000000 && data_mem_wr) ? 1'b1 : 1'b0;
	assign real_data_read =   (data_mem_addr == 32'h10000004) ?  {31'd0, tbr} : data_mem_data;
	
	// LED debug 
	assign GPIO_LED_0 = 0;//(instruction == 32'h00000010);
	assign GPIO_LED_1 = 0;//(instruction == 32'h200b0064);
	assign GPIO_LED_2 = 0;//(instruction == 32'h200c0064);
	assign GPIO_LED_3 = 0;//(instruction == 32'h200d00c8);
	assign GPIO_LED_4 = 0;//(instruction == 32'h43870000);
	assign GPIO_LED_5 = 0;//(instruction == 32'h47bb0000);
	assign GPIO_LED_6 = 0;//(instruction == 32'h3360fff8);
	assign GPIO_LED_7 = HALTED;//(instruction == 32'h00000000);
	
	proc PROC (
		.clk(clk),
		.rst(rst),
		.data_mem_addr(data_mem_addr),
		.data_mem_write_data(data_mem_write_data),
		.data_mem_wr(data_mem_wr),
		.data_mem_en(data_mem_en),
		.instr_addr(instr_addr),
		.data_mem_data(real_data_read),
		.instruction(instruction),
		.HALTED(HALTED),
		.spart_int(1'b0),
		.spu_int(1'b0),
		
		// TEST signal only, used to stall proc until 
		// Theres room in the fifo to send more uart data_mem_addr
		.SPART_STALL_DBG_ONLY(1'b0)
	);

	IMEM i_mem (
		.clka(clk),
        .rsta(rst),
		.addra(instr_addr),
		.douta(instruction)
	);
	
	DMEM d_mem(
		.clka(clk),
        .rsta(rst),
		.wea({4{real_data_mem_wr}}),
		.addra(data_mem_addr),
		.dina(data_mem_write_data),
		.douta(data_mem_data)
	);
/*
		memory2c #(0) d_mem(
		.data_out(data_mem_data),
		.data_in(data_mem_write_data),
		.addr(data_mem_addr),
		.enable(1'b1),
		.wr(real_data_mem_wr),
		.createdump(1'b0),
		.clk(clk),
		.rst(rst)
	);
	
	memory2c #(1) i_mem(
		.data_out(instruction),
		.data_in(32'h0),
		.addr(instr_addr),
		.enable(1'b1),
		.wr(1'b0),
		.createdump(1'b0),
		.clk(clk),
		.rst(rst)
	);
*/
	assign trmt = (data_mem_addr == 32'h10000000 && data_mem_wr) ? 1'b1 : 1'b0;
	
	spart_tx SPART(
		.clk(clk),
		.rst(rst),
		.trmt(trmt),
		.tx_data(data_mem_write_data[7:0]),
		.load_baud(1'b1),
		.baud_val(16'h0a2c),
      //.baud_val(16'h0010),
		.TBR(tbr), 
		.TX(txd)
	);
	
	
endmodule
