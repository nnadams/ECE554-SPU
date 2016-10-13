/*
  Shifter to shift the value of [15:0] In 4 bit position.
  Only Shifts if Sel is set to 1.
  Shift behavior depends on Op:
  Op    Behavior
  00    Rotate Right
  01    Shift Left
  10    Shift Right Arithmetic
  11    Shift Right Logical
 */
module shft4(
	     input [15:0]  In,
	     input [1:0]   Op,
	     input 	   Sel,
	     output [15:0] Out
);

`define ROT_L       2'b00
`define SHFT_L      2'b01
`define ROT_R       2'b10
`define SHFT_R      2'b11
   
// BIT 0
// Mux to decide operation
wire w0;
assign w0 = (Op == `ROT_L)       ? In[12] :
			(Op == `SHFT_L)      ? 1'b0   :
			(Op == `ROT_R)       ? In[4]  :
			(Op == `SHFT_R)      ? In[4]  : 1'bx;

// Keep same if we were not selected to shift
assign Out[0] = Sel ? w0 : In[0];

   
// BIT 1
// Mux to decide operation
wire w1;
assign w1 = (Op == `ROT_L)       ? In[13] :
			(Op == `SHFT_L)      ? 1'b0   :
			(Op == `ROT_R)       ? In[5]  :
			(Op == `SHFT_R)      ? In[5]  : 1'bx;

// Keep same if we were not selected to shift
assign Out[1] = Sel ? w1 : In[1];

   
// BIT 2
// Mux to decide operation
wire w2;
assign w2 = (Op == `ROT_L)       ? In[14] :
			(Op == `SHFT_L)      ? 1'b0   :
			(Op == `ROT_R)       ? In[6]  :
			(Op == `SHFT_R)      ? In[6]  : 1'bx;

// Keep same if we were not selected to shift
assign Out[2] = Sel ? w2 : In[2];

   
// BIT 3
// Mux to decide operation
wire w3;
assign w3 = (Op == `ROT_L)       ? In[15] :
			(Op == `SHFT_L)      ? 1'b0   :
			(Op == `ROT_R)       ? In[7]  :
			(Op == `SHFT_R)      ? In[7]  : 1'bx;

// Keep same if we were not selected to shift
assign Out[3] = Sel ? w3 : In[3];

   
 // BIT 4
// Mux to decide operation
wire w4;
assign w4 = (Op == `ROT_L)       ? In[0] :
			(Op == `SHFT_L)      ? In[0] :
			(Op == `ROT_R)       ? In[8] :
			(Op == `SHFT_R)      ? In[8] : 1'bx;

// Keep same if we were not selected to shift
assign Out[4] = Sel ? w4 : In[4];


// BIT 5
// Mux to decide operation
wire w5;
assign w5 = (Op == `ROT_L)       ? In[1] :
			(Op == `SHFT_L)      ? In[1] :
			(Op == `ROT_R)       ? In[9] :
			(Op == `SHFT_R)      ? In[9] : 1'bx;

// Keep same if we were not selected to shift
assign Out[5] = Sel ? w5 : In[5];


// BIT 6
// Mux to decide operation
wire w6;
assign w6 = (Op == `ROT_L)       ? In[2]  :
			(Op == `SHFT_L)      ? In[2]  :
			(Op == `ROT_R)       ? In[10] :
			(Op == `SHFT_R)      ? In[10] : 1'bx;

// Keep same if we were not selected to shift
assign Out[6] = Sel ? w6: In[6];


// BIT 7
// Mux to decide operation
wire w7;
assign w7 = (Op == `ROT_L)       ? In[3]  :
			(Op == `SHFT_L)      ? In[3]  :
			(Op == `ROT_R)       ? In[11] :
			(Op == `SHFT_R)      ? In[11] : 1'bx;

// Keep same if we were not selected to shift
assign Out[7] = Sel ? w7 : In[7];


// BIT 8
// Mux to decide operation
wire w8;
assign w8 = (Op == `ROT_L)       ? In[4]  :
			(Op == `SHFT_L)      ? In[4]  :
			(Op == `ROT_R)       ? In[12] :
			(Op == `SHFT_R)      ? In[12] : 1'bx;

// Keep same if we were not selected to shift
assign Out[8] = Sel ? w8 : In[8];

   
// BIT 9
// Mux to decide operation
wire w9;
assign w9 = (Op == `ROT_L)       ? In[5]  :
			(Op == `SHFT_L)      ? In[5]  :
			(Op == `ROT_R)       ? In[13] :
			(Op == `SHFT_R)      ? In[13] : 1'bx;

// Keep same if we were not selected to shift
assign Out[9] = Sel ? w9 : In[9];

   
// BIT 10
// Mux to decide operation
wire w10;
assign w10 = (Op == `ROT_L)       ? In[6]  :
			 (Op == `SHFT_L)      ? In[6]  :
			 (Op == `ROT_R)       ? In[14] :
			 (Op == `SHFT_R)      ? In[14] : 1'bx;

// Keep same if we were not selected to shift
assign Out[10] = Sel ? w10 : In[10];


// BIT 11
// Mux to decide operation
wire w11;
assign w11 = (Op == `ROT_L)       ? In[7]  :
		 	 (Op == `SHFT_L)      ? In[7]  :
			 (Op == `ROT_R)       ? In[15] :
			 (Op == `SHFT_R)      ? In[15] : 1'bx;

// Keep same if we were not selected to shift
assign Out[11] = Sel ? w11 : In[11];

   
// BIT 12
// Mux to decide operation
wire w12;
assign w12 = (Op == `ROT_L)       ? In[8]  :
			 (Op == `SHFT_L)      ? In[8]  :
			 (Op == `ROT_R)       ? In[0]  :
			 (Op == `SHFT_R)      ? 1'b0   : 1'bx;

// Keep same if we were not selected to shift
assign Out[12] = Sel ? w12 : In[12];

   
// BIT 13
// Mux to decide operation
wire w13;
assign w13 = (Op == `ROT_L)       ? In[9]  :
			 (Op == `SHFT_L)      ? In[9]  :
			 (Op == `ROT_R)       ? In[1]  :
			 (Op == `SHFT_R)      ? 1'b0   : 1'bx;

// Keep same if we were not selected to shift
assign Out[13] = Sel ? w13 : In[13];

   
// BIT 14
// Mux to decide operation
wire w14;
assign w14 = (Op == `ROT_L)       ? In[10] : 
			 (Op == `SHFT_L)      ? In[10] :
			 (Op == `ROT_R)       ? In[2]  :
			 (Op == `SHFT_R)      ? 1'b0   : 1'bx;

// Keep same if we were not selected to shift
assign Out[14] = Sel ? w14 : In[14];

   
// BIT 15
// Mux to decide operation
wire w15;
assign w15 = (Op == `ROT_L)       ? In[11] :
			 (Op == `SHFT_L)      ? In[11] :
			 (Op == `ROT_R)       ? In[3]  :
			 (Op == `SHFT_R)      ? 1'b0   : 1'bx;

// Keep same if we were not selected to shift
assign Out[15] = Sel ? w15 : In[15];

endmodule
   