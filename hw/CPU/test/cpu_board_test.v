module cpu__board_test();

	reg clk; 
	reg rst; 
	wire tx; 
	
	initial begin 
		clk = 0; 
		rst = 1; 
		
		repeat (5) @(posedge clk);
		rst = 0;

	end
	
	always #5 clk = ~clk; 
	
    CPU_Test_FPGA_TopLevel DUT(
	 .clk(clk), 
	 .rst(rst),
	 .txd(txd)
	 );

endmodule 