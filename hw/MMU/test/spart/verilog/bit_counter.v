`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:   ECE 554
// Engineer:  Nicolas Adams and Jonathan Brand
// 
// Create Date:    16:20:05 09/08/2016 
// Design Name: 
// Module Name:    bit_counter 
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
module bit_counter(
	input clk,
	input rst,
	input load,       // Load the bit counter with 0 
	input shift_en,   // Add 1 to the count
	output [3:0] bit_cnt
);

wire [3:0] bit_cnt_wire;
reg  [3:0] bit_cnt_reg;

assign bit_cnt = bit_cnt_reg;

// Counter
assign bit_cnt_wire = 
	(load == 1'b1) ? 4'b0000:
	(shift_en == 1'b1) ? bit_cnt + 1 : bit_cnt;	

// Flop
always @(posedge clk or posedge rst)
begin
	if(rst)	
		bit_cnt_reg <= 4'b0000;
	else 
		bit_cnt_reg <= bit_cnt_wire;
end

endmodule 
