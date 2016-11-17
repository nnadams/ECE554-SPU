`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:   ECE 554
// Engineer:  Nicolas Adams and Jonathan Brand
// 
// Create Date:	
// Design Name: 
// Module Name:	driver 
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
module driver(
	input clk,
	input rst,
	input [1:0] br_cfg,
	output iocs,
	output iorw,
	input rda,
	input tbr,
	output reg [1:0] ioaddr,
	inout [7:0] databus
	// output rx_err // Used for testing
	);

	localparam CFGL = 2'b00;
	localparam CFGH = 2'b01;
	localparam IDLE = 2'b10;
	localparam PROC = 2'b11;

	reg [7:0] divisorLow;
	reg [7:0] divisorHigh;

	reg read, write;
	reg [1:0] state, nxstate;
	reg [7:0] data;
	reg rx_err_reg;
	
	assign databus = ((ioaddr == 2'b10) ? divisorLow  :
			 (ioaddr == 2'b11)  ? divisorHigh :
			 (write)	    ? data	  : 8'hZZ);
	assign iorw = write ? 1'b0 : 1'b1;
	assign iocs = (ioaddr[1] | write) ? 1'b1 : 1'b0;

	// Data Flop from the SPART
	always @(posedge clk, posedge rst) begin
		if (rst)
		  data <= 8'd0;
		else if (read)
		  data <= databus;
	end

	// Start up state machine to load in the baud rate on reset
	// Only is in state CFGL and CFGH on reset. 
	always @(*) begin
		nxstate = IDLE;

		read = 1'b0;
		write = 1'b0;
		ioaddr = 2'b00;

		case (state)
			CFGL: begin
			  ioaddr = 2'b10;
			  nxstate = CFGH;
			end

			CFGH: begin
			  ioaddr = 2'b11;
			  nxstate = IDLE;
			end

			IDLE: begin
			  if (rda) begin
				nxstate = PROC;
			  	read = 1'b1;
				ioaddr = 2'b00;
			  end
			end

			PROC: begin
			  if (tbr) begin
				nxstate = IDLE;
				write = 1'b1;
				ioaddr = 2'b00;
			  end
			  else begin
			  	nxstate = PROC;
			  end
			end
		endcase
	end

	// Testing Register
	// always @(posedge clk, posedge rst) begin
	// if (rst)
	  // rx_err_reg <= 1'b0; 
	// else
	  // if (state == PROC && data != 8'h31) rx_err_reg <= 1'b1;
	  // else rx_err_reg <= rx_err_reg;
	// end
		
	assign rx_err = rx_err_reg;

	// State Flop
	always @(posedge clk, posedge rst) begin
		if (rst)
			state <= CFGL; // Start in config state
		else
			state <= nxstate;
	end

	// Load Val = 100MHz / Baud
	always @(*) begin
	  case (br_cfg)	
		// 4800 baud
		2'b00: begin
		  divisorLow = 8'h60;
		  divisorHigh = 8'h51;
		end
		// 9600 baud
		2'b01: begin
		  divisorLow  = 8'hcf;
		  divisorHigh = 8'h28;
		end
		// 19200 baud 
		2'b10: begin
		  divisorLow  = 8'h57;
		  divisorHigh = 8'h14;
		end
		// 38400 baud
		2'b11: begin
		  divisorLow  = 8'h2c;
		  divisorHigh = 8'h0A;
		end
		default: begin
		  divisorLow  = 8'h5f;
		  divisorHigh = 8'h51;
		end
	  endcase
	end

endmodule
