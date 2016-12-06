module alucontrol(
	input [5:0] opcode,
	input [1:0] aluop,
	output [3:0] Op,
	output invA,
	output invB,
	output Cin,
	output sign,
	output alusrc
);

`define OPCODE_ROT_L		 4'b0000
`define OPCODE_SHFT_L		 4'b0001
`define OPCODE_ROT_R    	 4'b0010
`define OPCODE_SHFT_R    	 4'b0011
`define OPCODE_ADD  		 4'b0100
`define OPCODE_OR   		 4'b0101
`define OPCODE_XOR  		 4'b0110
`define OPCODE_AND  		 4'b0111
`define OPCODE_BTR           4'b1000
`define OPCODE_LBI           4'b1001
`define OPCODE_SLBI          4'b1010 
`define OPCODE_NOP           4'b1111

`define ALU_SRC_REG          1'b0
`define ALU_SRC_IMM          1'b1

reg [3:0] _Op; 
reg _invA;
reg _invB;
reg _Cin;
reg _sign;
reg _alusrc;

assign Op = _Op;
assign invA = _invA;
assign invB = _invB;
assign sign = _sign;
assign alusrc = _alusrc;
assign Cin = _Cin;
   
always @(*) begin
	casex ({opcode,aluop})
		// ADDI 
		8'b001000_xx: 
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// SUBI
		8'b001001_xx:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b1; 
			_invB   = 1'b0;
			_Cin    = 1'b1; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// XORI
		8'b001010_xx:
		begin
			_Op     = `OPCODE_XOR;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// ANDNI 
		8'b001011_xx:
		begin
			_Op     = `OPCODE_AND;
			_invA   = 1'b0; 
			_invB   = 1'b1;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// ROLI
		8'b010100_xx:
		begin
			_Op     = `OPCODE_ROT_L;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// SLLI 
		8'b010101_xx:
		begin
			_Op     = `OPCODE_SHFT_L;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// RORI 
		8'b010110_xx:
		begin
			_Op     = `OPCODE_ROT_R;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// SRLI
		8'b010111_xx:
		begin
			_Op     = `OPCODE_SHFT_R;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// ADD
		8'b011011_00:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// SUB
		8'b011011_01:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b1; 
			_invB   = 1'b0;
			_Cin    = 1'b1; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// XOR 
		8'b011011_10:
		begin
			_Op     = `OPCODE_XOR;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// ANDN
		8'b011011_11:
		begin
			_Op     = `OPCODE_AND;
			_invA   = 1'b0; 
			_invB   = 1'b1;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// ROL 
		8'b011010_00:
		begin
			_Op     = `OPCODE_ROT_L;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// SLL
		8'b011010_01:
		begin
			_Op     = `OPCODE_SHFT_L;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// ROR
		8'b011010_10:
		begin
			_Op     = `OPCODE_ROT_R;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// SRL
		8'b011010_11:
		begin
			_Op     = `OPCODE_SHFT_R;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// BTR
		8'b011001_xx:
		begin
			_Op     = `OPCODE_BTR;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// SEQ
		8'b011100_xx:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b1;
			_Cin    = 1'b1; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// SLT 
		8'b011101_xx:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b1;
			_Cin    = 1'b1; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// SLE
		8'b011110_xx:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b1;
			_Cin    = 1'b1; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// SCO
		8'b011111_xx:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b0;
			_alusrc = `ALU_SRC_REG;
		end

		// LBI
		8'b011000_xx:
		begin
			_Op     = `OPCODE_LBI;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// SLBI
		8'b010010_xx:
		begin
			_Op     = `OPCODE_SLBI;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// ST
		8'b010000_xx:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b0;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// LD
		8'b010001_xx:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b0;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// LB
		8'b110000_xx:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b0;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// SB
		8'b111000_xx:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b0;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// STU
		8'b010011_xx:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b0;
			_alusrc = `ALU_SRC_IMM;
		end
			
		// _Op code is not relevant to the ALU. Pass through values unchanged and set flags
		// This includes all BEQZ BNEZ BGEZ BLTZ LBI all Jumps HALT
		default:
			begin
			_Op     = `OPCODE_NOP;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
	endcase
end 

endmodule
