`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:   ECE 554
// Engineer:  Nicolas Adams and Jonathan Brand
// 
// Create Date:    16:25:21 09/08/2016 
// Design Name: 
// Module Name:    transmit_control 
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

`define IDLE 2'b00
`define WAIT 2'b01
`define REC  2'b10

module receive_control(
	input clk, 
	input rst, 
	input RX,
	input baud,         // baud timer ran out - shift bit
	input half_baud,    // Half baud lets us sample the receive data at the correct time
	output clr_shifter, // load shift register on start of transmit
	output shift_en,    // Shift the shift register 
	output rdy,         // ready
	output rx_baud_rst, // reset the baud counter,
	output RX_stable
    );

wire [3:0]count; // current count of bits we have transmitted
reg [1:0] state;
reg [1:0] next_state;

// From State Machine
reg baud_rst; 
assign rx_baud_rst = baud_rst;

// Rdy signal is flopped
wire ff_set_rdy; 
reg rdy_reg; 
reg rx_done;
assign rdy = rdy_reg;

wire rx_negedge; 

reg rx_ff1, rx_ff2, rx_ff3;

reg clr_shifter_reg;
assign clr_shifter = clr_shifter_reg;

reg shift_en_reg; 
assign shift_en = shift_en_reg; 

reg load_ctr; 

// We want to output the RX signal to the shift register. 
// Ouput the Synchronous signal
assign RX_stable = rx_ff3;

// Track how many bits we have received
bit_counter BIT(	
			.clk(clk),
			.rst(rst),
			.load(load_ctr),
			.shift_en(baud),
			.bit_cnt(count)
		);

// Metastability eliminator since 
// RX is an async signal. 
// Flopped 3 times for negedge detector
always @(posedge clk or posedge rst)
	begin
		if(rst) begin
			rx_ff1 <= 1'b0;
			rx_ff2 <= 1'b0;
			rx_ff3 <= 1'b0;
		end
		else begin 
			rx_ff1 <= RX;
			rx_ff2 <= rx_ff1;
			rx_ff3 <= rx_ff2;
		end
	end

// Detect the start bit
assign rx_negedge = (~rx_ff2 & rx_ff3);
	
// State flop 
always @(posedge clk or posedge rst)
	begin
		if(rst)
			begin
			state <= `IDLE;
			end
		else 
			begin
			state <= next_state;
			end
	end

// RDY flop
always @(posedge clk or posedge rst)
	begin 
		if(rst)
			begin
			rdy_reg <= 0;
			end
		else
			begin 
			rdy_reg <= ff_set_rdy;
			end
	end

assign ff_set_rdy = rx_done;
	
// State transition logic
always @(*)
	begin
		next_state = `IDLE;
		baud_rst = 0;
		clr_shifter_reg = 0; 
		shift_en_reg = 0; 
		load_ctr = 0; 
		rx_done = 0;
		
		case(state)
			`IDLE:
				if(rx_negedge)
				begin
					baud_rst = 1;
					clr_shifter_reg = 1;
					next_state	= `WAIT;
				end
			   else
					next_state	= `IDLE;
			
			`WAIT:
				// Wait half a baud to get in the right position for reads
				if(half_baud)
				begin
					next_state = `REC;
					baud_rst = 1;
					load_ctr = 1;
				end
			   else
				begin
					next_state = `WAIT;
				end
			
			`REC:
				if(count != 4'd8)
				begin				
					next_state = `REC;
					if (baud)
					begin
						shift_en_reg = 1;
						baud_rst = 1;
					end
				end
				else 
				begin
					next_state = `IDLE;
					rx_done = 1;
				end
		endcase
	end
		
endmodule
