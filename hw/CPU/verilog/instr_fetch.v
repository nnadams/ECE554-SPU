module instr_fetch (
	input clk, 
	input rst, 
	input [15:0] PC_branch,
	input take_branch,
	input HALT_NOW,
	input stall,
	output [15:0] instr,
	output [15:0] PC_2,
	output HALT
);


wire [15:0] PC_curr; 
wire [15:0] PC_new; 
wire _continue;

// HALT instruction
assign _continue = (instr[15:11] == 5'b00000) ? 1'b0 : 1'b1;
assign HALT = ~_continue;

// Stall -> fetch same instruction, Branch, or normal increment
assign PC_new = stall       ? PC_curr   :
				take_branch ? PC_branch : PC_2; 

reg_16 pc_reg(.clk(clk), .rst(rst), .writeData(PC_new), .write(HALT_NOW), .data(PC_curr));


add16 pc_incr(.A(PC_curr), .B(16'h0002), .Cin(1'b0), .S(PC_2), .Cout());


// Dump mem on halt instr -- Dont need for i memory
wire dump_mem; 
assign dump_mem = 1'b0;//~_continue;
assign mem_enable = 1'b1;
   
memory2c i_mem (.data_out(instr), .data_in(16'h0000), .addr(PC_curr), .enable(mem_enable), .wr(1'b0),
				.createdump(dump_mem), .clk(clk), .rst(rst));
				
endmodule
