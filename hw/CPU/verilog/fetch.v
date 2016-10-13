module fetch(
	    input clk,
	    input rst,
	    input N,
	    input Z,
	    input [15:0] reg_data_1,
	    output [15:0] instruction,
	    output [15:0] PC_2,
	    output HALT
);

   wire [15:0] 	   PC_branch;
   wire 	  take_branch;

   
   instr_fetch ifetch (
		       .clk(clk), 
		       .rst(rst), 
		       .instr(instruction), 
		       .PC_2(PC_2),
		       .HALT(HALT),
		       .PC_branch(PC_branch), 
		       .take_branch(take_branch)
		       );
   
   branch_control branches(
			   .instr(instruction), 
			   .reg_read(reg_data_1),
			   .N(N),
			   .Z(Z), 
			   .PC_2(PC_2),
			   .PC_branch(PC_branch), 
			   .take_branch(take_branch)
			   );
endmodule
