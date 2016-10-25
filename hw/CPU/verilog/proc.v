module proc (
   // Outputs 
   output [31:0] data_mem_addr, 
   output [31:0] data_mem_write_data,
   output data_mem_wr,
   output data_mem_en,
   output [31:0] PC_curr,
   // Inputs
   input clk,
   input rst,
   input [31:0] data_mem_data, 
   input [31:0] instruction,
   
   // DBG ONLY
   input SPART_STALL_DBG_ONLY
   );

   // Fetch Outputs  
   wire [31:0] PC_4; 
   wire        HALT; 
   
   // Decode Outputs  
   wire [31:0] reg_data_1;
   wire [31:0] reg_data_2;
   wire [3:0] aluop;    
   wire       invA; 
   wire       invB;
   wire       Cin; 
   wire       sign;
   wire       alusrc;
   wire [31:0] imm_value;  
   wire        mem_write; 
   wire        mem_enable; 
   wire        mem_read; 
   wire [1:0]  write_reg_sel; 
   
   // ALU Outputs 
   wire        ofl; 
   wire        Z;
   wire        N; 
   wire [31:0] alu_out; 
   
   // WriteBack Outputs    
   wire [31:0] reg_write_data; 
	
   // Fetch Unit
   fetch F ( 
	     /*Inputs*/
	     .clk(clk),
	     .rst(rst),
	     .N(N),
	     .Z(Z),
	     .reg_data_1(reg_data_1),
		 .immediate(imm_value),
		 .instruction(instruction),
		 // DBG ONLY
		 .SPART_STALL_DBG_ONLY(SPART_STALL_DBG_ONLY),
	     /*Outputs*/
		 .PC_curr(PC_curr),
	     .PC_4(PC_4),
	     .HALT(HALT)
		);
   
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
   
   // External Memory Unit
   assign data_mem_write_data = reg_data_2;
   assign data_mem_addr = alu_out;
   assign data_mem_wr = mem_write;
   assign data_mem_en = mem_enable;
   
						
   // WriteBack Unit
   writeback WB (
		 /* Inputs */
		 .alu_out(alu_out),
		 .mem_out(data_mem_data),
		 .PC_4(PC_4),
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
   
endmodule
