module fetch(
	    input clk,
	    input rst,
		input [31:0] instruction_in,
		input stall,
		input take_branch,
		input [31:0] branch_addr,
		input spart_int,
		input spu_int, 
	    output [31:0] PC_4,
		output [31:0] instr_addr, 
	    output HALTED,
		output [31:0] instruction_out,
		output save_regs,
		output restore_regs
);

	wire [31:0] PC_new; 
	wire _continue;
	wire [31:0] PC_curr;
	wire [31:0] PC_INT; 
	wire int_wait; 
	wire int_run; 
	wire int_done; 
	wire [31:0] PC_resume; 
	
	// HALT instruction
	// OR halt while the spart fifo is full for debug only
	assign _continue = (int_wait | int_run) ? 1'b1 : 
					   (instruction_in[31:26] == 6'b000000) ? 1'b0 : 1'b1;
					
	assign HALTED = ~_continue & ~take_branch;

	assign PC_new = (int_wait | int_run) ? PC_INT       : 
					(int_done)           ? PC_resume    :
					take_branch          ? branch_addr  :
					(stall)   ? PC_curr      : PC_4; 

	// NOP the one cycle delay when we need to switch to a new PC thats not PC + 4
	assign instruction_out = ( int_wait | take_branch | int_done | int_run) ? 32'b000001xxxxxxxxxxxxxxxxxxxxxxxxxx : instruction_in;
	
	assign restore_regs = int_done;
	assign save_regs = int_run;
	
	// The address we want to read from IMEM. 
	// Case 1 - we saw a HALT instruction, lets keep it reading that instruction 
	// Case 2 - we are changing the PC to something different in a branch or interrupt - read the newly calculated PC 
	// Case 3 - normal case - read PC + 4 so it is ready for the next cycle
	assign instr_addr = (HALTED) ? PC_curr : (stall | take_branch | int_wait | int_run | int_done) ? PC_new : PC_4;

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
			.int_run(int_run),
			.int_done(int_done), 
			.PC_RESUME(PC_resume)
		);

endmodule
