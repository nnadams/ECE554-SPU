module decode(
	input [31:0] instr,
	input clk,
	input rst,

	/* Write Back inputs */
	input [31:0] write_reg_data,
	      
	/* Register Outputs */ 
	output [31:0] read1data,
	output [31:0] read2data,
	output rf_err,
 
	/* ALU Control Outputs */ 
	output [3:0] alu_op_out,
	output invA,
	output invB,
	output Cin,
	output sign,
	output alusrc,
	
	output [31:0] imm_value,
	
	/* Memory Control Outputs */
	output mem_write,
	output mem_read,
	output mem_enable,
	
	/* Writeback Control Outputs */
	output [1:0] write_reg_sel
);

wire [4:0] 	     reg_write;
wire 	         write_reg;
wire [4:0] 	     read_reg_1;
wire [4:0] 	     read_reg_2;

/* Register File Decode */ 
assign read_reg_1 = instr[25:21];
assign read_reg_2 = instr[20:16];

/* Memory Control */
assign mem_write = 
				(instr[31:26] == 6'b010000) ? 1'b1 :
				(instr[31:26] == 6'b010011) ? 1'b1 : 1'b0;			
				  
assign mem_read = (instr[31:26] == 6'b010001) ? 1'b1 : 1'b0;
assign mem_enable = mem_read | mem_write;

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
		   .opcode(instr[31:26]),
		   .aluop(instr[1:0]), 
		   .Op(alu_op_out),
		   .invA(invA),
		   .invB(invB),
		   .Cin(Cin), 
		   .sign(sign), 
		   .alusrc(alusrc)
		); 

/* Writeback Control Outputs */ 
writebackcontrol wbcont (
			.instr(instr), 
			.reg_write(reg_write), 
			.write_reg(write_reg), 
			.write_reg_sel(write_reg_sel)
		);

/* Immediate Logic */
imm_decode im_dec (
		  .instr(instr), 
		  .imm_value(imm_value)
		);

endmodule
