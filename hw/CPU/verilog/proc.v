module proc (
   // Outputs 
   output [31:0] data_mem_addr, 
   output [31:0] data_mem_write_data,
   output data_mem_wr,
   output data_mem_en,
   output [31:0] PC_curr,
   output HALTED,
   // Inputs
   input clk,
   input rst,
   input [31:0] data_mem_data, 
   input [31:0] instruction,
   
   // Interrupts 
   input spart_int, 
   input spu_int,
   
   // DBG ONLY
   input SPART_STALL_DBG_ONLY
   );

   // Fetch Outputs  
   wire [31:0] if_PC_4; 
   wire        if_HALT; 
   wire [31:0] instruction_fetch;
   wire        save_regs; 
   wire        restore_regs; 
   
   // Pipelined Fetch outputs (Decode Inputs)
   wire [31:0] id_instruction; 
   wire [31:0] id_PC_4; 
   wire        id_HALT; 
   
   // Decode Outputs  
   wire [31:0] id_reg_data_1;
   wire [31:0] id_reg_data_2;
   wire [3:0]  id_aluop;    
   wire        id_invA; 
   wire        id_invB;
   wire        id_Cin; 
   wire        id_sign;
   wire        id_alusrc;
   wire [31:0] id_imm_value;  
   wire        id_mem_write; 
   wire        id_mem_enable; 
   wire        id_mem_read; 
   wire [1:0]  id_write_data_sel;
   wire [4:0]  id_write_reg_sel;
   wire        id_write_reg_en;   
   
   // Pipelined Decode Outputs (Execute Inputs)
   wire [31:0] ex_reg_data_1;
   wire [31:0] ex_reg_data_2;
   wire [3:0]  ex_aluop;    
   wire        ex_invA; 
   wire        ex_invB;
   wire        ex_Cin; 
   wire        ex_sign;
   wire        ex_alusrc;
   wire [31:0] ex_imm_value;  
   wire        ex_mem_write; 
   wire        ex_mem_enable; 
   wire        ex_mem_read; 
   wire [1:0]  ex_write_data_sel;
   wire [4:0]  ex_write_reg_sel;
   wire        ex_write_reg_en; 
   wire [31:0] ex_instruction; 
   wire [31:0] ex_PC_4; 
   wire        ex_HALT; 
   
   // ALU Outputs 
   wire        ex_ofl; 
   wire        ex_Z;
   wire        ex_N; 
   wire [31:0] ex_alu_out;
   
   // Pipelined Execute Outputs (Memory Inputs)
   wire [31:0] mem_alu_out;
   wire        mem_ofl; 
   wire        mem_Z;
   wire        mem_N; 
   wire [31:0] mem_reg_data_1;
   wire [31:0] mem_reg_data_2;  
   wire        mem_mem_write;
   wire        mem_mem_enable;
   wire        mem_mem_read;
   wire [1:0]  mem_write_data_sel;
   wire [4:0]  mem_write_reg_sel;
   wire        mem_write_reg_en; 
   wire [31:0] mem_instruction;
   wire [31:0] mem_PC_4;
   wire 	   mem_HALT;
   
   // Memory Outputs 
   wire [31:0] mem_mem_out;
   
   // Branch Control Outputs
   wire        take_branch;
   wire [31:0] branch_addr;
   
   // Pipelined Memory Outputs (Writeback Inputs)
   wire [31:0] wb_mem_out;
   wire [31:0] wb_alu_out;
   wire [31:0] wb_PC_4;
   wire [1:0]  wb_write_data_sel;
   wire [4:0]  wb_write_reg_sel;
   wire        wb_write_reg_en;    
   wire [31:0] wb_instruction;
   wire 	   wb_Z;
   wire        wb_N;
   wire        wb_ofl;
   wire [31:0] wb_reg_data_1; 
   wire [31:0] wb_reg_data_2; 
   wire        wb_HALT;
   
   // WriteBack Outputs    
   wire [31:0] wb_reg_write_data;

   // Hazard Unit Outputs
   wire        stall_id;
   wire        stall_all;       
   wire        reg2used;
   wire        flush_if;
   wire        flush_id;
   wire        flush_ex;
   wire forward_MEM_EX_A;
   wire forward_MEM_EX_B;
   wire forward_WB_EX_A;
   wire forward_WB_EX_B;
	
	// Halt Only after it makes it to the WB stage 
	assign HALTED = wb_HALT;
	
   // Fetch Unit
   fetch F ( 
	     /*Inputs*/
	     .clk(clk),
	     .rst(rst),
	     .take_branch(take_branch),
	     .branch_addr(branch_addr),
	     .stall(stall_id),
		 .instruction_in(instruction),
		 .spart_int(spart_int),
		 .spu_int(spu_int),
	     /*Outputs*/
	     .PC_curr(PC_curr),
	     .PC_4(if_PC_4),
	     .HALTED(if_HALT),
		 .instruction_out(instruction_fetch),
		 .save_regs(save_regs),
		 .restore_regs(restore_regs)
	);

   // IF -> ID Pipeline Register
   pipeReg_if_id if_id (
		/* Inputs */
		.clk(clk),
		.rst(rst),
		.stall(stall_id),
		.flush_if(flush_if),
		.if_instruction(instruction_fetch),
		.if_HALT(if_HALT),
		.if_PC_4(if_PC_4),
		/*Outputs*/
		.id_instruction(id_instruction),
		.id_HALT(id_HALT),
		.id_PC_4(id_PC_4)
	);
   
   // Decode Unit
   decode D  (
		/*Inputs*/
		.clk(clk),
		.rst(rst),
		.instr(id_instruction),
		.write_reg_data_in(wb_reg_write_data),
		.write_reg_sel_in(wb_write_reg_sel),
		.write_reg_en_in(wb_write_reg_en),
		.save_regs(save_regs),
		.restore_regs(restore_regs),
		/*Register File Outputs*/
		.read1data(id_reg_data_1), 
		.read2data(id_reg_data_2), 
		/*ALU Control Outputs*/ 
		.alu_op_out(id_aluop), 
		.invA(id_invA),
		.invB(id_invB),
		.Cin(id_Cin), 
		.sign(id_sign), 
		.alusrc(id_alusrc), 
		.imm_value(id_imm_value),
		/*Memory Outputs */
		.mem_write(id_mem_write), 
		.mem_enable(id_mem_enable),
		.mem_read(id_mem_read), 
		/*Writeback Outputs*/
		.write_data_sel_out(id_write_data_sel),
		.write_reg_sel_out(id_write_reg_sel),
		.write_reg_en_out(id_write_reg_en),
		.reg2used(reg2used)
	);

   // ID -> EX Pipeline Register
   pipeReg_id_ex id_ex (
		/*Inputs*/
		.clk(clk),
		.rst(rst),
		.flush_id(flush_id),
		.id_reg_data_1(id_reg_data_1),
		.id_reg_data_2(id_reg_data_2),
		.id_aluop(id_aluop),
		.id_invA(id_invA),
		.id_invB(id_invB),
		.id_Cin(id_Cin),
		.id_sign(id_sign),
		.id_alusrc(id_alusrc),
		.id_imm_value(id_imm_value),
		.id_mem_write(id_mem_write),
		.id_mem_enable(id_mem_enable),
		.id_mem_read(id_mem_read),
		.id_write_data_sel(id_write_data_sel),
		.id_write_reg_sel(id_write_reg_sel),
		.id_write_reg_en(id_write_reg_en),
		.id_instruction(id_instruction),
		.id_PC_4(id_PC_4),
		.id_HALT(id_HALT),
		.stall(stall_all),

		/*Outputs*/
		.ex_reg_data_1(ex_reg_data_1),
		.ex_reg_data_2(ex_reg_data_2),
		.ex_aluop(ex_aluop),
		.ex_invA(ex_invA),
		.ex_invB(ex_invB),
		.ex_Cin(ex_Cin),
		.ex_sign(ex_sign),
		.ex_alusrc(ex_alusrc),
		.ex_imm_value(ex_imm_value),
		.ex_mem_write(ex_mem_write),
		.ex_mem_enable(ex_mem_enable),
		.ex_mem_read(ex_mem_read),
		.ex_write_data_sel(ex_write_data_sel),
		.ex_write_reg_sel(ex_write_reg_sel),
		.ex_write_reg_en(ex_write_reg_en),
		.ex_instruction(ex_instruction),
		.ex_PC_4(ex_PC_4),
		.ex_HALT(ex_HALT)
	);
	
	// Execute Forwarding Logic 
	wire [31:0] ex_data_in_A;
	wire [31:0] ex_data_in_B;
	
	assign ex_data_in_A = forward_MEM_EX_A ? mem_alu_out :
						  forward_WB_EX_A  ? wb_reg_write_data : ex_reg_data_1;
						  
	assign ex_data_in_B = forward_MEM_EX_B ? mem_alu_out :
					      forward_WB_EX_B  ? wb_reg_write_data : ex_reg_data_2;
						  
   // Execute Unit
   execute EX (
		/*Inputs*/
		.reg_data_1(ex_data_in_A), 
		.reg_data_2(ex_data_in_B),
		.imm_value(ex_imm_value),
		.alusrc(ex_alusrc),
		.invA(ex_invA),
		.invB(ex_invB), 
		.Cin(ex_Cin),
		.sign(ex_sign),
		.aluop(ex_aluop),
		/*Outputs*/
		.Out(ex_alu_out),
		.Z(ex_Z),
		.N(ex_N),
		.ofl(ex_ofl)
	);
   
   // EX -> MEM Pipeline Register 
   pipeReg_ex_mem ex_mem (
		/*Inputs*/
		.clk(clk),
		.rst(rst),
		.flush_ex(flush_ex),
		.ex_alu_out(ex_alu_out),
		.ex_Z(ex_Z),
		.ex_N(ex_N),
		.ex_ofl(ex_ofl),
		.ex_reg_data_1(ex_reg_data_1),
		.ex_reg_data_2(ex_reg_data_2),
		.ex_mem_write(ex_mem_write),
		.ex_mem_enable(ex_mem_enable),
		.ex_mem_read(ex_mem_read),
		.ex_write_data_sel(ex_write_data_sel),
		.ex_write_reg_sel(ex_write_reg_sel),
		.ex_write_reg_en(ex_write_reg_en),
		.ex_instruction(ex_instruction),
		.ex_PC_4(ex_PC_4),
		.ex_HALT(ex_HALT),
		.stall(stall_all),
		
		/*Outputs*/
		.mem_alu_out(mem_alu_out),
		.mem_Z(mem_Z),
		.mem_N(mem_N),
		.mem_ofl(mem_ofl),
		.mem_reg_data_1(mem_reg_data_1),
		.mem_reg_data_2(mem_reg_data_2),
		.mem_mem_write(mem_mem_write),
		.mem_mem_enable(mem_mem_enable),
		.mem_mem_read(mem_mem_read),
		.mem_write_data_sel(mem_write_data_sel),
		.mem_write_reg_sel(mem_write_reg_sel),
		.mem_write_reg_en(mem_write_reg_en),
		.mem_instruction(mem_instruction),
		.mem_PC_4(mem_PC_4),
		.mem_HALT(mem_HALT)
	);
	
	// External, Single Cycle Memory 
	assign data_mem_addr = mem_alu_out;
	assign data_mem_write_data = mem_reg_data_2;
	assign data_mem_wr = mem_mem_write;
	assign data_mem_en = mem_mem_enable;
	assign mem_mem_out = data_mem_data;

	// Branch Control Unit - Branches Resolved in MEM Stage
	branch_control bc (
		.instr(mem_instruction),
		.reg_read(mem_reg_data_1),
		.N(mem_N),
		.Z(mem_Z),
		.PC_4(mem_PC_4),
		.PC_branch(branch_addr),
		.take_branch(take_branch)
	);
					
	// MEM -> WB Pipeline Register
	pipeReg_mem_wb mem_wb(
		/* Inputs */
		.clk(clk),
		.rst(rst),
		.mem_mem_out(mem_mem_out),
		.mem_alu_out(mem_alu_out),
		.mem_Z(mem_Z),
		.mem_N(mem_N),
		.mem_ofl(mem_ofl),
		.mem_write_data_sel(mem_write_data_sel),
		.mem_write_reg_sel(mem_write_reg_sel),
		.mem_write_reg_en(mem_write_reg_en),
		.mem_reg_data_1(mem_reg_data_1),
		.mem_reg_data_2(mem_reg_data_2),
		.mem_instruction(mem_instruction),
		.mem_PC_4(mem_PC_4),
		.mem_HALT(mem_HALT),
		.stall(stall_all),
		
		/* Outputs */ 
		.wb_mem_out(wb_mem_out),
		.wb_alu_out(wb_alu_out),
		.wb_Z(wb_Z),
		.wb_N(wb_N),
		.wb_ofl(wb_ofl),
		.wb_write_data_sel(wb_write_data_sel),
		.wb_write_reg_sel(wb_write_reg_sel),
		.wb_write_reg_en(wb_write_reg_en),
		.wb_reg_data_1(wb_reg_data_1),
		.wb_reg_data_2(wb_reg_data_2),
		.wb_instruction(wb_instruction),
		.wb_PC_4(wb_PC_4),
		.wb_HALT(wb_HALT)
	);
					
	// WriteBack Unit
	writeback WB (
		/* Inputs */
		.alu_out(wb_alu_out),
		.mem_out(wb_mem_out),
		.PC_4(wb_PC_4),
		.write_reg_sel(wb_write_data_sel),
		.flag_opcode(wb_instruction[27:26]),
		.Z(wb_Z),
		.N(wb_N),
		.ofl(wb_ofl),
		.A_Sign(wb_reg_data_1[31]),
		.B_Sign(wb_reg_data_2[31]),

		/*Outputs*/
		.reg_write_data(wb_reg_write_data)
	);
   
   // Hazard Detector
   hazard_detect hd (
		/*Inputs*/ 
		.decodeRegRead1(id_instruction[25:21]),
		.decodeRegRead2(id_instruction[20:16]),
		.executeWriteReg(ex_write_reg_sel),
		.executeWriteRegEn(ex_write_reg_en),
		.memoryWriteReg(mem_write_reg_sel),
		.memoryWriteRegEn(mem_write_reg_en),
		.reg2used(reg2used),
		.mem_stall(1'b0),
		.ex_opcode(ex_instruction[31:26]),
		.id_opcode(id_instruction[31:26]),
		.clk(clk),
		.rst(rst),
		.SPART_STALL_DBG_ONLY(SPART_STALL_DBG_ONLY),
		/*Outputs*/ 
		.stall_id(stall_id),
		.stall_all(stall_all),
		.forward_MEM_EX_A(forward_MEM_EX_A),
		.forward_MEM_EX_B(forward_MEM_EX_B),
		.forward_WB_EX_A(forward_WB_EX_A),
		.forward_WB_EX_B(forward_WB_EX_B)
	);	
	
	// Flush Pipeline Assignments 
	assign flush_if = take_branch;
	assign flush_id = take_branch | stall_id;
	assign flush_ex = take_branch;

endmodule
