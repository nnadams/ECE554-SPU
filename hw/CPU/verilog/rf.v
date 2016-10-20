module rf (
           // Outputs
           read1data, 
		   read2data, 
           // Inputs
           clk,
		   rst,
		   read1regsel,
		   read2regsel,
		   writeregsel, 
		   writedata, 
		   write
           );
		   
input clk, rst;
input [4:0] read1regsel;
input [4:0] read2regsel;
input [4:0] writeregsel;
input [31:0] writedata;
input        write;

output [31:0] read1data;
output [31:0] read2data;

// Output data from each register
wire [31:0] 	 r0Data;
wire [31:0] 	 r1Data;
wire [31:0] 	 r2Data;
wire [31:0] 	 r3Data;
wire [31:0] 	 r4Data;
wire [31:0] 	 r5Data;
wire [31:0] 	 r6Data;
wire [31:0] 	 r7Data;
wire [31:0] 	 r8Data;
wire [31:0] 	 r9Data;
wire [31:0] 	 r10Data;
wire [31:0] 	 r11Data;
wire [31:0] 	 r12Data;
wire [31:0] 	 r13Data;
wire [31:0] 	 r14Data;
wire [31:0] 	 r15Data;
wire [31:0] 	 r16Data;
wire [31:0] 	 r17Data;
wire [31:0] 	 r18Data;
wire [31:0] 	 r19Data;
wire [31:0] 	 r20Data;
wire [31:0] 	 r21Data;
wire [31:0] 	 r22Data;
wire [31:0] 	 r23Data;
wire [31:0] 	 r24Data;
wire [31:0] 	 r25Data;
wire [31:0] 	 r26Data;
wire [31:0] 	 r27Data;
wire [31:0] 	 r28Data;
wire [31:0] 	 r29Data;
wire [31:0] 	 r30Data;
wire [31:0] 	 r31Data;


// Individual write selects for each register 
wire 	 r0Write;
wire 	 r1Write;
wire 	 r2Write;
wire 	 r3Write;
wire 	 r4Write;
wire 	 r5Write;
wire 	 r6Write;
wire 	 r7Write;
wire 	 r8Write;
wire 	 r9Write;
wire 	 r10Write;
wire 	 r11Write;
wire 	 r12Write;
wire 	 r13Write;
wire 	 r14Write;
wire 	 r15Write;
wire 	 r16Write;
wire 	 r17Write;
wire 	 r18Write;
wire 	 r19Write;
wire 	 r20Write;
wire 	 r21Write;
wire 	 r22Write;
wire 	 r23Write;
wire 	 r24Write;
wire 	 r25Write;
wire 	 r26Write;
wire 	 r27Write;
wire 	 r28Write;
wire 	 r29Write;
wire 	 r30Write;
wire 	 r31Write;

// The registers
reg_32 r0 (.clk(clk), .rst(rst), .writeData(writedata), .data(r0Data), .write(r0Write));
reg_32 r1 (.clk(clk), .rst(rst), .writeData(writedata), .data(r1Data), .write(r1Write));
reg_32 r2 (.clk(clk), .rst(rst), .writeData(writedata), .data(r2Data), .write(r2Write));
reg_32 r3 (.clk(clk), .rst(rst), .writeData(writedata), .data(r3Data), .write(r3Write));
reg_32 r4 (.clk(clk), .rst(rst), .writeData(writedata), .data(r4Data), .write(r4Write));
reg_32 r5 (.clk(clk), .rst(rst), .writeData(writedata), .data(r5Data), .write(r5Write));
reg_32 r6 (.clk(clk), .rst(rst), .writeData(writedata), .data(r6Data), .write(r6Write));
reg_32 r7 (.clk(clk), .rst(rst), .writeData(writedata), .data(r7Data), .write(r7Write));
reg_32 r8 (.clk(clk), .rst(rst), .writeData(writedata), .data(r8Data), .write(r8Write));
reg_32 r9 (.clk(clk), .rst(rst), .writeData(writedata), .data(r9Data), .write(r9Write));
reg_32 r10 (.clk(clk), .rst(rst), .writeData(writedata), .data(r10Data), .write(r10Write));
reg_32 r11 (.clk(clk), .rst(rst), .writeData(writedata), .data(r11Data), .write(r11Write));
reg_32 r12 (.clk(clk), .rst(rst), .writeData(writedata), .data(r12Data), .write(r12Write));
reg_32 r13 (.clk(clk), .rst(rst), .writeData(writedata), .data(r13Data), .write(r13Write));
reg_32 r14 (.clk(clk), .rst(rst), .writeData(writedata), .data(r14Data), .write(r14Write));
reg_32 r15 (.clk(clk), .rst(rst), .writeData(writedata), .data(r15Data), .write(r15Write));
reg_32 r16 (.clk(clk), .rst(rst), .writeData(writedata), .data(r16Data), .write(r16Write));
reg_32 r17 (.clk(clk), .rst(rst), .writeData(writedata), .data(r17Data), .write(r17Write));
reg_32 r18 (.clk(clk), .rst(rst), .writeData(writedata), .data(r18Data), .write(r18Write));
reg_32 r19 (.clk(clk), .rst(rst), .writeData(writedata), .data(r19Data), .write(r19Write));
reg_32 r20 (.clk(clk), .rst(rst), .writeData(writedata), .data(r20Data), .write(r20Write));
reg_32 r21 (.clk(clk), .rst(rst), .writeData(writedata), .data(r21Data), .write(r21Write));
reg_32 r22 (.clk(clk), .rst(rst), .writeData(writedata), .data(r22Data), .write(r22Write));
reg_32 r23 (.clk(clk), .rst(rst), .writeData(writedata), .data(r23Data), .write(r23Write));
reg_32 r24 (.clk(clk), .rst(rst), .writeData(writedata), .data(r24Data), .write(r24Write));
reg_32 r25 (.clk(clk), .rst(rst), .writeData(writedata), .data(r25Data), .write(r25Write));
reg_32 r26 (.clk(clk), .rst(rst), .writeData(writedata), .data(r26Data), .write(r26Write));
reg_32 r27 (.clk(clk), .rst(rst), .writeData(writedata), .data(r27Data), .write(r27Write));
reg_32 r28 (.clk(clk), .rst(rst), .writeData(writedata), .data(r28Data), .write(r28Write));
reg_32 r29 (.clk(clk), .rst(rst), .writeData(writedata), .data(r29Data), .write(r29Write));
reg_32 r30 (.clk(clk), .rst(rst), .writeData(writedata), .data(r30Data), .write(r30Write));
reg_32 r31 (.clk(clk), .rst(rst), .writeData(writedata), .data(r31Data), .write(r31Write));

// MUX for putting the correct read data on the port
assign read1data =
		(read1regsel == 5'b00000) ? r0Data:
		(read1regsel == 5'b00001) ? r1Data:
		(read1regsel == 5'b00010) ? r2Data:
		(read1regsel == 5'b00011) ? r3Data:
		(read1regsel == 5'b00100) ? r4Data:
		(read1regsel == 5'b00101) ? r5Data:
		(read1regsel == 5'b00110) ? r6Data:
		(read1regsel == 5'b00111) ? r7Data:
		(read1regsel == 5'b01000) ? r8Data:
		(read1regsel == 5'b01001) ? r9Data:
		(read1regsel == 5'b01010) ? r10Data:
		(read1regsel == 5'b01011) ? r11Data:
		(read1regsel == 5'b01100) ? r12Data:
		(read1regsel == 5'b01101) ? r13Data:
		(read1regsel == 5'b01110) ? r14Data:
		(read1regsel == 5'b01111) ? r15Data:
		(read1regsel == 5'b10000) ? r16Data:
		(read1regsel == 5'b10001) ? r17Data:
		(read1regsel == 5'b10010) ? r18Data:
		(read1regsel == 5'b10011) ? r19Data:
		(read1regsel == 5'b10100) ? r20Data:
		(read1regsel == 5'b10101) ? r21Data:
		(read1regsel == 5'b10110) ? r22Data:
		(read1regsel == 5'b10111) ? r23Data:
		(read1regsel == 5'b11000) ? r24Data:
		(read1regsel == 5'b11001) ? r25Data:
		(read1regsel == 5'b11010) ? r26Data:
		(read1regsel == 5'b11011) ? r27Data:
		(read1regsel == 5'b11100) ? r28Data:
		(read1regsel == 5'b11101) ? r29Data:
		(read1regsel == 5'b11110) ? r31Data:
		(read1regsel == 5'b11111) ? r31Data:
		32'h0000;

assign read2data =
		(read2regsel == 5'b00000) ? r0Data:
		(read2regsel == 5'b00001) ? r1Data:
		(read2regsel == 5'b00010) ? r2Data:
		(read2regsel == 5'b00011) ? r3Data:
		(read2regsel == 5'b00100) ? r4Data:
		(read2regsel == 5'b00101) ? r5Data:
		(read2regsel == 5'b00110) ? r6Data:
		(read2regsel == 5'b00111) ? r7Data:
		(read2regsel == 5'b01000) ? r8Data:
		(read2regsel == 5'b01001) ? r9Data:
		(read2regsel == 5'b01010) ? r10Data:
		(read2regsel == 5'b01011) ? r11Data:
		(read2regsel == 5'b01100) ? r12Data:
		(read2regsel == 5'b01101) ? r13Data:
		(read2regsel == 5'b01110) ? r14Data:
		(read2regsel == 5'b01111) ? r15Data:
		(read2regsel == 5'b10000) ? r16Data:
		(read2regsel == 5'b10001) ? r17Data:
		(read2regsel == 5'b10010) ? r18Data:
		(read2regsel == 5'b10011) ? r19Data:
		(read2regsel == 5'b10100) ? r20Data:
		(read2regsel == 5'b10101) ? r21Data:
		(read2regsel == 5'b10110) ? r22Data:
		(read2regsel == 5'b10111) ? r23Data:
		(read2regsel == 5'b11000) ? r24Data:
		(read2regsel == 5'b11001) ? r25Data:
		(read2regsel == 5'b11010) ? r26Data:
		(read2regsel == 5'b11011) ? r27Data:
		(read2regsel == 5'b11100) ? r28Data:
		(read2regsel == 5'b11101) ? r29Data:
		(read2regsel == 5'b11110) ? r31Data:
		(read2regsel == 5'b11111) ? r31Data:
		32'h0000;


// Assert the write for the correct register, if necessary
assign r0Write =  (writeregsel == 5'b00000) ? write : 0;
assign r1Write =  (writeregsel == 5'b00001) ? write : 0;
assign r2Write =  (writeregsel == 5'b00010) ? write : 0;
assign r3Write =  (writeregsel == 5'b00011) ? write : 0;
assign r4Write =  (writeregsel == 5'b00100) ? write : 0;
assign r5Write =  (writeregsel == 5'b00101) ? write : 0;
assign r6Write =  (writeregsel == 5'b00110) ? write : 0;
assign r7Write =  (writeregsel == 5'b00111) ? write : 0;
assign r8Write =  (writeregsel == 5'b01000) ? write : 0;
assign r9Write =  (writeregsel == 5'b01001) ? write : 0;
assign r10Write = (writeregsel == 5'b01010) ? write : 0;
assign r11Write = (writeregsel == 5'b01011) ? write : 0;
assign r12Write = (writeregsel == 5'b01100) ? write : 0;
assign r13Write = (writeregsel == 5'b01101) ? write : 0;
assign r14Write = (writeregsel == 5'b01110) ? write : 0;
assign r15Write = (writeregsel == 5'b01111) ? write : 0;
assign r16Write = (writeregsel == 5'b10000) ? write : 0;
assign r17Write = (writeregsel == 5'b10001) ? write : 0;
assign r18Write = (writeregsel == 5'b10010) ? write : 0;
assign r19Write = (writeregsel == 5'b10011) ? write : 0;
assign r20Write = (writeregsel == 5'b10100) ? write : 0;
assign r21Write = (writeregsel == 5'b10101) ? write : 0;
assign r22Write = (writeregsel == 5'b10110) ? write : 0;
assign r23Write = (writeregsel == 5'b10111) ? write : 0;
assign r24Write = (writeregsel == 5'b11000) ? write : 0;
assign r25Write = (writeregsel == 5'b11001) ? write : 0;
assign r26Write = (writeregsel == 5'b11010) ? write : 0;
assign r27Write = (writeregsel == 5'b11011) ? write : 0;
assign r28Write = (writeregsel == 5'b11100) ? write : 0;
assign r29Write = (writeregsel == 5'b11101) ? write : 0;
assign r30Write = (writeregsel == 5'b11110) ? write : 0;
assign r31Write = (writeregsel == 5'b11111) ? write : 0;

endmodule
