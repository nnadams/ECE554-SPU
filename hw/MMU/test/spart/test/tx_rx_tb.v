`timescale 1ns / 1ps
module tx_rx_tb();

reg clk, rst, clr_rdy;
reg trmt;
reg [7:0] tx_data; 
wire [7:0] cmd_out;
wire TBR;
wire tx;
wire rdy;

spart_rx RX_DUT(
	.clk(clk), 
	.rst(rst),
	.RX(tx), 
	.clr_rdy(clr_rdy),
	.rx_data(cmd_out), 
	.rdy(rdy)
);

spart_tx TX_DUT(
	.clk(clk),
	.rst(rst),
	.trmt(trmt),
	.tx_data(tx_data),
	.TBR(TBR),
	.TX(tx)
);

initial begin
clk = 0; 
rst = 1;
tx_data = 8'haa;
trmt = 0;
clr_rdy = 0; 
#10
rst = 0;
#20
trmt = 1;

while (rdy != 1'b1) #5;
#50
$stop;
end

always #5 clk = ~clk; 

endmodule