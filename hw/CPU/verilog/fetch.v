module fetch(
	    input clk,
	    input rst,
	    input N,
	    input Z,
	    input [31:0] reg_data_1,
		input [31:0] immediate,
	    output [31:0] instruction,
	    output [31:0] PC_4,
	    output HALT
);

wire [31:0] PC_branch;
wire 	    take_branch;

instr_fetch ifetch (
		    .clk(clk), 
		    .rst(rst), 
		    .instr(instruction), 
		    .PC_4(PC_4),
		    .HALT(HALT),
		    .PC_branch(PC_branch), 
		    .take_branch(take_branch)
		);
   
branch_control bc(
			.instr(instruction), 
			.reg_read(reg_data_1),
			.N(N),
			.Z(Z), 
			.immediate(immediate),
			.PC_4(PC_4),
			.PC_branch(PC_branch), 
			.take_branch(take_branch)
		);
		
endmodule
