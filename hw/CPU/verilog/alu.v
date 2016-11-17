module alu (
        input [31:0] A,
        input [31:0] B,
        input Cin,
        input [3:0] Op,
        input invA,
        input invB,
        input sign,
        output [31:0] Out,
        output Ofl,
        output Z,
		output N 
);
		
`define OPCODE_ROT_L		 4'b0000
`define OPCODE_SHFT_L		 4'b0001
`define OPCODE_ROT_R    	 4'b0010
`define OPCODE_SHFT_R    	 4'b0011
`define OPCODE_ADD  		 4'b0100
`define OPCODE_OR   		 4'b0101
`define OPCODE_XOR  		 4'b0110
`define OPCODE_AND  		 4'b0111
`define OPCODE_BTR           4'b1000 
`define OPCODE_LBI           4'b1001
`define OPCODE_SLBI          4'b1010
`define OPCODE_NOP           4'b1111

// Check for inverted inputs
wire [31:0] In_A;
wire [31:0] In_B;   
assign In_A = invA ? ~A : A;
assign In_B = invB ? ~B : B;

  
// 32 Bit Carry Lookahead Adder
wire [31:0] adder_out;
wire        adder_cout;
add32 adder(.A(In_A), .B(In_B), .Cin(Cin), .S(adder_out), .Cout(adder_cout));
   
// Shifter Module
wire [31:0] shftr_out;   
shifter shftr(.In(In_A), .Cnt(In_B[4:0]), .Op(Op[1:0]), .Out(shftr_out));
   
// Misc. Operations
wire [31:0] or_out;
assign or_out = In_A | In_B;
   
wire [31:0] xor_out;
assign xor_out = In_A ^ In_B;

wire [31:0] and_out;
assign and_out = In_A & In_B;

wire [31:0] btr_out;
btr32 btrr(.A(In_A), .Out(btr_out));

wire [31:0] lbi_out;
assign lbi_out = B;

wire [31:0] slbi_out;
assign slbi_out = (In_A << 16 | In_B);

// Output Assignment Mux
assign Out = (Op == `OPCODE_ROT_L)   ? shftr_out :
			 (Op == `OPCODE_SHFT_L)  ? shftr_out : 
			 (Op == `OPCODE_ROT_R)   ? shftr_out :
			 (Op == `OPCODE_SHFT_R)  ? shftr_out :
			 (Op == `OPCODE_ADD)     ? adder_out :
			 (Op == `OPCODE_OR)      ? or_out    :
			 (Op == `OPCODE_XOR)     ? xor_out   :
			 (Op == `OPCODE_AND)     ? and_out   : 
			 (Op == `OPCODE_BTR)     ? btr_out   : 
			 (Op == `OPCODE_LBI)     ? lbi_out   :
			 (Op == `OPCODE_SLBI)    ? slbi_out  :
 			 (Op == `OPCODE_NOP)     ? In_A      : 32'hxxxx;
	 
// Overflow detection Module
wire     ofl_d_out;
ofl_detect ovrflw(
	.Signed(sign), 
	.Cout(adder_cout),
	.A_Sign(In_A[31]),
	.B_Sign(In_B[31]),
	.Out_Sign(Out[31]), 
	.Ofl(ofl_d_out)
);
   
// OFL only valid for add instruction
assign Ofl = (Op == `OPCODE_ADD) ? ofl_d_out : 1'b0;

// Zero Flag Assignment
assign Z = (Out == 32'h0000) ? 1'b1 : 1'b0;
   
// Negative result Flag 
assign N = (sign & Out[31]);

endmodule
