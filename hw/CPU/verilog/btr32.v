module btr32(
	input [31:0] A,
	output [31:0] Out
);

assign Out[0] = A[31];
assign Out[1] = A[30];
assign Out[2] = A[29];
assign Out[3] = A[28];
assign Out[4] = A[27];
assign Out[5] = A[26];
assign Out[6] = A[25];
assign Out[7] = A[24];
assign Out[8] = A[23];
assign Out[9] = A[22];
assign Out[10] = A[21];
assign Out[11] = A[20];
assign Out[12] = A[19];
assign Out[13] = A[18];
assign Out[14] = A[17];
assign Out[15] = A[16];
assign Out[16] = A[15];
assign Out[17] = A[14];
assign Out[18] = A[13];
assign Out[19] = A[12];
assign Out[20] = A[11];
assign Out[21] = A[10];
assign Out[22] = A[9];
assign Out[23] = A[8];
assign Out[24] = A[7];
assign Out[25] = A[6];
assign Out[26] = A[5];
assign Out[27] = A[4];
assign Out[28] = A[3];
assign Out[29] = A[2];
assign Out[30] = A[1];
assign Out[31] = A[0];

endmodule