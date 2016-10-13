module decode(
	input [15:0] instr,
	input clk,
	input rst,

	/* Write Back inputs */
	input [15:0] write_reg_data,
	      
	/* Register Outputs */ 
	output [15:0] read1data,
	output [15:0] read2data,
	output rf_err,
 
	/* ALU Control Outputs */ 
	output [3:0] alu_op_out,
	output invA,
	output invB,
	output Cin,
	output sign,
	output alusrc,
	
	output [15:0] imm_value,
	
	/* Memory Control Outputs */
	output mem_write,
	output mem_read,
	output mem_enable,
	
	/* Writeback Control Outputs */
	output [1:0] write_reg_sel
);


   wire [2:0] 	     reg_write;
   wire 	     write_reg;
   wire [2:0] 	     read_reg_1;
   wire [2:0] 	     read_reg_2;
   
   /* Register File Decode */ 
   assign read_reg_1 = instr[10:8];
   assign read_reg_2 = instr[7:5];

   // Register File
   rf regfile (
	       .read1data(read1data),
	       .read2data(read2data),
	       .clk(clk),
	       .rst(rst),
	       .read1regsel(read_reg_1), 
	       .read2regsel(read_reg_2), 
	       .writedata(write_reg_data),
	       .write(write_reg),
	       .writeregsel(reg_write), 
	       .err(rf_err)
	       );
   
   /* ALU Control Decode Block */
   alucontrol alucont (
		       .opcode(instr[15:11]),
		       .aluop(instr[1:0]), 
		       .Op(alu_op_out),
		       .invA(invA),
		       .invB(invB),
		       .Cin(Cin), 
		       .sign(sign), 
		       .alusrc(alusrc)); 

   /* Memory Control */
   assign mem_write = (instr[15:11] == 5'b10000) ? 1'b1 :
                      (instr[15:11] == 5'b10011) ? 1'b1 : 1'b0;				   
   assign mem_read = (instr[15:11] == 5'b10001) ? 1'b1 : 1'b0;
   assign mem_enable = mem_read | mem_write;

   /* Writeback Control Outputs */ 
   writebackcontrol wbcont (
			    .instr(instr), 
			    .reg_write(reg_write), 
			    .write_reg(write_reg), 
			    .write_reg_sel(write_reg_sel)
			    );

   imm_decode im_dec (
		      .instr(instr), 
		      .imm_value(imm_value)
		      );

endmodule
