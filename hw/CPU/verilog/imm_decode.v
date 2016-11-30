module imm_decode(
	input [31:0] instr,
	output [31:0] imm_value
);

reg [31:0] _imm_value;

assign imm_value = _imm_value;
 
always @(*) begin
	casex ({instr[31:26]})
		// ADDI 
		6'b001000: 
		begin
			_imm_value = {{16{instr[15]}},instr[15:0]};
		end
		
		// SUBI
		6'b001001:
		begin
			_imm_value = {{15{instr[15]}},instr[15:0]};
		end
		
		// XORI
		6'b001010:
		begin
			_imm_value = {{15{1'b0}},instr[15:0]};
		end
		
		// ANDNI 
		6'b001011:
		begin
			_imm_value = {{15{1'b0}},instr[15:0]};
		end
		
		// ROLI
		6'b010100:
		begin
			_imm_value = {{15{instr[15]}},instr[15:0]};
		end
		
		// SLLI 
		6'b010101:
		begin
			_imm_value = {{15{instr[15]}},instr[15:0]};
		end
		
		// RORI 
		6'b010110:
		begin
			_imm_value = {{15{instr[15]}},instr[15:0]};
		end
		
		// SRLI
		6'b010111:
		begin
			_imm_value = {{15{instr[15]}},instr[15:0]};
		end
		
		// ST
		6'b010000:
		begin
			_imm_value = {{15{instr[15]}},instr[15:0]};
		end
		
		// LD
		6'b010001:
		begin
			_imm_value = {{15{instr[15]}},instr[15:0]};
		end
			
		// SB
		6'b110000:
		begin
			_imm_value = {{15{instr[15]}},instr[15:0]};
		end
		
		// LB
		6'b111000:
		begin
			_imm_value = {{15{instr[15]}},instr[15:0]};
		end
		
		// STU
		6'b010011:
		begin
			_imm_value = {{15{instr[15]}},instr[15:0]};
		end
		
		// BEQZ
		6'b001100:
		begin
			_imm_value = {{15{instr[15]}},instr[15:0]};
		end
		
		// BNEZ
		6'b001101:
		begin
			_imm_value = {{15{instr[15]}},instr[15:0]};
		end
		
		// BLTZ
		6'b001110:
		begin
			_imm_value = {{15{instr[15]}},instr[15:0]};
		end
	
		// BGEZ
		6'b001111:
		begin
			_imm_value = {{15{instr[15]}},instr[15:0]};
		end
		
		// LBI
		6'b011000:
		begin
			_imm_value = {{15{instr[15]}},instr[15:0]};
		end
		
		// SLBI
		6'b010010:
		begin
			_imm_value = {{15{1'b0}},instr[15:0]};
		end
			
		// J
		6'b000100:
		begin
			_imm_value = {{6{instr[25]}},instr[25:0]};
		end
		
		// JR
		6'b000101:
		begin
			_imm_value = {{15{instr[15]}},instr[15:0]};
		end
		
		// JAL
		6'b000110:
		begin
			_imm_value = {{6{instr[25]}},instr[10:0]};
		end
		
		// JALR
		6'b000111:
		begin
			_imm_value = {{15{instr[15]}},instr[15:0]};
		end
		
		
		// OP code is not relevant to the ALU. Pass through values unchanged and set flags
		// This includes all BEQZ BNEZ BGEZ BLTZ LBI all Jumps HALT
		default:
		begin
			_imm_value = 32'hxxxx;
		end
	endcase
end 

endmodule 
