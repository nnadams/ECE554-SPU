`timescale 1ns / 1ps
module cpu_trace_tb();

	reg clk;
	reg rst;
	reg [31:0] instruction;
	reg [31:0] mem_addr;
	reg [31:0] mem_data;
	reg mem_wr;
	
	wire tx;
	wire HALT_CPU;
	
	cpu_trace DUT(
		.clk(clk),
		.rst(rst),
		.instruction(instruction),
		.data_mem_addr(mem_addr),
		.data_mem_write_data(mem_data),
		.data_mem_wr(mem_wr),
		.tx(tx),
		.HALT_CPU(HALT_CPU),
        .CPU_HALTED(1'b0)
	);

	initial begin
		instruction = 32'haaaaaaaa;
		mem_addr = 32'hbbbbbbbb;
		mem_data = 32'hcccccccc;
		mem_wr = 0; 
		
		clk = 0; 
		rst = 1; 
		repeat (25) @(posedge clk);
		rst = 0; 
	
		repeat (100000) @(posedge clk);
		$stop;
	end
	
	
   always #5 clk = ~clk; 


endmodule 
