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
	reg trmt; 
	wire tbr;
	reg [7:0] tx_data; 
	wire GPIO_LED_0; 
	wire GPIO_LED_1; 
	wire GPIO_LED_2; 
	wire GPIO_LED_3; 
	wire GPIO_LED_4; 
	wire GPIO_LED_5; 
	wire GPIO_LED_6; 
	wire GPIO_LED_7; 
	wire txd;
	wire rxd;
	
top_level DUT(
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
	.txd(txd),
	.rxd(rxd),
	.spu_int(1'b0)
);

spart_tx test_spart(
	.clk(clk),
	.rst(rst),
	.trmt(trmt),
	.tx_data(tx_data),
	.load_baud(1'b1),
	.baud_val(16'h10),
	.TBR(tbr),
	.TX(rxd)
);


   initial begin
      clk = 0; 
      rst = 1; 
		trmt = 0; 
		tx_data = 8'd03;
      repeat (5) @(posedge clk);
      rst = 0;
		repeat (20) @(posedge clk);
		
		trmt = 1;
		@(posedge clk);
		trmt = 0;
		
        tx_data = 8'd97; 
		@(posedge tbr); 
		repeat (50) @(posedge clk);
		trmt = 1;
		@(posedge clk);
		trmt = 0;
		
        
		tx_data = 8'd01; 
		@(posedge tbr); 
		repeat (50) @(posedge clk);
		trmt = 1;
		@(posedge clk);
		trmt = 0;
		
		tx_data = 8'd96; 
		@(posedge tbr); 
		repeat (50) @(posedge clk);
		trmt = 1;
		@(posedge clk);
		trmt = 0;
		

		tx_data = 8'd97; 
		@(posedge tbr); 
		repeat (50) @(posedge clk);
		trmt = 1;
		@(posedge clk);
		trmt = 0;
		
		tx_data = 8'd98; 
		@(posedge tbr); 
		repeat (50) @(posedge clk);
		trmt = 1;
		@(posedge clk);
		trmt = 0;
		
		tx_data = 8'd0; 
		@(posedge tbr); 
		repeat (50) @(posedge clk);
		trmt = 1;
		@(posedge clk);
		trmt = 0;
		
		tx_data = 8'd02; 
		@(posedge tbr); 
		repeat (50) @(posedge clk);
		trmt = 1;
		@(posedge clk);
		trmt = 0;
		
		tx_data = 8'd96; 
		@(posedge tbr); 
		repeat (50) @(posedge clk);
		trmt = 1;
		@(posedge clk);
		trmt = 0;
		

		tx_data = 8'd97; 
		@(posedge tbr); 
		repeat (50) @(posedge clk);
		trmt = 1;
		@(posedge clk);
		trmt = 0;
		
		tx_data = 8'd98; 
		@(posedge tbr); 
		repeat (50) @(posedge clk);
		trmt = 1;
		@(posedge clk);
		trmt = 0;
		
		tx_data = 8'd0; 
		@(posedge tbr); 
		repeat (50) @(posedge clk);
		trmt = 1;
		@(posedge clk);
		trmt = 0;
		
	   tx_data = 8'd4; 
		@(posedge tbr); 
		repeat (50) @(posedge clk);
		trmt = 1;
		@(posedge clk);
		trmt = 0;
   end
	
	   
   always #5 clk = ~clk;
	
endmodule
