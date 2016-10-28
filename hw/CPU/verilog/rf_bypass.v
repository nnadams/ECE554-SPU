module rf_bypass (
   // Outputs
   output [31:0] read1data,
   output [31:0] read2data, 
   // Inputs
   input clk, 
   input rst, 
   input [4:0] read1regsel, 
   input [4:0] read2regsel,
   input [4:0] writeregsel,
   input [31:0] writedata,
   input write
);

	wire [31:0] _read1data;
	wire [31:0] _read2data; 

	rf regfile (
		.clk(clk),
		.rst(rst),
		.read1data(_read1data),
		.read2data(_read2data),
		.read1regsel(read1regsel), 
		.read2regsel(read2regsel), 
		.writeregsel(writeregsel), 
		.writedata(writedata),
		.write(write)
	);

	assign read1data = ({read1regsel,write} == {writeregsel, 1'b1})	? writedata : _read1data; 
	assign read2data = ({read2regsel,write} == {writeregsel, 1'b1})	? writedata : _read2data;	

endmodule
