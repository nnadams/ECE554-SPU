module ZeroCounter_tb;

reg [15:0] in;
wire [4:0] out;

ZeroCounter DUT (
    in,
    out
  );

integer i;
initial begin
	in = 16'h1;
	#10 in = in << 1;
	#10 in = in << 1;
	#10 in = in << 1;
	#10 in = in << 1;
	#10 in = in << 1;
	#10 in = in << 1;
	#10 in = in << 1;
	#10 in = in << 1;
	#10 in = in << 1;
	#10 in = in << 1;
	#10 in = in << 1;
	#10 in = in << 1;
	#10 in = in << 1;
	#10 in = in << 1;
	#10 in = in << 1;
	#10 in = in << 1;
	#10 in = in << 1;
	#10 in = in << 1;
    
    for (i = 0; i <= 16'hffff; i=i+1) begin
        #10 in = i[15:0];
    end
	$stop;
end

endmodule
