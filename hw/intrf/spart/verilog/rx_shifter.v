`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:   ECE 554
// Engineer:  Nicolas Adams and Jonathan Brand
// 
// Create Date:    16:20:05 09/08/2016 
// Design Name: 
// Module Name:    rx_shift_register 
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
module rx_shift_register(
	input clk,
	input rst,
	input shift_en, // shift the data in
	input load_en,  // load the shift register with 0
	input in_bit,   // bit to shift in 
	output [7:0] rx_data // current data
);

reg [7:0]data;
wire [7:0] data_wire;

// Data assignment, take data when the control unit tells us
assign data_wire =
	(load_en == 1) ? 8'd0 :
	(shift_en == 1) ? {in_bit,data[7:1]} : data;

// Flop always takes the combination assignment
always @(posedge clk or posedge rst)
	begin
		if(rst)
			data<=8'h00;
		else 
			data<=data_wire;
	end

assign rx_data=data;

endmodule 
