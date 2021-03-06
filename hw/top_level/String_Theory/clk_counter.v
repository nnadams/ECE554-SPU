`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:13:01 12/01/2016 
// Design Name: 
// Module Name:    clk_counter 
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
module clk_counter(
	input clk,
	input rst, 
	input soft_rst,
	output [63:0] clk_cnt
    );

	reg [63:0] _count; 
	assign clk_cnt = _count;
	
	always@(posedge clk, posedge rst) begin
		if(rst) _count <= 64'd0;
		else if(soft_rst) _count <= 64'd0;
		else _count <= _count + 1;
	end 
endmodule
