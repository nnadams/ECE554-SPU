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
	
	// spart stuff
	wire trmt; 
	wire tbr; 
	wire real_data_mem_wr; 
	wire [31:0] real_data_read;
	
	assign real_data_mem_wr = (data_mem_addr != 32'h10000000 && data_mem_wr) ? 1'b1 : 1'b0;
	assign real_data_read =   (data_mem_addr == 32'h10000004) ?  {31'd0, tbr} : data_mem_data;
	
	proc PROC (
		.clk(clk),
		.rst(rst),
		.data_mem_addr(data_mem_addr),
		.data_mem_write_data(data_mem_write_data),
		.data_mem_wr(data_mem_wr),
		.data_mem_en(data_mem_en),
		.PC_curr(PC_curr),
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
		.addra(PC_curr),
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
