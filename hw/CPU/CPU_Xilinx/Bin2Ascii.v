//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:15:55 10/25/2016 
// Design Name: 
// Module Name:    Bin2Ascii 
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
module Bin2Ascii(
		input [3:0] bin,
		output [7:0] ascii
    );
	 
	reg [3:0] _ascii; 
	assign ascii = _ascii; 
	
	always@(*) begin
		_ascii = 0; 
		
		case(bin)	
			4'h0: begin 
			_ascii = 8'h30;
			end
			4'h1: begin 
			_ascii = 8'h31;
			end
			4'h2: begin 
			_ascii = 8'h32;
			end
			4'h3: begin 
			_ascii = 8'h33;
			end
			4'h4: begin 
			_ascii = 8'h34;
			end
			4'h5: begin 
			_ascii = 8'h35;
			end
			4'h6: begin 
			_ascii = 8'h36;
			end
			4'h7: begin 
			_ascii = 8'h37;
			end
			4'h8: begin 
			_ascii = 8'h38;
			end
			4'h9: begin 
			_ascii = 8'h39;
			end
			4'ha: begin 
			_ascii = 8'h41;
			end
			4'hb: begin 
			_ascii = 8'h42;
			end
			4'hc: begin 
			_ascii = 8'h43;
			end
			4'hd: begin 
			_ascii = 8'h44;
			end
			4'he: begin 
			_ascii = 8'h45;
			end
			4'hf: begin 
			_ascii = 8'h46;
			end
			default: begin
			_ascii = 8'h00;
			end
		endcase
	end
endmodule
