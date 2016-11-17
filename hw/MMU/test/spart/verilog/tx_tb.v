`timescale 1ns / 1ps
module tx_tb();

reg clk, rst; 
reg [7:0] tx_data;
reg IOCS; 
reg IORW;

wire TX, TBR; 

spart_tx DUT( .clk(clk), .rst(rst), .IOCS(IOCS), .IORW(IORW), .tx_data(tx_data), .TBR(TBR), .TX(TX));

initial begin
clk = 0; 
IOCS = 1;
IORW = 1;
rst = 1;
tx_data = 8'h34;

#10 
rst = 0; 
@(posedge clk);
IORW = 0; 
@(posedge clk);
IORW = 1; 
#20 
while (TBR != 1'b1) #5;
#40 
$stop;
end

always #5 clk = ~clk; 

endmodule