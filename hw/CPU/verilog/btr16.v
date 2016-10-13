module btr16(
	input [15:0] A,
	output [15:0] Out
);

assign Out[0] = A[15];
assign Out[1] = A[14];
assign Out[2] = A[13];
assign Out[3] = A[12];
assign Out[4] = A[11];
assign Out[5] = A[10];
assign Out[6] = A[9];
assign Out[7] = A[8];
assign Out[8] = A[7];
assign Out[9] = A[6];
assign Out[10] = A[5];
assign Out[11] = A[4];
assign Out[12] = A[3];
assign Out[13] = A[2];
assign Out[14] = A[1];
assign Out[15] = A[0];

endmodule