`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:   ECE 554
// Engineer:  Nicolas Adams and Jonathan Brand
// 
// Create Date:   
// Design Name: 
// Module Name:    spart 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module spart(
    input clk,
    input rst,
    input iocs,
    input iorw,
    output rda, // Data Ready
    output tbr, // Transmit Ready
    input [1:0] ioaddr,
    inout [7:0] databus,
    output txd,
    input rxd
    );

wire [7:0] rx_data;
wire [7:0] datain; 
wire trmt; 
reg load_baud;
reg [15:0] baud_reg; 

// Signal to start transmitting
assign trmt = iocs & ~iorw; 

busintrf BUS(
	.iocs(iocs),
	.iorw(iorw),
	.rda(rda),
	.tbr(tbr),
	.ioaddr(ioaddr),
	.dataout(rx_data),
	.datain(datain),
	.databus(databus)
);

spart_tx TXD(
	.clk(clk), 
	.rst(rst), 
	.trmt(trmt),
	.tx_data(datain),
	.load_baud(load_baud),
	.baud_val(baud_reg),
	.TBR(tbr), 
	.TX(txd)
);

spart_rx RXD(
	.clk(clk), 
	.rst(rst),  
	.RX(rxd), 
	.load_baud(load_baud),
	.baud_val(baud_reg),
	.rx_data(rx_data),
	.rdy(rda)
);

// Baud reg that is received from the processor. 
// Since the baud is sent in two chunks, we need to 
// flop the data to save each chunk. We assume that once the 
// lower byte of the baud is received that we should load it in.
always @(posedge clk or posedge rst) begin
	if (rst) 
	begin
		baud_reg <= 16'h5555;
		load_baud <= 0;
	end
	else if (ioaddr == 2'b10)
	begin
		baud_reg <= {baud_reg[15:8], datain};
		load_baud <= 0;
	end
	else if (ioaddr == 2'b11)
	begin
		baud_reg <= {datain, baud_reg[7:0]};
		load_baud <= 1;
	end
	else
	begin
		baud_reg <= 16'h0000;
		load_baud <= 0;
	end
end
		
endmodule
