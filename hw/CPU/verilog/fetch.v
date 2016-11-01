module fetch(
	    input clk,
	    input rst,
		input [31:0] instruction,
		input stall,
		input take_branch,
		input [31:0] branch_addr,
		output [31:0] PC_curr, 
	    output [31:0] PC_4,
	    output HALTED
);

	wire [31:0] PC_branch;

	wire [31:0] PC_new; 
	wire _continue;

	// HALT instruction
	// OR halt while the spart fifo is full for debug only
	assign _continue = (instruction[31:26] == 6'b000000) ? 1'b0 : 1'b1;
					
	assign HALTED = ~_continue & ~take_branch;

	assign PC_new = take_branch ? branch_addr :
				stall  ? PC_curr   : PC_4; 

	reg_32 pc_reg(
			.clk(clk), 
			.rst(rst), 
			.writeData(PC_new), 
			.write(~HALTED),
			.data(PC_curr)
		);

	add32 pc_incr(
			.A(PC_curr),
			.B(32'h4), 
			.Cin(1'b0), 
			.S(PC_4), 
			.Cout()
		);
		
endmodule
