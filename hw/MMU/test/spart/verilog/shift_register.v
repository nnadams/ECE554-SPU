`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:   ECE 554
// Engineer:  Nicolas Adams and Jonathan Brand
// 
// Create Date:    16:16:39 09/08/2016 
// Design Name: 
// Module Name:    shift_register.v 
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
module shift_register(
	input clk,
	input rst,
	input shift_en,
	input [7:0] tx_data,
	input load_en,
	output out_bit
	);

/// Variable Definitions
reg	  [9:0] data;
wire  [9:0] data_wire;

// Load the data with the start and stop bit
// Always shift in 1's to keep TX high 
assign data_wire = 
	(load_en==1)  ? {1'b1, tx_data, 1'b0} :
	(shift_en==1) ? {1'b1, data[9:1]}     : data;

///Sequential Block to store value in register
always @(posedge clk or posedge rst)
	begin
		if(rst)
			// Reset so TX is always high when not trmting
			data <= 10'hfff;
		else 
			data <= data_wire;
	end
	
assign out_bit=data[0];

endmodule 
