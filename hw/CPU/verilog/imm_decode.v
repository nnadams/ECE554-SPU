module imm_decode(
	input [15:0] instr,
	output [15:0] imm_value
);


reg [15:0] _imm_value;

assign imm_value = _imm_value;
 
always @(*) begin
	casex ({instr[15:11]})
		// ADDI 
		5'b01000: 
		begin
			_imm_value = {{11{instr[4]}},instr[4:0]};
		end
		
		// SUBI
		5'b01001:
		begin
			_imm_value = {{11{instr[4]}},instr[4:0]};
		end
		
		// XORI
		5'b01010:
		begin
			_imm_value = {{11{1'b0}},instr[4:0]};
		end
		
		// ANDNI 
		5'b01011:
		begin
			_imm_value = {{11{1'b0}},instr[4:0]};
		end
		
		// ROLI
		5'b10100:
		begin
			_imm_value = {{11{instr[4]}},instr[4:0]};
		end
		
		// SLLI 
		5'b10101:
		begin
			_imm_value = {{11{instr[4]}},instr[4:0]};
		end
		
		// RORI 
		5'b10110:
		begin
			_imm_value = {{11{instr[4]}},instr[4:0]};
		end
		
		// SRLI
		5'b10111:
		begin
			_imm_value = {{11{instr[4]}},instr[4:0]};
		end
		
		// ST
		5'b10000:
		begin
			_imm_value = {{11{instr[4]}},instr[4:0]};
		end
		
		// LD
		5'b10001:
		begin
			_imm_value = {{11{instr[4]}},instr[4:0]};
		end
		
		// STU
		5'b10011:
		begin
			_imm_value = {{11{instr[4]}},instr[4:0]};
		end
		
		// BEQZ
		5'b01100:
		begin
			_imm_value = {{8{instr[7]}},instr[7:0]};
		end
		
		// BNEZ
		5'b01101:
		begin
			_imm_value = {{8{instr[7]}},instr[7:0]};
		end
		
		// BLTZ
		5'b01110:
		begin
			_imm_value = {{8{instr[7]}},instr[7:0]};
		end
	
		// BGEZ
		5'b01111:
		begin
			_imm_value = {{8{instr[7]}},instr[7:0]};
		end
		
		// LBI
		5'b11000:
		begin
			_imm_value = {{8{instr[7]}},instr[7:0]};
		end
		
		// SLBI
		5'b10010:
		begin
			_imm_value = {{8{1'b0}},instr[7:0]};
		end
			
		// J
		5'b00100:
		begin
			_imm_value = {{5{instr[10]}},instr[10:0]};
		end
		
		// JR
		5'b00101:
		begin
			_imm_value = {{8{instr[7]}},instr[7:0]};
		end
		
		// JAL
		5'b00110:
		begin
			_imm_value = {{5{instr[10]}},instr[10:0]};
		end
		
		// JALR
		5'b00111:
		begin
			_imm_value = {{8{instr[7]}},instr[7:0]};
		end
		
		
		// OP code is not relevant to the ALU. Pass through values unchanged and set flags
		// This includes all BEQZ BNEZ BGEZ BLTZ LBI all Jumps HALT
		default:
		begin
			_imm_value = 15'hxxxx;
		end
	endcase
end 

endmodule 
