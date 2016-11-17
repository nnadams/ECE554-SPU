module writebackcontrol(
	input [31:0] instr,
	output [4:0] reg_write,
	output write_reg,
	output [1:0] write_reg_sel
);

`define WRITE_REG_ALU    2'b00
`define WRITE_REG_MEM    2'b01
`define WRITE_REG_PC     2'b10
`define WRITE_REG_FLAGS  2'b11

reg [4:0] _reg_write; 
reg _write_reg;
reg [1:0] _write_reg_sel;

assign reg_write = _reg_write;
assign write_reg = _write_reg;
assign write_reg_sel = _write_reg_sel;

always @(*) begin
	casex ({instr[31:26]}) 
		// ADDI 
		6'b001000: 
		begin
			_reg_write = instr[20:16]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// SUBI
		6'b001001:
		begin
			_reg_write = instr[20:16]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// XORI
		6'b001010:
		begin
			_reg_write = instr[20:16]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// ANDNI 
		6'b001011:
		begin
			_reg_write = instr[20:16]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// ROLI
		6'b010100:
		begin
			_reg_write = instr[20:16]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// SLLI 
		6'b010101:
		begin
			_reg_write = instr[20:16]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// RORI 
		6'b010110:
		begin
			_reg_write = instr[20:16]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// SRLI
		6'b010111:
		begin
			_reg_write = instr[20:16]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// ADD
		6'b011011:
		begin
			_reg_write = instr[15:11]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// SUB
		6'b011011:
		begin
			_reg_write = instr[15:11]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// XOR 
		6'b011011:
		begin
			_reg_write = instr[15:11]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// ANDN
		6'b011011:
		begin
			_reg_write = instr[15:11]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// ROL 
		6'b011010:
		begin
			_reg_write = instr[15:11]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// SLL
		6'b011010:
		begin
			_reg_write = instr[15:11]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// ROR
		6'b011010:
		begin
			_reg_write = instr[15:11]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// SRL
		6'b011010:
		begin
			_reg_write = instr[15:11]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// BTR
		6'b011001:
		begin
			_reg_write = instr[15:11]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// SEQ
		6'b011100:
		begin
			_reg_write = instr[15:11]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_FLAGS;
		end
		
		// SLT 
		6'b011101:
		begin
			_reg_write = instr[15:11]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_FLAGS;
		end
		
		// SLE
		6'b011110:
		begin
			_reg_write = instr[15:11]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_FLAGS;
		end
		
		// SCO
		6'b011111:
		begin
			_reg_write = instr[15:11]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_FLAGS;
		end

		// LBI
		6'b011000:
		begin
			_reg_write = instr[25:21]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// SLBI
		6'b010010:
		begin
			_reg_write = instr[25:21]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
		
		// LD
		6'b010001:
		begin
			_reg_write = instr[20:16]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_MEM;
		end
		
		// STU
		6'b010011:
		begin
			_reg_write = instr[25:21]; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_ALU;
		end
			
		// JAL 
		6'b000110:
		begin
			_reg_write = 5'b11111; 
			_write_reg = 1'b1;
			_write_reg_sel = `WRITE_REG_PC;
		end
		
		// JALR
		6'b000111:
		begin
			_reg_write = 5'b11111; 
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
