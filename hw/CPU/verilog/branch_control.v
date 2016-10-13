module branch_control(
	input [15:0] instr,
	input [15:0] reg_read,
	input N, 
	input Z,
	input [15:0] PC_2,
	output [15:0] PC_branch,
	output take_branch
);

reg _take_branch;
reg src1_sel;
reg src2_sel;

wire [15:0] add_src1; 
wire [15:0] add_src2;

wire [15:0] immediate;
wire [15:0] displacement; 

assign immediate = {{8{instr[7]}}, instr[7:0]};
assign displacement = {{5{instr[10]}}, instr[10:0]};

assign add_src1 = (src1_sel == 1'b0) ? PC_2 : reg_read;
assign add_src2 = (src2_sel == 1'b0) ? immediate : displacement;

add16 pc_adder(.A(add_src1), .B(add_src2), .Cin(1'b0), .S(PC_branch), .Cout());


assign take_branch = _take_branch;

always @(*) begin
	casex({instr[15:11]})
		// BEQZ
		5'b01100:
		begin
			src1_sel = 1'b0;
			src2_sel = 1'b0;
			_take_branch = Z;
		end
		
		// BNEZ
		5'b01101:
		begin
			src1_sel = 1'b0;
			src2_sel = 1'b0;
			_take_branch = ~Z;
		end
		
		// BLTZ
		5'b01110:
		begin
			src1_sel = 1'b0;
			src2_sel = 1'b0;
			_take_branch = N;
		end
		
		// BGEZ
		5'b01111:
		begin
			src1_sel = 1'b0;
			src2_sel = 1'b0;
			_take_branch = (~N) | Z;
		end
	
		// J
		5'b00100:
		begin
			src1_sel = 1'b0;
			src2_sel = 1'b1;
			_take_branch = 1'b1;
		end
		
		// JR
		5'b00101:
		begin
			src1_sel = 1'b1;
			src2_sel = 1'b0;
			_take_branch = 1'b1;
		end
		
		// JAL 
		5'b00110:
		begin
			src1_sel = 1'b0;
			src2_sel = 1'b1;
			_take_branch = 1'b1;
		end
		
		// JALR
		5'b00111:
		begin
			src1_sel = 1'b1;
			src2_sel = 1'b0;
			_take_branch = 1'b1;
		end
		
		default:
		begin
			src1_sel = 1'bx;
			src2_sel = 1'bx;
			_take_branch = 1'b0;
		end
	endcase
end


endmodule
