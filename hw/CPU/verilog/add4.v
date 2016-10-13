/*
   4 Bit Carry Look Ahead Adder.
*/
module add4(
	    input [3:0]  A,
	    input [3:0]  B,
	    input 	 Cin,
	    output [3:0] S,
	    output 	 PG,
	    output 	 GG
);
    
wire    g0, g1, g2, g3;
wire    p0, p1, p2,p3;
wire    c1, c2, c3;
   

// determine what generates carries. Automatic carry generate will be when both bits are 1
assign {g3,g2,g1,g0} = A & B;

// determine what propogates a carry. Will propogate if either a or b is a 1
assign {p3,p2,p1,p0} = A ^ B;
   
// Bit 1 will generate a carry if Bit 0 generates a carry OR propogates a carry and cin = 1
assign c1 = g0 | (p0 & Cin);

// Bit 2 generates carry if Bit 1 generates, or bit 1 propogates a carry from before
assign c2 = g1 | (p1 & g0) | (p1 & p0 & Cin);

// Bit 3 same -> carry if bit 3 gen or props from before
assign c3 = g2 | (p2 & g1) | (p2 & p1 & g0) | (p2 & p1 & p0 & Cin);

/* Calculate final sum as the XOR of propogation and carry in to that bit
   Cause if we're propogating and carry in is 1, output S for that bit should be 0
   If one of the other is true, we stop the carry and output a 1
   If A == B == 1, We will always generate a carry, so propogate would be 0, S = 1.
 
   A  B  Cin  P  G  S
   0  0  0    0  0  0
   0  1  0    1  0  1
   1  0  0    1  0  1 
   1  1  0    0  1  0
   0  0  1    0  0  1 
   0  1  1    1  0  0 
   1  0  1    1  0  0 
   1  1  1    0  1  1
 
   Can see here S = Cin ^ P
*/
assign S[0] = Cin ^ p0;
assign S[1] = c1  ^ p1;
assign S[2] = c2  ^ p2;
assign S[3] = c3  ^ p3;

// BLOCK LEVEL GENERATE ? PROPOGATE
// Output if this block will propogate a Carry In
assign PG = p3 & p2 & p1 & p0;

// Output if this block will generate a carry always
assign GG = g3 | (p3 & g2) | (p3 & p2 & g1) | (p3 & p2 & p1 & g0) | (p3 & p2 & p1 & p0 & Cin);


endmodule