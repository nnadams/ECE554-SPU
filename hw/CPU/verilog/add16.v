/*
  16 Bit Carry Look Ahead Adder
*/
module add16(
	     input  [15:0] A,
	     input  [15:0] B,
	     input  Cin,
	     output [15:0] S,
	     output Cout
);


wire   c0, c1, c2;
wire   p0, p1, p2, p3;
wire   g0, g1, g2, g3;
   
// First 4 bits is easy... 
add4 a0(.A(A[3:0]), .B(B[3:0]), .Cin(Cin), .S(S[3:0]), .PG(p0), .GG(g0));
   
// Calculate CLA logic for block 2 based on first block
assign c0 = g0 | (p0 & Cin);
add4 a1(.A(A[7:4]), .B(B[7:4]), .Cin(c0), .S(S[7:4]), .PG(p1), .GG(g1));

// Calculate CLA logic for block 23 based on second block
assign c1 = g1 | (p1 & g0) | (p1 & p0 & Cin);
add4 a2(.A(A[11:8]), .B(B[11:8]), .Cin(c1), .S(S[11:8]), .PG(p2), .GG(g2));

// Calculate CLA logic for block 2 based on first block
assign c2 = g2 | (p2 & g1) | (p2 & p1 & g0) | (p2 & p1 & p0 & Cin);
add4 a3(.A(A[15:12]), .B(B[15:12]), .Cin(c2), .S(S[15:12]), .PG(p3), .GG(g3));

// Overall Cout from 16 bit adder
assign Cout = g3 | (p3 & g2) | (p3 & p2 & g1) | (p3 & p2 & p1 & g0) | (p3 & p2 & p1 & p0 & Cin);

endmodule // add16
