`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:   ECE 554
// Engineer:  Nicolas Adams and Jonathan Brand
// 
// Create Date:    16:03:00 09/08/2016 
// Design Name: 
// Module Name:    baud_rate_generator 
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
module baud_rate_generator(
	input clk, 
	input rst,
	input rst_baud,
	input load_baud,
	input [15:0] load_val,
	output shift,
	output half_baud
    );

wire [15:0] baud_cnt_wire;
reg  [15:0] baud_cnt;

reg  [15:0] baud; 
wire [15:0] baud_wire; 

// Current baud count flop - counts down to 0.
assign baud_cnt_wire = (rst_baud == 1'b1) ? baud : (baud_cnt + -1);
always @(posedge clk or posedge rst)
begin
	if(rst)		
		baud_cnt <= 16'hffff;
	else 
		baud_cnt <= baud_cnt_wire;
end


// Baud Rate Register which holds our starting value
assign baud_wire = (load_baud == 1'b1) ? load_val : baud;
always @(posedge clk or posedge rst)
begin
	if(rst)		
		baud <= 16'hffff; // default to some value
	else 
		baud <= baud_wire;
end

// Output Assignments
assign shift = (baud_cnt==0) ? 1'b1 : 1'b0;
assign half_baud = (baud_cnt == baud >> 1) ? 1'b1 : 1'b0;

endmodule 
