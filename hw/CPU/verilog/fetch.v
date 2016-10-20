module fetch(
	    input clk,
	    input rst,
	    input N,
	    input Z,
	    input [31:0] reg_data_1,
		input [31:0] immediate,
		input [31:0] instruction,
		output [31:0] PC_curr, 
	    output [31:0] PC_4,
	    output HALT
);

wire [31:0] PC_branch;
wire 	    take_branch;

wire [31:0] PC_new; 
wire _continue;

// HALT instruction
assign _continue = (instruction[31:26] == 6'b000000) ? 1'b0 : 1'b1;
assign HALT = ~_continue;

assign PC_new = take_branch ? PC_branch : PC_4; 

reg_32 pc_reg(
			.clk(clk), 
			.rst(rst), 
			.writeData(PC_new), 
			.write(_continue),
			.data(PC_curr)
		);

add32 pc_incr(
			.A(PC_curr),
			.B(32'h4), 
			.Cin(1'b0), 
			.S(PC_4), 
			.Cout()
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
