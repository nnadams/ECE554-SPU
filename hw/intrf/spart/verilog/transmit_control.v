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

`define IDLE 1'b0
`define TX_EN 1'b1

module transmit_control(
	input clk, 
	input rst, 
	input trmt,  // to start transmit
	input shift, // baud timer ran out - shift bit
	output load,        // load shift register on start of transmit
	output TBR,        // ready
	output tx_baud_rst // reset the baud counter
    );

wire [3:0]count; // current count of bits we have transmitted
wire ff_set_TBR; // TBR needs to retain state.
reg tx_done;

reg state, next_state;

reg TBR_out; 
reg baud_rst; 
reg load_out; 

assign load = load_out; 
assign tx_baud_rst = baud_rst;
assign TBR = TBR_out; 

// Track how many bits we have sent
bit_counter BIT(	
			.clk(clk),
			.rst(rst),
			.load(load),
			.shift_en(shift),
			.bit_cnt(count)
		);
		
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

// TBR flop
always @(posedge clk or posedge rst)
	begin 
		if(rst)
			begin
			TBR_out <= 1;
			end
		else
			begin 
			TBR_out <= ff_set_TBR;
			end
	end

// TBR flop input. Two possible transitions, otherwise retain state:
// 1. Transmit starts - we want to signal we are busy
// 2. Transmit ends - go high to signal we are ready
assign ff_set_TBR =
	(trmt == 1'b1)    ? 1'b0 :
    (tx_done == 1'b1) ? 1'b1 : TBR;
	
// State transition logic
always @(*)
	begin
		next_state = `IDLE;
		baud_rst = 0;
		load_out = 0;
		tx_done = 0; 
		
		case(state)
			`IDLE:
				if(trmt)
				begin
					load_out = 1;
					baud_rst = 1;	
					next_state	= `TX_EN;
				end
			   else
					next_state	= `IDLE;
			
			`TX_EN:
				if(count!=4'd9)
				begin
					if(shift)
					begin
						baud_rst	= 1;
						next_state = `TX_EN;
					end
					else
					begin
						baud_rst = 0;
						next_state = `TX_EN;
					end
					end
			   else
					begin
					tx_done = 1;
					next_state = `IDLE;
					end
			endcase
		end
		
endmodule
