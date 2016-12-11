module Comparator_tb;

reg clk, rst, set, nullNeverMatches;
reg [127:0] stringA, stringB;
wire [15:0] result, zerosA, zerosB;
wire done, greater;

  Comparator DUT (
    .clk(clk),
    .rst(rst),
    .i_set(set),
    .i_stringA(stringA), 
    .i_stringB(stringB),
    .i_NullNeverMatches(nullNeverMatches),
    .o_result(result),
    .o_zerosA(zerosA),
    .o_zerosB(zerosB),
    .o_greater(greater),
    .o_done(done)
  );

	initial forever #5 clk = ~clk;

	initial begin
		clk = 1'b0;
		rst = 1'b1;
		set = 1'b0;
        nullNeverMatches = 1'b1;

		#8 rst = 1'b0;
		repeat(2) @(posedge clk);

		//string = 128'h48656c6c6f20576f726c642100000000;
		//string   = 128'habcdef00ffffffffffffffffffffffff;

		//string   = 128'h12345600ffffffffffffffffffffffff;
		//string = 128'h48656c6c6f20426f6221000000000000;
		//string = 128'h48656c6c6f20576f726c642100000000;

		//stringA   = 128'hffff0021646c726f57202c6f6c6c6548;
		stringB   = 128'hfff00021646c726f57202c6f6c6c6548;
		//stringB   = 128'h00000000000000000000000000000000;
		stringA   = 128'hffffffff00216d6f54202c6f6c6c6548;

		set = 1'b1;

		@(posedge clk);
		set = 1'b0;

		if (!done) $display("FAIL");

		repeat(3) @(posedge clk);
		$stop;
	end

endmodule
