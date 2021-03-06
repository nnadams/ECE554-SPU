// 32 Bit Full Adder
module add32(
	     input  [31:0] A,
	     input  [31:0] B,
	     input  Cin,
	     output [31:0] S,
	     output Cout
);


wire   [32:0] sum; 

assign sum = A + B + Cin; 

assign Cout = sum[32];
assign S = sum[31:0];

endmodule // add16
