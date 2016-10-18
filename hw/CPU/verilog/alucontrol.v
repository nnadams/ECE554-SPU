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
		7'b01000_xx: 
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// SUBI
		7'b01001_xx:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b1; 
			_invB   = 1'b0;
			_Cin    = 1'b1; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// XORI
		7'b01010_xx:
		begin
			_Op     = `OPCODE_XOR;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// ANDNI 
		7'b01011_xx:
		begin
			_Op     = `OPCODE_AND;
			_invA   = 1'b0; 
			_invB   = 1'b1;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// ROLI
		7'b10100_xx:
		begin
			_Op     = `OPCODE_ROT_L;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// SLLI 
		7'b10101_xx:
		begin
			_Op     = `OPCODE_SHFT_L;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// RORI 
		7'b10110_xx:
		begin
			_Op     = `OPCODE_ROT_R;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// SRLI
		7'b10111_xx:
		begin
			_Op     = `OPCODE_SHFT_R;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// ADD
		7'b11011_00:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// SUB
		7'b11011_01:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b1; 
			_invB   = 1'b0;
			_Cin    = 1'b1; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// XOR 
		7'b11011_10:
		begin
			_Op     = `OPCODE_XOR;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// ANDN
		7'b11011_11:
		begin
			_Op     = `OPCODE_AND;
			_invA   = 1'b0; 
			_invB   = 1'b1;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// ROL 
		7'b11010_00:
		begin
			_Op     = `OPCODE_ROT_L;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// SLL
		7'b11010_01:
		begin
			_Op     = `OPCODE_SHFT_L;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// ROR
		7'b11010_10:
		begin
			_Op     = `OPCODE_ROT_R;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// SRL
		7'b11010_11:
		begin
			_Op     = `OPCODE_SHFT_R;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// BTR
		7'b11001_xx:
		begin
			_Op     = `OPCODE_BTR;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// SEQ
		7'b11100_xx:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b1;
			_Cin    = 1'b1; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// SLT 
		7'b11101_xx:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b1;
			_Cin    = 1'b1; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// SLE
		7'b11110_xx:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b1;
			_Cin    = 1'b1; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_REG;
		end
		
		// SCO
		7'b11111_xx:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b0;
			_alusrc = `ALU_SRC_REG;
		end

		// LBI
		7'b11000_xx:
		begin
			_Op     = `OPCODE_LBI;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// SLBI
		7'b10010_xx:
		begin
			_Op     = `OPCODE_SLBI;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b1;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// ST
		7'b10000_xx:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b0;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// LD
		7'b10001_xx:
		begin
			_Op     = `OPCODE_ADD;
			_invA   = 1'b0; 
			_invB   = 1'b0;
			_Cin    = 1'b0; 
			_sign   = 1'b0;
			_alusrc = `ALU_SRC_IMM;
		end
		
		// STU
		7'b10011_xx:
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
