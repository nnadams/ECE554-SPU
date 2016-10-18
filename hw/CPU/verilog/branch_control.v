module branch_control(
	input [31:0] instr,
	input [31:0] reg_read,
	input N, 
	input Z,
	input [31:0] PC_4,
	input [31:0] immediate,
	output [31:0] PC_branch,
	output take_branch
);

reg _take_branch;
reg src1_sel;

wire [31:0] add_src1; 
wire [31:0] add_src2;

assign add_src1 = (src1_sel == 1'b0) ? PC_4 : reg_read;

add16 pc_adder(
			.A(add_src1), 
			.B(immediate),
			.Cin(1'b0), 
			.S(PC_branch), 
			.Cout()
		);

assign take_branch = _take_branch;

always @(*) begin
	casex({instr[31:26]})
		// BEQZ
		6'b001100:
		begin
			src1_sel = 1'b0;
			_take_branch = Z;
		end
		
		// BNEZ
		6'b001101:
		begin
			src1_sel = 1'b0;
			_take_branch = ~Z;
		end
		
		// BLTZ
		6'b001110:
		begin
			src1_sel = 1'b0;
			_take_branch = N;
		end
		
		// BGEZ
		6'b001111:
		begin
			src1_sel = 1'b0;
			_take_branch = (~N) | Z;
		end
	
		// J
		6'b000100:
		begin
			src1_sel = 1'b0;
			_take_branch = 1'b1;
		end
		
		// JR
		6'b000101:
		begin
			src1_sel = 1'b1;
			_take_branch = 1'b1;
		end
		
		// JAL 
		6'b000110:
		begin
			src1_sel = 1'b0;
			_take_branch = 1'b1;
		end
		
		// JALR
		6'b000111:
		begin
			src1_sel = 1'b1;
			_take_branch = 1'b1;
		end
		
		default:
		begin
			src1_sel = 1'bx;
			_take_branch = 1'b0;
		end
	endcase
end

endmodule
