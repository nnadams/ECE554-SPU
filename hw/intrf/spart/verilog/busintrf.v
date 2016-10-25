`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:   ECE 554
// Engineer:  Nicolas Adams and Jonathan Brand
// 
// Create Date:    16:20:05 09/08/2016 
// Design Name: 
// Module Name:    busintrf 
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
module busintrf(
	input iocs,
	input iorw,
	input rda,
	input tbr,
	input [1:0] ioaddr,
	input [7:0] dataout,
	output reg [7:0] datain,
	inout [7:0] databus
	);

	reg out;
	reg [7:0] busout;

	// If we're not sending data, we put the BUS high Z so we can receive
	assign databus = out ? busout : 8'hZZ;

	// Output assignments - output either the 
	// RX data or TBR and RDA.
	always @(*) begin
		out = 1'b0;
		busout = 8'h00;
		datain = 8'h00;
		
		case (ioaddr)
			2'b00: begin
				if (iorw) begin			
					out = 1'b1;
					busout = dataout;
				end
				else
					datain = databus;
			end
			2'b01: begin
				if (iorw) begin
					out = 1'b1;
					busout = {6'h00, tbr, rda};
				end
			end
			default: begin
				datain = databus;
			end
		endcase
	end

endmodule
