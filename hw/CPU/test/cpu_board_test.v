`timescale 1ns / 1ps
module cpu__board_test();

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
	
    CPU_Test_FPGA_TopLevel DUT(
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