module instr_fetch (
	input clk, 
	input rst, 
	input [31:0] PC_branch,
	input take_branch,
	output [31:0] instr,
	output [31:0] PC_4,
	output HALT
);

wire [31:0] PC_curr; 
wire [31:0] PC_new; 
wire _continue;

// HALT instruction
assign _continue = (instr[31:26] == 6'b000000) ? 1'b0 : 1'b1;
assign HALT = ~_continue;

assign PC_new = take_branch ? PC_branch : PC_4; 

reg_32 pc_reg(
			.clk(clk), 
			.rst(rst), 
			.writeData(PC_new), 
			.write(_continue),
			.data(PC_curr)
		);

add32 pc_incr(
			.A(PC_curr),
			.B(32'h4), 
			.Cin(1'b0), 
			.S(PC_4), 
			.Cout()
		);

// TODO Get right memory for FPGA 
wire dump_mem; 
assign dump_mem = 1'b0;
assign mem_enable = 1'b1;
   
memory2c i_mem(
			.data_out(instr), 
			.data_in(32'h0000), 
			.addr(PC_curr),
			.enable(mem_enable), 
			.wr(1'b0),
			.createdump(dump_mem), 
			.clk(clk), 
			.rst(rst)
		);
				
endmodule
