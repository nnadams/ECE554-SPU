module writeback (
		  input [15:0] alu_out,
		  input [15:0] mem_out,
		  input [15:0] PC_2,
		  input [1:0]  write_reg_sel,
		  input [1:0]  flag_opcode,
		  input Z,
		  input N,
		  input ofl,
		  input A_Sign,
		  input B_Sign,
      		  
		  output [15:0] reg_write_data
		  );

   wire [15:0] 			flag_out;
    
   assign reg_write_data = (write_reg_sel == 2'b00) ? alu_out :
			   (write_reg_sel == 2'b01) ? mem_out :
		       	   (write_reg_sel == 2'b10) ? PC_2    :
		       	   (write_reg_sel == 2'b11) ? flag_out : 15'hxxxx;

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
