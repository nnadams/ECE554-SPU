module alucontrol(
	input [5:0] opcode,
	input [2:0] aluop,
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
		9'b001000_xxx: 
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// SUBI
		9'b001001_xxx:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b1;
			_Cin    = 1'b1; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// XORI
		9'b001010_xxx:
		begin
			_Op     = `OPCODE_XOR;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// ANDNI 
		9'b001011_xxx:
		begin
			_Op     = `OPCODE_AND;
			_invA   = 1'b0; 
			_invB   = 1'b1;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// ROLI
		9'b010100_xxx:
		begin
			_Op     = `OPCODE_ROT_L;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// SLLI 
		9'b010101_xxx:
		begin
			_Op     = `OPCODE_SHFT_L;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// RORI 
		9'b010110_xxx:
		begin
			_Op     = `OPCODE_ROT_R;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// SRLI
		9'b010111_xxx:
		begin
			_Op     = `OPCODE_SHFT_R;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// ADD
		9'b011011_000:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// SUB
		9'b011011_001:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b1; 
			_invB   = 1'b0;
			_Cin    = 1'b1; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// XOR 
		9'b011011_010:
		begin
			_Op     = `OPCODE_XOR;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// ANDN
		9'b011011_011:
		begin
			_Op     = `OPCODE_AND;
			_invA   = 1'b0; 
			_invB   = 1'b1;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
        // OR
		9'b011011_100:
		begin
			_Op     = `OPCODE_OR;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b0;
			_alusrc = `ALU_SRC_REG;
		end
        
		// ROL 
		9'b011010_000:
		begin
			_Op     = `OPCODE_ROT_L;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// SLL
		9'b011010_001:
		begin
			_Op     = `OPCODE_SHFT_L;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// ROR
		9'b011010_010:
		begin
			_Op     = `OPCODE_ROT_R;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// SRL
		9'b011010_011:
		begin
			_Op     = `OPCODE_SHFT_R;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// BTR
		9'b011001_xxx:
		begin
			_Op     = `OPCODE_BTR;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// SEQ
		9'b011100_xxx:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b1;
			_Cin    = 1'b1; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// SLT 
		9'b011101_xxx:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b1;
			_Cin    = 1'b1; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// SLE
		9'b011110_xxx:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b1;
			_Cin    = 1'b1; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// SCO
		9'b011111_xxx:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b0;
			_alusrc = `ALU_SRC_REG;
		end

		// LBI
		9'b011000_xxx:
		begin
			_Op     = `OPCODE_LBI;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// SLBI
		9'b010010_xxx:
		begin
			_Op     = `OPCODE_SLBI;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// ST
		9'b010000_xxx:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b0;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// LD
		9'b010001_xxx:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b0;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// LB
		9'b110000_xxx:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b0;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// SB
		9'b111000_xxx:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b0;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// STU
		9'b010011_xxx:
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
