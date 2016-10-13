/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
module rf (
           // Outputs
           read1data, read2data, err,
           // Inputs
           clk, rst, read1regsel, read2regsel, writeregsel, writedata, write
           );
   input clk, rst;
   input [2:0] read1regsel;
   input [2:0] read2regsel;
   input [2:0] writeregsel;
   input [15:0] writedata;
   input        write;

   output [15:0] read1data;
   output [15:0] read2data;
   output        err;

   // Output data from each register
   wire [15:0] 	 r0Data;
   wire [15:0] 	 r1Data;
   wire [15:0] 	 r2Data;
   wire [15:0] 	 r3Data;
   wire [15:0] 	 r4Data;
   wire [15:0] 	 r5Data;
   wire [15:0] 	 r6Data;
   wire [15:0] 	 r7Data;

   // Individual write selects for each register 
   wire 	 r0Write;
   wire 	 r1Write;
   wire 	 r2Write;
   wire 	 r3Write;
   wire 	 r4Write;
   wire 	 r5Write;
   wire 	 r6Write;
   wire 	 r7Write;

   // The registers
   reg_16 r0 (.clk(clk), .rst(rst), .writeData(writedata), .data(r0Data), .write(r0Write));
   reg_16 r1 (.clk(clk), .rst(rst), .writeData(writedata), .data(r1Data), .write(r1Write));
   reg_16 r2 (.clk(clk), .rst(rst), .writeData(writedata), .data(r2Data), .write(r2Write));
   reg_16 r3 (.clk(clk), .rst(rst), .writeData(writedata), .data(r3Data), .write(r3Write));
   reg_16 r4 (.clk(clk), .rst(rst), .writeData(writedata), .data(r4Data), .write(r4Write));
   reg_16 r5 (.clk(clk), .rst(rst), .writeData(writedata), .data(r5Data), .write(r5Write));
   reg_16 r6 (.clk(clk), .rst(rst), .writeData(writedata), .data(r6Data), .write(r6Write));
   reg_16 r7 (.clk(clk), .rst(rst), .writeData(writedata), .data(r7Data), .write(r7Write));

   // MUX for putting the correct read data on the port
   assign read1data = (read1regsel == 3'b000) ? r0Data:
		      (read1regsel == 3'b001) ? r1Data:
		      (read1regsel == 3'b010) ? r2Data:
		      (read1regsel == 3'b011) ? r3Data:
		      (read1regsel == 3'b100) ? r4Data:
		      (read1regsel == 3'b101) ? r5Data:
		      (read1regsel == 3'b110) ? r6Data:
		      (read1regsel == 3'b111) ? r7Data:
		      16'h0000;

   assign read2data = (read2regsel == 3'b000) ? r0Data:
		      (read2regsel == 3'b001) ? r1Data:
		      (read2regsel == 3'b010) ? r2Data:
		      (read2regsel == 3'b011) ? r3Data:
		      (read2regsel == 3'b100) ? r4Data:
		      (read2regsel == 3'b101) ? r5Data:
		      (read2regsel == 3'b110) ? r6Data:
		      (read2regsel == 3'b111) ? r7Data:
		      16'h0000;

   
   // Assert the write for the correct register, if necessary
   assign r0Write = (writeregsel == 3'b000) ? write : 0;
   assign r1Write = (writeregsel == 3'b001) ? write : 0;
   assign r2Write = (writeregsel == 3'b010) ? write : 0;
   assign r3Write = (writeregsel == 3'b011) ? write : 0;
   assign r4Write = (writeregsel == 3'b100) ? write : 0;
   assign r5Write = (writeregsel == 3'b101) ? write : 0;
   assign r6Write = (writeregsel == 3'b110) ? write : 0;
   assign r7Write = (writeregsel == 3'b111) ? write : 0;

endmodule
// DUMMY LINE FOR REV CONTROL :1:
