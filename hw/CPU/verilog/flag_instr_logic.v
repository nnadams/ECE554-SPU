module flag_instr_logic(
	input [1:0] opcode,
	input ofl,
	input Z,
	input N,
	input A_Sign,
	input B_Sign,
	output [15:0] Out
);

reg _out;

assign Out = {{14{1'b0}}, _out};

always @(*)
begin
	casex({opcode})
		// SEQ
		2'b00:
		begin
			_out = Z;
		end
		
		// SLT
		2'b01:
		begin
		   _out = (A_Sign & ~B_Sign) | (A_Sign & B_Sign & N) | (~A_Sign & ~B_Sign & N);
		end
		
		// SLE
		2'b10:
		begin
			_out = (A_Sign & ~B_Sign) | (A_Sign & B_Sign & N) | (~A_Sign & ~B_Sign & N) | Z;
		end
		
		// SCO 
		2'b11:
		begin
			_out = ofl;
		end
		
		default:
		begin
			_out = 1'bx;
		end
	endcase
end


endmodule

