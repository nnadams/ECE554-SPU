module memory(
	      input [31:0] data_in,
	      input [31:0] addr,
	      input enable,
	      input wr,
	      input createdump,
	      input clk,
	      input rst,

	      output [31:0] data_out
	      );

memory2c data_mem(
		.data_out(data_out),
		.data_in(data_in), 
		.addr(addr),
		.enable(enable),
		.wr(wr), 
		.createdump(createdump), 
		.clk(clk), 
		.rst(rst)
);

endmodule 
