module PriorityEnc_tb;

reg [15:0] in;
wire [4:0] out;

PriorityEnc DUT (
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
	$stop;
end

endmodule
