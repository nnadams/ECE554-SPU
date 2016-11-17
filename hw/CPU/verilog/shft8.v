/*
  Shifter to shift the value of [31:0] In 8 bit positions.
  Only Shifts if Sel is set to 1.
  Shift behavior depends on Op:
  Op    Behavior
  00    Rotate Right
  01    Shift Left
  10    Shift Right Arithmetic
  11    Shift Right Logical
 */
module shft8(
	     input [31:0]  In,
	     input [1:0]   Op,
	     input 	   Sel,
	     output [31:0] Out
);

`define ROT_L       2'b00
`define SHFT_L      2'b01
`define ROT_R       2'b10
`define SHFT_R      2'b11
   
// BIT 0
// Mux to decide operation
wire w0;
assign w0 = (Op == `ROT_L)       ? In[24] :
			(Op == `SHFT_L)      ? 1'b0  :
			(Op == `ROT_R)       ? In[8] :
			(Op == `SHFT_R)      ? In[8] : 1'bx;

// Keep same if we were not selected to shift
assign Out[0] = Sel ? w0 : In[0];

   
// BIT 1
// Mux to decide operation
wire w1;
assign w1 = (Op == `ROT_L)       ? In[25] :
			(Op == `SHFT_L)      ? 1'b0  :
			(Op == `ROT_R)       ? In[9] :
			(Op == `SHFT_R)      ? In[9] : 1'bx;

// Keep same if we were not selected to shift
assign Out[1] = Sel ? w1 : In[1];

   
// BIT 2
// Mux to decide operation
wire w2;
assign w2 = (Op == `ROT_L)       ? In[26] :
			(Op == `SHFT_L)      ? 1'b0   :
			(Op == `ROT_R)       ? In[10] :
			(Op == `SHFT_R)      ? In[10] : 1'bx;

// Keep same if we were not selected to shift
assign Out[2] = Sel ? w2 : In[2];

   
// BIT 3
// Mux to decide operation
wire w3;
assign w3 = (Op == `ROT_L)       ? In[27] :
			(Op == `SHFT_L)      ? 1'b0   :
			(Op == `ROT_R)       ? In[11] :
			(Op == `SHFT_R)      ? In[11] : 1'bx;

// Keep same if we were not selected to shift
assign Out[3] = Sel ? w3 : In[3];

   
 // BIT 4
// Mux to decide operation
wire w4;
assign w4 = (Op == `ROT_L)       ? In[28] :
			(Op == `SHFT_L)      ? 1'b0   :
			(Op == `ROT_R)       ? In[12] :
			(Op == `SHFT_R)      ? In[12] : 1'bx;

// Keep same if we were not selected to shift
assign Out[4] = Sel ? w4 : In[4];


// BIT 5
// Mux to decide operation
wire w5;
assign w5 = (Op == `ROT_L)       ? In[29] :
			(Op == `SHFT_L)      ? 1'b0   :
			(Op == `ROT_R)       ? In[13] :
			(Op == `SHFT_R)      ? In[13] : 1'bx;

// Keep same if we were not selected to shift
assign Out[5] = Sel ? w5 : In[5];


// BIT 6
// Mux to decide operation
wire w6;
assign w6 = (Op == `ROT_L)       ? In[30] :
			(Op == `SHFT_L)      ? 1'b0   :
			(Op == `ROT_R)       ? In[14] :
			(Op == `SHFT_R)      ? In[14] : 1'bx;

// Keep same if we were not selected to shift
assign Out[6] = Sel ? w6: In[6];


// BIT 7
// Mux to decide operation
wire w7;
assign w7 = (Op == `ROT_L)       ? In[31] :
			(Op == `SHFT_L)      ? 1'b0   :
			(Op == `ROT_R)       ? In[15] :
			(Op == `SHFT_R)      ? In[15] : 1'bx;

// Keep same if we were not selected to shift
assign Out[7] = Sel ? w7 : In[7];


// BIT 8
// Mux to decide operation
wire w8;
assign w8 = (Op == `ROT_L)       ? In[0]  :
			(Op == `SHFT_L)      ? In[0]  :
			(Op == `ROT_R)       ? In[16] :
			(Op == `SHFT_R)      ? In[16] : 1'bx;

// Keep same if we were not selected to shift
assign Out[8] = Sel ? w8 : In[8];

   
// BIT 9
// Mux to decide operation
wire w9;
assign w9 = (Op == `ROT_L)       ? In[1]  :
			(Op == `SHFT_L)      ? In[1]  :
			(Op == `ROT_R)       ? In[17] :
			(Op == `SHFT_R)      ? In[17] : 1'bx;

// Keep same if we were not selected to shift
assign Out[9] = Sel ? w9 : In[9];

   
// BIT 10
// Mux to decide operation
wire w10;
assign w10 = (Op == `ROT_L)       ? In[2]  :
			 (Op == `SHFT_L)      ? In[2]  :
			 (Op == `ROT_R)       ? In[18] :
			 (Op == `SHFT_R)      ? In[18] : 1'bx;

// Keep same if we were not selected to shift
assign Out[10] = Sel ? w10 : In[10];


// BIT 11
// Mux to decide operation
wire w11;
assign w11 = (Op == `ROT_L)       ? In[3]  :
			 (Op == `SHFT_L)      ? In[3]  :
		     (Op == `ROT_R)       ? In[19] :
	         (Op == `SHFT_R)      ? In[19] : 1'bx;

// Keep same if we were not selected to shift
assign Out[11] = Sel ? w11 : In[11];

   
// BIT 12
// Mux to decide operation
wire w12;
assign w12 = (Op == `ROT_L)       ? In[4] :
			 (Op == `SHFT_L)      ? In[4] :
			 (Op == `ROT_R)       ? In[20] :
			 (Op == `SHFT_R)      ? In[20] : 1'bx;

// Keep same if we were not selected to shift
assign Out[12] = Sel ? w12 : In[12];

   
// BIT 13
// Mux to decide operation
wire w13;
assign w13 = (Op == `ROT_L)       ? In[5]  :
			 (Op == `SHFT_L)      ? In[5]  :
			 (Op == `ROT_R)       ? In[21] :
			 (Op == `SHFT_R)      ? In[21] : 1'bx;

// Keep same if we were not selected to shift
assign Out[13] = Sel ? w13 : In[13];

   
// BIT 14
// Mux to decide operation
wire w14;
assign w14 = (Op == `ROT_L)       ? In[6]  :
			 (Op == `SHFT_L)      ? In[6]  :
			 (Op == `ROT_R)       ? In[22] :
			 (Op == `SHFT_R)      ? In[22] : 1'bx;

// Keep same if we were not selected to shift
assign Out[14] = Sel ? w14 : In[14];

   
// BIT 15
// Mux to decide operation
wire w15;
assign w15 = (Op == `ROT_L)       ? In[7] :
			 (Op == `SHFT_L)      ? In[7] :
			 (Op == `ROT_R)       ? In[23] :
			 (Op == `SHFT_R)      ? In[23] : 1'bx;

// Keep same if we were not selected to shift
assign Out[15] = Sel ? w15 : In[15];

// BIT 16
// Mux to decide operation
wire w16;
assign w16 = (Op == `ROT_L)       ? In[8] :
			 (Op == `SHFT_L)      ? In[8] :
			 (Op == `ROT_R)       ? In[24] :
			 (Op == `SHFT_R)      ? In[24] : 1'bx;
	
// Keep same if we were not selected to shift
assign Out[16] = Sel ? w16 : In[16];

// BIT 17
// Mux to decide operation
wire w17;
assign w17 = (Op == `ROT_L)       ? In[9] :
			 (Op == `SHFT_L)      ? In[9] :
			 (Op == `ROT_R)       ? In[25] :
			 (Op == `SHFT_R)      ? In[25] : 1'bx;
	
// Keep same if we were not selected to shift
assign Out[17] = Sel ? w17 : In[17];

// BIT 18
// Mux to decide operation
wire w18;
assign w18 = (Op == `ROT_L)       ? In[10] :
			 (Op == `SHFT_L)      ? In[10] :
			 (Op == `ROT_R)       ? In[26] :
			 (Op == `SHFT_R)      ? In[26] : 1'bx;
	
// Keep same if we were not selected to shift
assign Out[18] = Sel ? w18 : In[18];

// BIT 19
// Mux to decide operation
wire w19;
assign w19 = (Op == `ROT_L)       ? In[11] :
			 (Op == `SHFT_L)      ? In[11] :
			 (Op == `ROT_R)       ? In[27] :
			 (Op == `SHFT_R)      ? In[27] : 1'bx;
	
// Keep same if we were not selected to shift
assign Out[19] = Sel ? w19 : In[19];

// BIT 20
// Mux to decide operation
wire w20;
assign w20 = (Op == `ROT_L)       ? In[12] :
			 (Op == `SHFT_L)      ? In[12] :
			 (Op == `ROT_R)       ? In[28] :
			 (Op == `SHFT_R)      ? In[28] : 1'bx;
	
// Keep same if we were not selected to shift
assign Out[20] = Sel ? w20 : In[20];

// BIT 21
// Mux to decide operation
wire w21;
assign w21 = (Op == `ROT_L)       ? In[13] :
			 (Op == `SHFT_L)      ? In[13] :
			 (Op == `ROT_R)       ? In[29] :
			 (Op == `SHFT_R)      ? In[29] : 1'bx;
	
// Keep same if we were not selected to shift
assign Out[21] = Sel ? w21 : In[21];

// BIT 22
// Mux to decide operation
wire w22;
assign w22 = (Op == `ROT_L)       ? In[14] :
			 (Op == `SHFT_L)      ? In[14] :
			 (Op == `ROT_R)       ? In[30] :
			 (Op == `SHFT_R)      ? In[30] : 1'bx;
	
// Keep same if we were not selected to shift
assign Out[22] = Sel ? w22 : In[22];

// BIT 23
// Mux to decide operation
wire w23;
assign w23 = (Op == `ROT_L)       ? In[15] :
			 (Op == `SHFT_L)      ? In[15] :
			 (Op == `ROT_R)       ? In[31]  :
			 (Op == `SHFT_R)      ? In[31]   : 1'bx;
	
// Keep same if we were not selected to shift
assign Out[23] = Sel ? w23 : In[23];

// BIT 24
// Mux to decide operation
wire w24;
assign w24 = (Op == `ROT_L)       ? In[16] :
			 (Op == `SHFT_L)      ? In[16] :
			 (Op == `ROT_R)       ? In[0]  :
			 (Op == `SHFT_R)      ? 1'b0   : 1'bx;
	
// Keep same if we were not selected to shift
assign Out[24] = Sel ? w24 : In[24];

// BIT 25
// Mux to decide operation
wire w25;
assign w25 = (Op == `ROT_L)       ? In[17] :
			 (Op == `SHFT_L)      ? In[17] :
			 (Op == `ROT_R)       ? In[1]  :
			 (Op == `SHFT_R)      ? 1'b0   : 1'bx;
	
// Keep same if we were not selected to shift
assign Out[25] = Sel ? w25 : In[25];

// BIT 26
// Mux to decide operation
wire w26;
assign w26 = (Op == `ROT_L)       ? In[18] :
			 (Op == `SHFT_L)      ? In[18] :
			 (Op == `ROT_R)       ? In[2]  :
			 (Op == `SHFT_R)      ? 1'b0   : 1'bx;
	
// Keep same if we were not selected to shift
assign Out[26] = Sel ? w26 : In[26];

// BIT 27
// Mux to decide operation
wire w27;
assign w27 = (Op == `ROT_L)       ? In[19] :
			 (Op == `SHFT_L)      ? In[19] :
			 (Op == `ROT_R)       ? In[3]  :
			 (Op == `SHFT_R)      ? 1'b0   : 1'bx;
	
// Keep same if we were not selected to shift
assign Out[27] = Sel ? w27 : In[27];

// BIT 28
// Mux to decide operation
wire w28;
assign w28 = (Op == `ROT_L)       ? In[20] :
			 (Op == `SHFT_L)      ? In[20] :
			 (Op == `ROT_R)       ? In[4]  :
			 (Op == `SHFT_R)      ? 1'b0   : 1'bx;
	
// Keep same if we were not selected to shift
assign Out[28] = Sel ? w28 : In[28];

// BIT 29
// Mux to decide operation
wire w29;
assign w29 = (Op == `ROT_L)       ? In[21] :
			 (Op == `SHFT_L)      ? In[21] :
			 (Op == `ROT_R)       ? In[5]  :
			 (Op == `SHFT_R)      ? 1'b0   : 1'bx;
	
// Keep same if we were not selected to shift
assign Out[29] = Sel ? w29 : In[29];

// BIT 30
// Mux to decide operation
wire w30;
assign w30 = (Op == `ROT_L)       ? In[22] :
			 (Op == `SHFT_L)      ? In[22] :
			 (Op == `ROT_R)       ? In[6]  :
			 (Op == `SHFT_R)      ? 1'b0   : 1'bx;
	
// Keep same if we were not selected to shift
assign Out[30] = Sel ? w30 : In[30];

// BIT 31
// Mux to decide operation
wire w31;
assign w31 = (Op == `ROT_L)       ? In[23] :
			 (Op == `SHFT_L)      ? In[23] :
			 (Op == `ROT_R)       ? In[7] :
			 (Op == `SHFT_R)      ? 1'b0 : 1'bx;
	
// Keep same if we were not selected to shift
assign Out[31] = Sel ? w31 : In[31];

endmodule
