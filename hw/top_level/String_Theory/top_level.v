`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:07:48 11/17/2016 
// Design Name: 
// Module Name:    cpu_mmu_integration 
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
module top_level(
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
	wire [3:0] data_mem_wr;
	wire [3:0] data_mem_en;
	wire [31:0] instr_addr;
	wire HALTED; 
   
	// Inputs to CPU
	wire [31:0] data_mem_data;
	wire [31:0] instruction;
	wire HALT_CPU;
	
	// spart stuff
	wire trmt; 
	wire full; 
	wire [7:0] spart_tx_data;
	
	// Clk Count
	wire [63:0] clk_cnt; 
	
	// LED Config 
	led_controller leds(
		.clk(clk),
		.rst(rst),
		.led0(1'b0), .led0_triggered(1'b0),
		.led1(1'b0), .led1_triggered(1'b0),
		.led2(1'b0), .led2_triggered(1'b0),
		.led3(1'b0), .led3_triggered(1'b0),
		.led4(1'b0), .led4_triggered(1'b0),
		.led5(1'b0), .led5_triggered(1'b0),
		.led6(1'b0), .led6_triggered(1'b0),		
		.led7(1'b0), .led7_triggered(1'b0),
		.GPIO_LED_0(GPIO_LED_0),
		.GPIO_LED_1(GPIO_LED_1),
		.GPIO_LED_2(GPIO_LED_2),
		.GPIO_LED_3(GPIO_LED_3),
		.GPIO_LED_4(GPIO_LED_4),
		.GPIO_LED_5(GPIO_LED_5),
		.GPIO_LED_6(GPIO_LED_6),
		.GPIO_LED_7(GPIO_LED_7)
	);
	
	proc PROC (
		.clk(clk),
		.rst(rst),
		.data_mem_addr(data_mem_addr),
		.data_mem_write_data(data_mem_write_data),
		.data_mem_wr(data_mem_wr),
		.data_mem_en(data_mem_en),
		.instr_addr(instr_addr),
		.data_mem_data(data_mem_data),
		.instruction(instruction),
		.HALTED(HALTED),
		.spart_int(1'b0),
		.spu_int(1'b0),
		
		// TEST signal only, used to stall proc until 
		// Theres room in the fifo to send more uart data_mem_addr
		.SPART_STALL_DBG_ONLY(1'b0)
	);
	 
	 mmu_hier MMU(
		.clk(clk),
		.rst(rst),
		.PC(instr_addr),
		.cpu_wdata(data_mem_write_data),
		.cpu_addr(data_mem_addr),
		.cpu_en(data_mem_en),
		.cpu_we(data_mem_wr),
		.spu_wdata(128'd0),
		.spu_addr(32'd0),
		.spu_res_addr(4'd0),
		.spu_res_data(32'd0),
		.spart_tx_full(full),
		.spart_rx_empty(1'b1),
		.spart_rx_data(8'd0),
		
		.cpu_read_data(data_mem_data),
		.instruction(instruction),
		.spu_read_data(),
		.vga_data_1(),
		.vga_data_3(),
		.spart_tx_data(spart_tx_data),
		.spart_trmt(trmt)
	 );
	
	spart_tx_fifo spart(
		.clk(clk),
		.rst(rst),
		.write(trmt),
		.tx_data(spart_tx_data),
		.full(full), 
		.txd(txd)
	);	
	
	clk_counter clock_count(
		.clk(clk), 
		.rst(rst),
		.halt(HALTED), 
		.clk_cnt(clk_cnt)
	);
	
endmodule
