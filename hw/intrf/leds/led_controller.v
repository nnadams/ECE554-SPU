`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:21:57 12/01/2016 
// Design Name: 
// Module Name:    leds 
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
module led_controller(
	input clk, 
	input rst,
	input led0,
	input led0_triggered,
	input led1,
	input led1_triggered,
	input led2,
	input led2_triggered,
	input led3,
	input led3_triggered,
	input led4,
	input led4_triggered,
	input led5,
	input led5_triggered,
	input led6,
	input led6_triggered,
	input led7,
	input led7_triggered,
	output GPIO_LED_0, 
	output GPIO_LED_1, 
	output GPIO_LED_2, 
	output GPIO_LED_3, 
	output GPIO_LED_4, 
	output GPIO_LED_5, 
	output GPIO_LED_6, 
	output GPIO_LED_7
    );
	 
	reg _led0;
	reg _led1;
	reg _led2;
	reg _led3;
	reg _led4;
	reg _led5;
	reg _led6;
	reg _led7;

	assign GPIO_LED_0 = _led0; 
	assign GPIO_LED_1 = _led1; 
	assign GPIO_LED_2 = _led2; 
	assign GPIO_LED_3 = _led3; 
	assign GPIO_LED_4 = _led4; 
	assign GPIO_LED_5 = _led5; 
	assign GPIO_LED_6 = _led6; 
	assign GPIO_LED_7 = _led7; 
	
	always@(posedge clk, posedge rst) begin
		if(rst) _led0 <= 0; 
		else if(led0) _led0 <= 1;
		else if(led0_triggered) _led0 <= _led0; 
		else _led0 <= led0;
	end 
	
	always@(posedge clk, posedge rst) begin
		if(rst) _led1 <= 0; 
		else if(led1) _led1 <= 1;
		else if(led1_triggered) _led1 <= _led1; 
		else _led1 <= led1;
	end 
	
	always@(posedge clk, posedge rst) begin
		if(rst) _led2 <= 0; 
		else if(led2) _led2 <= 1;
		else if(led2_triggered) _led2 <= _led2; 
		else _led2 <= led2;
	end
	
	always@(posedge clk, posedge rst) begin
		if(rst) _led3 <= 0; 
		else if(led3) _led3 <= 1;
		else if(led3_triggered) _led3 <= _led3; 
		else _led3 <= led3;
	end 
	
	always@(posedge clk, posedge rst) begin
		if(rst) _led4 <= 0; 
		else if(led4) _led4 <= 1;
		else if(led4_triggered) _led4 <= _led4; 
		else _led4 <= led4;
	end 
	
	always@(posedge clk, posedge rst) begin
		if(rst) _led5 <= 0; 
		else if(led5) _led5 <= 1;
		else if(led5_triggered) _led5 <= _led5; 
		else _led5 <= led5;
	end 
	
	always@(posedge clk, posedge rst) begin
		if(rst) _led6 <= 0; 
		else if(led6) _led6 <= 1;
		else if(led6_triggered) _led6 <= _led6; 
		else _led6 <= led6;
	end 

	always@(posedge clk, posedge rst) begin
		if(rst) _led7 <= 0; 
		else if(led7) _led7 <= 1;
		else if(led7_triggered) _led7 <= _led7; 
		else _led7 <= led7;
	end

endmodule
