module writeback (
		  input [31:0] alu_out,
		  input [31:0] mem_out,
		  input [31:0] PC_4,
		  input [2:0]  write_reg_sel,
		  input [1:0]  flag_opcode,
        input [3:0]  spu_reg,
		  input Z,
		  input N,
		  input ofl,
		  input A_Sign,
		  input B_Sign,
      		  
		  output [31:0] reg_write_data
);

wire [31:0] 			flag_out;

assign reg_write_data = 
			(write_reg_sel == 3'b000) ? alu_out :
			(write_reg_sel == 3'b001) ? mem_out :
			(write_reg_sel == 3'b010) ? PC_4    :
			(write_reg_sel == 3'b011) ? flag_out :
         (write_reg_sel == 3'b100) ? {{28{1'b0}},spu_reg} : 32'hxxxx;

flag_instr_logic flag_logic (
		.opcode(flag_opcode), 
		.ofl(ofl),
		.Z(Z), 
		.N(N),
		.A_Sign(A_Sign), 
		.B_Sign(B_Sign), 
		.Out(flag_out)
	);

endmodule
