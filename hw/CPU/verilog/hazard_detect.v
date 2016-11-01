module hazard_detect (
	input [4:0] decodeRegRead1,
	input [4:0] decodeRegRead2,
	input [4:0] executeWriteReg,
	input       executeWriteRegEn,
	input [4:0] memoryWriteReg, 
	input       memoryWriteRegEn,
	input       reg2used,
	input       mem_stall,
	input [5:0] ex_opcode,
	input [5:0] id_opcode,
	input clk,
	input rst,
	input SPART_STALL_DBG_ONLY,

	output stall_id,
	output stall_all,
	output forward_MEM_EX_A,
	output forward_MEM_EX_B,
	output forward_WB_EX_A,
	output forward_WB_EX_B
);
   
	wire ex_match1; 
	wire ex_match2;
	wire ex_stall_A;
	wire ex_stall_B; 
	wire forward_MEM_EX_in_A; 
	wire forward_MEM_EX_in_B; 
	wire isStoreInstr;
	wire isLdInstr;
	wire isJumpInstr; 

	wire mem_match1; 
	wire mem_match2;
	wire mem_use_stall_A;
	wire mem_use_stall_B;
	wire forward_WB_EX_in_A; 
	wire forward_WB_EX_in_B; 

	// MEM -> EX Hazard Detection
	// Do the registers in the instructions match?
	assign ex_match1 = decodeRegRead1 == executeWriteReg ? 1'b1 : 1'b0;
	assign ex_match2 = decodeRegRead2 == executeWriteReg ? reg2used : 1'b0;

	// Stall signals for each register
	assign ex_stall_A = ex_match1 & executeWriteRegEn;
	assign ex_stall_B = ex_match2 & executeWriteRegEn;

	// Only stall overall if we cannot forward 
	assign ex_stall = ( (isJumpInstr & ex_stall_A) | (isStoreInstr & ex_stall_B) | (ex_stall_A & ~forward_MEM_EX_in_A) | (ex_stall_B & ~forward_MEM_EX_in_B) );

	// We cant forward if it is a memory load instruction currently in the execute phase
	assign isLdInstr = (ex_opcode == 6'b010001) ? 1'b1 : 1'b0;
								
	// We cant forward the store data. 
	assign isStoreInstr = (id_opcode == 6'b010000) | (id_opcode == 6'b010011);

	// Cant Forward Jump Stuff
	assign isJumpInstr = (id_opcode == 6'b000101 | id_opcode == 6'b000111);

	// Forwarding assignments
	assign forward_MEM_EX_in_A = (stall_all) ? forward_MEM_EX_A :
							(isLdInstr) ? 1'b0 : ex_stall_A; 
	assign forward_MEM_EX_in_B = (stall_all) ? forward_MEM_EX_B :
							(isLdInstr) ? 1'b0 : ex_stall_B; 

	// Flip flops, since we want the forwarding signal to be asserted on the next clock cycle
	dff mem_ex_ff_a (.q(forward_MEM_EX_A), .d(forward_MEM_EX_in_A), .clk(clk), .rst(rst));
	dff mem_ex_ff_b (.q(forward_MEM_EX_B), .d(forward_MEM_EX_in_B), .clk(clk), .rst(rst));

	// WB -> EX Hazard Detection
	// Register matches for memory and decode 
	assign mem_match1 = decodeRegRead1 == memoryWriteReg ? 1'b1 : 1'b0;
	assign mem_match2 = decodeRegRead2 == memoryWriteReg ? reg2used : 1'b0;

	assign mem_use_stall_A = mem_match1 & memoryWriteRegEn;
	assign mem_use_stall_B = mem_match2 & memoryWriteRegEn;

	// Overall Stall if we cannot forward.
	assign mem_use_stall = ( (isJumpInstr & mem_use_stall_A) | (isStoreInstr & mem_use_stall_B) | (mem_use_stall_A & ~forward_WB_EX_in_A) | (mem_use_stall_B & !forward_WB_EX_in_B));				

	// Forwarding Assignments
	assign forward_WB_EX_in_A = stall_all ? forward_WB_EX_A : mem_use_stall_A;
	assign forward_WB_EX_in_B = stall_all ? forward_WB_EX_B : mem_use_stall_B;

	dff wb_ex_ff_a (.q(forward_WB_EX_A), .d(forward_WB_EX_in_A), .clk(clk), .rst(rst));
	dff wb_ex_ff_b (.q(forward_WB_EX_B), .d(forward_WB_EX_in_B), .clk(clk), .rst(rst));

	// Finally, The stall outputs 
	assign stall_id = ex_stall | mem_use_stall | mem_stall | SPART_STALL_DBG_ONLY;
	assign stall_all = mem_stall | SPART_STALL_DBG_ONLY;
   
endmodule
