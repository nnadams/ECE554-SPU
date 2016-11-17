`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:   ECE 554
// Engineer:  Nicolas Adams and Jonathan Brand
// 
// Create Date:    18:20:50 09/08/2016 
// Design Name: 
// Module Name:    spart_rx 
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
module spart_rx(
	input clk, 
	input rst, 
	input RX, 
	input load_baud,
	input [15:0] baud_val,
	output [7:0] rx_data,
	output rdy
    );

wire baud;
wire clr_shifter;
wire shift_en; 
wire rx_baud_rst;
wire half_baud; 
wire RX_stable;

receive_control CTRL (
	.clk(clk),
	.rst(rst),
	.RX(RX),
	.baud(baud),
	.half_baud(half_baud),
	.clr_shifter(clr_shifter),
	.shift_en(shift_en),
	.rdy(rdy),
	.rx_baud_rst(rx_baud_rst),
	.RX_stable(RX_stable)
);

rx_shift_register SHFT(	
	.clk(clk),
	.rst(rst),
	.shift_en(shift_en),
	.rx_data(rx_data),
	.load_en(clr_shifter),
	.in_bit(RX_stable)
);
					
baud_rate_generator BR (
	.clk(clk),
	.rst(rst),
	.rst_baud(rx_baud_rst),
	.load_baud(load_baud),
	.load_val(baud_val), 
	.shift(baud),
	.half_baud(half_baud)
);	
	
endmodule
