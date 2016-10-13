module writebackcontrol(
	input [15:0] instr,
	output [2:0] reg_write,
	output write_reg,
	output [1:0] write_reg_sel
);

`define WRITE_REG_ALU    2'b00
`define WRITE_REG_MEM    2'b01
`define WRITE_REG_PC     2'b10
`define WRITE_REG_FLAGS  2'b11

reg [2:0] _reg_write; 
reg _write_reg;
reg [1:0] _write_reg_sel;

assign reg_write = _reg_write;
assign write_reg = _write_reg;
assign write_reg_sel = _write_reg_sel;

always @(*) begin
	casex ({instr[15:11]}) 
		// ADDI 
		5'b01000: 
		begin
			_reg_write = instr[7:5]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// SUBI
		5'b01001:
		begin
			_reg_write = instr[7:5]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// XORI
		5'b01010:
		begin
			_reg_write = instr[7:5]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// ANDNI 
		5'b01011:
		begin
			_reg_write = instr[7:5]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// ROLI
		5'b10100:
		begin
			_reg_write = instr[7:5]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// SLLI 
		5'b10101:
		begin
			_reg_write = instr[7:5]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// RORI 
		5'b10110:
		begin
			_reg_write = instr[7:5]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// SRLI
		5'b10111:
		begin
			_reg_write = instr[7:5]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// ADD
		5'b11011:
		begin
			_reg_write = instr[4:2]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// SUB
		5'b11011:
		begin
			_reg_write = instr[4:2]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// XOR 
		5'b11011:
		begin
			_reg_write = instr[4:2]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// ANDN
		5'b11011:
		begin
			_reg_write = instr[4:2]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// ROL 
		5'b11010:
		begin
			_reg_write = instr[4:2]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// SLL
		5'b11010:
		begin
			_reg_write = instr[4:2]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// ROR
		5'b11010:
		begin
			_reg_write = instr[4:2]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// SRL
		5'b11010:
		begin
			_reg_write = instr[4:2]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// BTR
		5'b11001:
		begin
			_reg_write = instr[4:2]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// SEQ
		5'b11100:
		begin
			_reg_write = instr[4:2]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_FLAGS;
		end
		
		// SLT 
		5'b11101:
		begin
			_reg_write = instr[4:2]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_FLAGS;
		end
		
		// SLE
		5'b11110:
		begin
			_reg_write = instr[4:2]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_FLAGS;
		end
		
		// SCO
		5'b11111:
		begin
			_reg_write = instr[4:2]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_FLAGS;
		end

		// LBI
		5'b11000:
		begin
			_reg_write = instr[10:8]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// SLBI
		5'b10010:
		begin
			_reg_write = instr[10:8]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// LD
		5'b10001:
		begin
			_reg_write = instr[7:5]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_MEM;
		end
		
		// STU
		5'b10011:
		begin
			_reg_write = instr[10:8]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
			
		// JAL 
		5'b00110:
		begin
			_reg_write = 3'b111; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_PC;
		end
		
		// JALR
		5'b00111:
		begin
			_reg_write = 3'b111; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_PC;
		end

		// OP code is not relevant to the ALU. Pass through values unchanged and set flags
		// This includes all BEQZ BNEZ BGEZ BLTZ LBI all Jumps HALT
		default:
			begin
			_reg_write = 4'bxxxx; 
			_write_reg = 1'b0;
			_write_reg_sel = 2'bxx;
		end
	endcase
end 



endmodule 
