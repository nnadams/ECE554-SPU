/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
module proc (/*AUTOARG*/
   // Outputs
   err, 
   // Inputs
   clk, rst
   );

   input clk;
   input rst;

   output err;

   // None of the above lines can be modified

   // OR all the err ouputs for every sub-module and assign it as this
   // err output
   
   // As desribed in the homeworks, use the err signal to trap corner
   // cases that you think are illegal in your statemachines
   
 
   // Fetch Outputs  
   wire [15:0] instruction; 
   wire [15:0] PC_2; 
   wire        HALT; 
   
   // Decode Outputs  
   wire [15:0] reg_data_1;
   wire [15:0] reg_data_2;
   wire        rf_err;
   wire [3:0] aluop;    
   wire       invA; 
   wire       invB;
   wire       Cin; 
   wire       sign;
   wire       alusrc;
   wire [15:0] imm_value;  
   wire        mem_write; 
   wire        mem_enable; 
   wire        mem_read; 
   wire [1:0]  write_reg_sel; 
   
   // ALU Outputs 
   wire        ofl; 
   wire        Z;
   wire        N; 
   wire [15:0] alu_out; 
   
   // Memory Outputs 
   wire [15:0] mem_out;
   
   // WriteBack Outputs    
   wire [15:0] reg_write_data;


   
	
   // Fetch Unit
   fetch F ( 
	     /*Inputs*/
	     .clk(clk),
	     .rst(rst),
	     .N(N),
	     .Z(Z),
	     .reg_data_1(reg_data_1),
	     /*Outputs*/
	     .instruction(instruction),
	     .PC_2(PC_2),
	     .HALT(HALT));
   
   // Decode Unit
   decode D  (
	      /*Inputs*/
	      .instr(instruction), 
	      .clk(clk),
	      .rst(rst),
	      .write_reg_data(reg_write_data),
	      /*Register File Outputs*/
	      .read1data(reg_data_1), 
	      .read2data(reg_data_2), 
	      .rf_err(rf_err), 
	      /*ALU Control Outputs*/ 
	      .alu_op_out(aluop), 
	      .invA(invA),
	      .invB(invB),
	      .Cin(Cin), 
	      .sign(sign), 
	      .alusrc(alusrc), 
	      .imm_value(imm_value),
	      /*Memory Outputs */
	      .mem_write(mem_write), 
	      .mem_enable(mem_enable),
	      .mem_read(mem_read), 
	      /*Writeback Outputs*/
	      .write_reg_sel(write_reg_sel)
	      );


   // Execute Unit
   execute EX (
	       /*Inputs*/
	       .reg_data_1(reg_data_1), 
	       .reg_data_2(reg_data_2),
	       .imm_value(imm_value),
	       .alusrc(alusrc),
	       .invA(invA),
	       .invB(invB), 
	       .Cin(Cin),
	       .sign(sign),
	       .aluop(aluop),
	       /*Outputs*/
	       .Out(alu_out),
	       .Z(Z),
	       .N(N),
	       .ofl(ofl)
	       );
   
   // MEM Unit
   memory MEM (
	       /*Inputs*/
	       .data_in(reg_data_2), 
	       .addr(alu_out),
	       .enable(mem_enable), 
	       .wr(mem_write),
	       .createdump(HALT),
	       .clk(clk),
	       .rst(rst),
	       /*Outputs*/
	       .data_out(mem_out)
	       );
   
						
   // WriteBack Unit
   writeback WB (
		 /* Inputs */
		 .alu_out(alu_out),
		 .mem_out(mem_out),
		 .PC_2(PC_2),
		 .write_reg_sel(write_reg_sel),
		 .flag_opcode(instruction[12:11]),
		 .Z(Z),
		 .N(N),
		 .ofl(ofl),
		 .A_Sign(reg_data_1[15]),
		 .B_Sign(reg_data_2[15]),
		 
		 /*Outputs*/
		 .reg_write_data(reg_write_data)
		 );
   
endmodule // proc
// DUMMY LINE FOR REV CONTROL :0:
