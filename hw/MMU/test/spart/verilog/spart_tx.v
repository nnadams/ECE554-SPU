`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:   ECE 554
// Engineer:  Nicolas Adams and Jonathan Brand
// 
// Create Date:    16:08:53 09/08/2016 
// Design Name: 
// Module Name:    spart_tx 
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
module spart_tx(
	input clk, 
	input rst, 
	input trmt,            // Transmit signal. High for one clk to initiate transfer
	input [7:0] tx_data,   // Data to send, must be valid when trmt high
	input load_baud,       // Active high to load the baud reg
	input [15:0] baud_val, // Value to load into the baud reg 
	output TBR,            // Transmit ready
	output TX              // Output signal
);

wire shift;
wire tx_baud_rst;

// State Machine control module. 
// Controls the start, bit shifting, and other signals. 
transmit_control TX_CTRL(
	.clk(clk),
	.rst(rst),
	.trmt(trmt), 
	.shift(shift),
	.load(load), 
	.TBR(TBR),
	.tx_baud_rst(tx_baud_rst)
);

// Shift register holds our transmitting data and 
// shifts when the control module tells it to. The TX signal 
// is always the LSb of this register. Handles start and stop bits.
shift_register SHIFT(
	.clk(clk),
	.rst(rst),
	.shift_en(shift),
	.tx_data(tx_data),
	.load_en(load),
	.out_bit(TX)
	);

// Our TX baud generator. Switch the bit on the shift signal.
baud_rate_generator BR (
	.clk(clk),
	.rst(rst),
	.rst_baud(tx_baud_rst),
	.load_baud(load_baud),
	.load_val(baud_val),
	.shift(shift),
	.half_baud()
);
	
endmodule