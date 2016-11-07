module rf (
           // Outputs
           read1data, 
		   read2data, 
		   restore,
           // Inputs
           clk,
		   rst,
		   read1regsel,
		   read2regsel,
		   writeregsel, 
		   writedata, 
		   write,
		   save
           );
		   
input clk, rst;
input [4:0] read1regsel;
input [4:0] read2regsel;
input [4:0] writeregsel;
input [31:0] writedata;
input        write;
input 	     save; 
input        restore;

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

// Output data of saved registers
wire [31:0] 	 savedr0Data;
wire [31:0] 	 savedr1Data;
wire [31:0] 	 savedr2Data;
wire [31:0] 	 savedr3Data;
wire [31:0] 	 savedr4Data;
wire [31:0] 	 savedr5Data;
wire [31:0] 	 savedr6Data;
wire [31:0] 	 savedr7Data;
wire [31:0] 	 savedr8Data;
wire [31:0] 	 savedr9Data;
wire [31:0] 	 savedr10Data;
wire [31:0] 	 savedr11Data;
wire [31:0] 	 savedr12Data;
wire [31:0] 	 savedr13Data;
wire [31:0] 	 savedr14Data;
wire [31:0] 	 savedr15Data;
wire [31:0] 	 savedr16Data;
wire [31:0] 	 savedr17Data;
wire [31:0] 	 savedr18Data;
wire [31:0] 	 savedr19Data;
wire [31:0] 	 savedr20Data;
wire [31:0] 	 savedr21Data;
wire [31:0] 	 savedr22Data;
wire [31:0] 	 savedr23Data;
wire [31:0] 	 savedr24Data;
wire [31:0] 	 savedr25Data;
wire [31:0] 	 savedr26Data;
wire [31:0] 	 savedr27Data;
wire [31:0] 	 savedr28Data;
wire [31:0] 	 savedr29Data;
wire [31:0] 	 savedr30Data;
wire [31:0] 	 savedr31Data;

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

// Individual write data for each register 
wire [31:0] 	 r0writeData;
wire [31:0] 	 r1writeData;
wire [31:0] 	 r2writeData;
wire [31:0] 	 r3writeData;
wire [31:0] 	 r4writeData;
wire [31:0] 	 r5writeData;
wire [31:0] 	 r6writeData;
wire [31:0] 	 r7writeData;
wire [31:0] 	 r8writeData;
wire [31:0] 	 r9writeData;
wire [31:0] 	 r10writeData;
wire [31:0] 	 r11writeData;
wire [31:0] 	 r12writeData;
wire [31:0] 	 r13writeData;
wire [31:0] 	 r14writeData;
wire [31:0] 	 r15writeData;
wire [31:0] 	 r16writeData;
wire [31:0] 	 r17writeData;
wire [31:0] 	 r18writeData;
wire [31:0] 	 r19writeData;
wire [31:0] 	 r20writeData;
wire [31:0] 	 r21writeData;
wire [31:0] 	 r22writeData;
wire [31:0] 	 r23writeData;
wire [31:0] 	 r24writeData;
wire [31:0] 	 r25writeData;
wire [31:0] 	 r26writeData;
wire [31:0] 	 r27writeData;
wire [31:0] 	 r28writeData;
wire [31:0] 	 r29writeData;
wire [31:0] 	 r30writeData;
wire [31:0] 	 r31writeData;

// The registers
reg_32 r0 (.clk(clk), .rst(rst), .writeData(r0writeData), .data(r0Data), .write(r0Write));
reg_32 r1 (.clk(clk), .rst(rst), .writeData(r1writeData), .data(r1Data), .write(r1Write));
reg_32 r2 (.clk(clk), .rst(rst), .writeData(r2writeData), .data(r2Data), .write(r2Write));
reg_32 r3 (.clk(clk), .rst(rst), .writeData(r3writeData), .data(r3Data), .write(r3Write));
reg_32 r4 (.clk(clk), .rst(rst), .writeData(r4writeData), .data(r4Data), .write(r4Write));
reg_32 r5 (.clk(clk), .rst(rst), .writeData(r5writeData), .data(r5Data), .write(r5Write));
reg_32 r6 (.clk(clk), .rst(rst), .writeData(r6writeData), .data(r6Data), .write(r6Write));
reg_32 r7 (.clk(clk), .rst(rst), .writeData(r7writeData), .data(r7Data), .write(r7Write));
reg_32 r8 (.clk(clk), .rst(rst), .writeData(r8writeData), .data(r8Data), .write(r8Write));
reg_32 r9 (.clk(clk), .rst(rst), .writeData(r9writeData), .data(r9Data), .write(r9Write));
reg_32 r10 (.clk(clk), .rst(rst), .writeData(r10writeData), .data(r10Data), .write(r10Write));
reg_32 r11 (.clk(clk), .rst(rst), .writeData(r11writeData), .data(r11Data), .write(r11Write));
reg_32 r12 (.clk(clk), .rst(rst), .writeData(r12writeData), .data(r12Data), .write(r12Write));
reg_32 r13 (.clk(clk), .rst(rst), .writeData(r13writeData), .data(r13Data), .write(r13Write));
reg_32 r14 (.clk(clk), .rst(rst), .writeData(r14writeData), .data(r14Data), .write(r14Write));
reg_32 r15 (.clk(clk), .rst(rst), .writeData(r15writeData), .data(r15Data), .write(r15Write));
reg_32 r16 (.clk(clk), .rst(rst), .writeData(r16writeData), .data(r16Data), .write(r16Write));
reg_32 r17 (.clk(clk), .rst(rst), .writeData(r17writeData), .data(r17Data), .write(r17Write));
reg_32 r18 (.clk(clk), .rst(rst), .writeData(r18writeData), .data(r18Data), .write(r18Write));
reg_32 r19 (.clk(clk), .rst(rst), .writeData(r19writeData), .data(r19Data), .write(r19Write));
reg_32 r20 (.clk(clk), .rst(rst), .writeData(r20writeData), .data(r20Data), .write(r20Write));
reg_32 r21 (.clk(clk), .rst(rst), .writeData(r21writeData), .data(r21Data), .write(r21Write));
reg_32 r22 (.clk(clk), .rst(rst), .writeData(r22writeData), .data(r22Data), .write(r22Write));
reg_32 r23 (.clk(clk), .rst(rst), .writeData(r23writeData), .data(r23Data), .write(r23Write));
reg_32 r24 (.clk(clk), .rst(rst), .writeData(r24writeData), .data(r24Data), .write(r24Write));
reg_32 r25 (.clk(clk), .rst(rst), .writeData(r25writeData), .data(r25Data), .write(r25Write));
reg_32 r26 (.clk(clk), .rst(rst), .writeData(r26writeData), .data(r26Data), .write(r26Write));
reg_32 r27 (.clk(clk), .rst(rst), .writeData(r27writeData), .data(r27Data), .write(r27Write));
reg_32 r28 (.clk(clk), .rst(rst), .writeData(r28writeData), .data(r28Data), .write(r28Write));
reg_32 r29 (.clk(clk), .rst(rst), .writeData(r29writeData), .data(r29Data), .write(r29Write));
reg_32 r30 (.clk(clk), .rst(rst), .writeData(r30writeData), .data(r30Data), .write(r30Write));
reg_32 r31 (.clk(clk), .rst(rst), .writeData(r31writeData), .data(r31Data), .write(r31Write));

// The Save Registers
reg_32 savedr0 (.clk(clk), .rst(rst),  .data(savedr0Data), .writeData(r0Data), .write(save));
reg_32 savedr1 (.clk(clk), .rst(rst),  .data(savedr1Data), .writeData(r1Data), .write(save));
reg_32 savedr2 (.clk(clk), .rst(rst),  .data(savedr2Data), .writeData(r2Data), .write(save));
reg_32 savedr3 (.clk(clk), .rst(rst),  .data(savedr3Data), .writeData(r3Data), .write(save));
reg_32 savedr4 (.clk(clk), .rst(rst),  .data(savedr4Data), .writeData(r4Data), .write(save));
reg_32 savedr5 (.clk(clk), .rst(rst),  .data(savedr5Data), .writeData(r5Data), .write(save));
reg_32 savedr6 (.clk(clk), .rst(rst),  .data(savedr6Data), .writeData(r6Data), .write(save));
reg_32 savedr7 (.clk(clk), .rst(rst),  .data(savedr7Data), .writeData(r7Data), .write(save));
reg_32 savedr8 (.clk(clk), .rst(rst),  .data(savedr8Data), .writeData(r8Data), .write(save));
reg_32 savedr9 (.clk(clk), .rst(rst),  .data(savedr9Data), .writeData(r9Data), .write(save));
reg_32 savedr10 (.clk(clk), .rst(rst), .data(savedr10Data), .writeData(r10Data), .write(save));
reg_32 savedr11 (.clk(clk), .rst(rst), .data(savedr11Data), .writeData(r11Data), .write(save));
reg_32 savedr12 (.clk(clk), .rst(rst), .data(savedr12Data), .writeData(r12Data), .write(save));
reg_32 savedr13 (.clk(clk), .rst(rst), .data(savedr13Data), .writeData(r13Data), .write(save));
reg_32 savedr14 (.clk(clk), .rst(rst), .data(savedr14Data), .writeData(r14Data), .write(save));
reg_32 savedr15 (.clk(clk), .rst(rst), .data(savedr15Data), .writeData(r15Data), .write(save));
reg_32 savedr16 (.clk(clk), .rst(rst), .data(savedr16Data), .writeData(r16Data), .write(save));
reg_32 savedr17 (.clk(clk), .rst(rst), .data(savedr17Data), .writeData(r17Data), .write(save));
reg_32 savedr18 (.clk(clk), .rst(rst), .data(savedr18Data), .writeData(r18Data), .write(save));
reg_32 savedr19 (.clk(clk), .rst(rst), .data(savedr19Data), .writeData(r19Data), .write(save));
reg_32 savedr20 (.clk(clk), .rst(rst), .data(savedr20Data), .writeData(r20Data), .write(save));
reg_32 savedr21 (.clk(clk), .rst(rst), .data(savedr21Data), .writeData(r21Data), .write(save));
reg_32 savedr22 (.clk(clk), .rst(rst), .data(savedr22Data), .writeData(r22Data), .write(save));
reg_32 savedr23 (.clk(clk), .rst(rst), .data(savedr23Data), .writeData(r23Data), .write(save));
reg_32 savedr24 (.clk(clk), .rst(rst), .data(savedr24Data), .writeData(r24Data), .write(save));
reg_32 savedr25 (.clk(clk), .rst(rst), .data(savedr25Data), .writeData(r25Data), .write(save));
reg_32 savedr26 (.clk(clk), .rst(rst), .data(savedr26Data), .writeData(r26Data), .write(save));
reg_32 savedr27 (.clk(clk), .rst(rst), .data(savedr27Data), .writeData(r27Data), .write(save));
reg_32 savedr28 (.clk(clk), .rst(rst), .data(savedr28Data), .writeData(r28Data), .write(save));
reg_32 savedr29 (.clk(clk), .rst(rst), .data(savedr29Data), .writeData(r29Data), .write(save));
reg_32 savedr30 (.clk(clk), .rst(rst), .data(savedr30Data), .writeData(r30Data), .write(save));
reg_32 savedr31 (.clk(clk), .rst(rst), .data(savedr31Data), .writeData(r31Data), .write(save));

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
		(read1regsel == 5'b11110) ? r30Data:
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
assign r0Write =  (restore) ? 1'b1 : (writeregsel == 5'b00000) ? write : 0;
assign r1Write =  (restore) ? 1'b1 : (writeregsel == 5'b00001) ? write : 0;
assign r2Write =  (restore) ? 1'b1 : (writeregsel == 5'b00010) ? write : 0;
assign r3Write =  (restore) ? 1'b1 : (writeregsel == 5'b00011) ? write : 0;
assign r4Write =  (restore) ? 1'b1 : (writeregsel == 5'b00100) ? write : 0;
assign r5Write =  (restore) ? 1'b1 : (writeregsel == 5'b00101) ? write : 0;
assign r6Write =  (restore) ? 1'b1 : (writeregsel == 5'b00110) ? write : 0;
assign r7Write =  (restore) ? 1'b1 : (writeregsel == 5'b00111) ? write : 0;
assign r8Write =  (restore) ? 1'b1 : (writeregsel == 5'b01000) ? write : 0;
assign r9Write =  (restore) ? 1'b1 : (writeregsel == 5'b01001) ? write : 0;
assign r10Write = (restore) ? 1'b1 : (writeregsel == 5'b01010) ? write : 0;
assign r11Write = (restore) ? 1'b1 : (writeregsel == 5'b01011) ? write : 0;
assign r12Write = (restore) ? 1'b1 : (writeregsel == 5'b01100) ? write : 0;
assign r13Write = (restore) ? 1'b1 : (writeregsel == 5'b01101) ? write : 0;
assign r14Write = (restore) ? 1'b1 : (writeregsel == 5'b01110) ? write : 0;
assign r15Write = (restore) ? 1'b1 : (writeregsel == 5'b01111) ? write : 0;
assign r16Write = (restore) ? 1'b1 : (writeregsel == 5'b10000) ? write : 0;
assign r17Write = (restore) ? 1'b1 : (writeregsel == 5'b10001) ? write : 0;
assign r18Write = (restore) ? 1'b1 : (writeregsel == 5'b10010) ? write : 0;
assign r19Write = (restore) ? 1'b1 : (writeregsel == 5'b10011) ? write : 0;
assign r20Write = (restore) ? 1'b1 : (writeregsel == 5'b10100) ? write : 0;
assign r21Write = (restore) ? 1'b1 : (writeregsel == 5'b10101) ? write : 0;
assign r22Write = (restore) ? 1'b1 : (writeregsel == 5'b10110) ? write : 0;
assign r23Write = (restore) ? 1'b1 : (writeregsel == 5'b10111) ? write : 0;
assign r24Write = (restore) ? 1'b1 : (writeregsel == 5'b11000) ? write : 0;
assign r25Write = (restore) ? 1'b1 : (writeregsel == 5'b11001) ? write : 0;
assign r26Write = (restore) ? 1'b1 : (writeregsel == 5'b11010) ? write : 0;
assign r27Write = (restore) ? 1'b1 : (writeregsel == 5'b11011) ? write : 0;
assign r28Write = (restore) ? 1'b1 : (writeregsel == 5'b11100) ? write : 0;
assign r29Write = (restore) ? 1'b1 : (writeregsel == 5'b11101) ? write : 0;
assign r30Write = (restore) ? 1'b1 : (writeregsel == 5'b11110) ? write : 0;
assign r31Write = (restore) ? 1'b1 : (writeregsel == 5'b11111) ? write : 0;

// Assign the write data
assign r0writeData =  (restore) ? savedr0Data : writedata;
assign r1writeData =  (restore) ? savedr1Data : writedata;
assign r2writeData =  (restore) ? savedr2Data : writedata;
assign r3writeData =  (restore) ? savedr3Data : writedata;
assign r4writeData =  (restore) ? savedr4Data : writedata;
assign r5writeData =  (restore) ? savedr5Data : writedata;
assign r6writeData =  (restore) ? savedr6Data : writedata;
assign r7writeData =  (restore) ? savedr7Data : writedata;
assign r8writeData =  (restore) ? savedr8Data : writedata;
assign r9writeData =  (restore) ? savedr9Data : writedata;
assign r10writeData =  (restore) ? savedr10Data : writedata;
assign r11writeData =  (restore) ? savedr11Data : writedata;
assign r12writeData =  (restore) ? savedr12Data : writedata;
assign r13writeData =  (restore) ? savedr13Data : writedata;
assign r14writeData =  (restore) ? savedr14Data : writedata;
assign r15writeData =  (restore) ? savedr15Data : writedata;
assign r16writeData =  (restore) ? savedr16Data : writedata;
assign r17writeData =  (restore) ? savedr17Data : writedata;
assign r18writeData =  (restore) ? savedr18Data : writedata;
assign r19writeData =  (restore) ? savedr19Data : writedata;
assign r20writeData =  (restore) ? savedr20Data : writedata;
assign r21writeData =  (restore) ? savedr21Data : writedata;
assign r22writeData =  (restore) ? savedr22Data : writedata;
assign r23writeData =  (restore) ? savedr23Data : writedata;
assign r24writeData =  (restore) ? savedr24Data : writedata;
assign r25writeData =  (restore) ? savedr25Data : writedata;
assign r26writeData =  (restore) ? savedr26Data : writedata;
assign r27writeData =  (restore) ? savedr27Data : writedata;
assign r28writeData =  (restore) ? savedr28Data : writedata;
assign r29writeData =  (restore) ? savedr29Data : writedata;
assign r30writeData =  (restore) ? savedr30Data : writedata;
assign r31writeData =  (restore) ? savedr31Data : writedata;


endmodule
