`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:40:08 11/29/2016 
// Design Name: 
// Module Name:    test 
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
module test(
    );

	reg clk; 
	reg rst;
	wire GPIO_LED_0; 
	wire GPIO_LED_1; 
	wire GPIO_LED_2; 
	wire GPIO_LED_3; 
	wire GPIO_LED_4; 
	wire GPIO_LED_5; 
	wire GPIO_LED_6; 
	wire GPIO_LED_7; 
	wire txd;
	
cpu_mmu_integration DUT(
	.clk(clk), 
	.rst(rst),
	.GPIO_LED_0(GPIO_LED_0), 
	.GPIO_LED_1(GPIO_LED_1),  
	.GPIO_LED_2(GPIO_LED_2),  
	.GPIO_LED_3(GPIO_LED_3), 
	.GPIO_LED_4(GPIO_LED_4), 
	.GPIO_LED_5(GPIO_LED_5),  
	.GPIO_LED_6(GPIO_LED_6),  
	.GPIO_LED_7(GPIO_LED_7),  
	.txd(txd)
);


   initial begin
      clk = 0; 
      rst = 1; 
      repeat (5) @(posedge clk);
      rst = 0; 
   end
	
	   
   always #5 clk = ~clk;
	
endmodule
