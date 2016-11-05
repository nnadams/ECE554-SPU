module fetch(
	    input clk,
	    input rst,
		input [31:0] instruction_in,
		input stall,
		input take_branch,
		input [31:0] branch_addr,
		input spart_int,
		input spu_int, 
		output [31:0] PC_curr, 
	    output [31:0] PC_4,
	    output HALTED,
		output [31:0] instruction_out
);

	wire [31:0] PC_branch;

	wire [31:0] PC_new; 
	wire _continue;

	wire [31:0] PC_int; 
	wire int_wait; 
	wire int_run; 
	wire int_done; 
	wire [31:0] PC_resume; 
	
	// HALT instruction
	// OR halt while the spart fifo is full for debug only
	assign _continue = (instruction_in[31:26] == 6'b000000) ? 1'b0 : 1'b1;
					
	assign HALTED = ~_continue & ~take_branch;

	assign PC_new = (int_wait | int_run) ? PC_INT : 
					take_branch ? branch_addr :
					stall  ? PC_curr   : PC_4; 

	// NOP While waiting for interrupt 
	assign instruction_out = int_wait ? 32'b00001xxxxxxxxxxxxxxxxxxxxxxxxxxx : instruction_in;
	
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
		
	interrupt_controller int_control(
			.clk(clk), 
			.rst(rst), 
			.spart_int(spart_int),
			.spu_int(spu_int),
			.PC_CURR(PC_curr),
			.take_branch(take_branch), 
			.PC_BRANCH(branch_addr),
			.instruction(instruction_in), 

			.PC_INT(PC_INT),
			.int_wait(int_wait),
			.int_run(.int_run),
			.int_done(int_done), 
			.PC_RESUME(PC_resume)
		);

endmodule
