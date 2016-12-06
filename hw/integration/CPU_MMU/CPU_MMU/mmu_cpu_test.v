`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:12:12 11/17/2016 
// Design Name: 
// Module Name:    mmu_cpu_test 
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
module mmu_cpu_test(
    );

	reg clk; 
	reg rst; 
	wire tx; 
	wire GPIO_LED_0; 
	wire GPIO_LED_1; 
	wire GPIO_LED_2; 
	wire GPIO_LED_3; 
	wire GPIO_LED_4; 
	wire GPIO_LED_5; 
	wire GPIO_LED_6; 
	wire GPIO_LED_7; 
	
	initial begin 
		clk = 0; 
		rst = 1; 
		
		repeat (5) @(posedge clk);
		rst = 0;
	end
	
	always #5 clk = ~clk; 
	
	always @(posedge clk) begin
		if(GPIO_LED_7) $stop;
	end 
	
    cpu_mmu_integration DUT(
	 .clk(clk), 
	 .rst(rst),
	 .txd(txd),
	 .GPIO_LED_0(GPIO_LED_0), 
	 .GPIO_LED_1(GPIO_LED_1),  
	 .GPIO_LED_2(GPIO_LED_2), 
	 .GPIO_LED_3(GPIO_LED_3), 
	 .GPIO_LED_4(GPIO_LED_4), 
	 .GPIO_LED_5(GPIO_LED_5), 
	 .GPIO_LED_6(GPIO_LED_6), 
	 .GPIO_LED_7(GPIO_LED_7)
	 );


endmodule
