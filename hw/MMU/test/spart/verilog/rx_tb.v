`timescale 1ns / 1ps
module rx_tb();

reg clk, rst, rx, clr_rdy;

wire [7:0] cmd_out;

wire rdy;

spart_rx DUT(
	.clk(clk), 
	.rst(rst),
	.RX(rx), 
	.clr_rdy(clr_rdy),
	.rx_data(cmd_out), 
	.rdy(rdy)
);

initial begin
clk = 0; 
rst = 1;
rx = 1;
clr_rdy = 0; 
#10
rst = 0;
#20
rx = 0;

while (rdy != 1'b1) #430 rx = ~rx;
#50
$stop;
end

always #5 clk = ~clk; 

endmodule