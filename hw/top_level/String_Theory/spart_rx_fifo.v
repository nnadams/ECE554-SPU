module spart_rx_fifo(
	input clk, 
	input rst, 
	input rxd,
	input rd_spart,
	output [7:0] rx_data,
	output empty
);
	
	wire rdy; 
	wire [7:0] _spart_rx_data; 
   wire full; 
	
	spart_fifo fifo (
	  .clk(clk),
	  .rst(rst),
	  .din(_spart_rx_data),
	  .wr_en(rdy),
	  .rd_en(rd_spart),
	  .dout(rx_data),
	  .full(full),
	  .empty(empty)
	);
	
	
	spart_rx spart(
		.clk(clk),
		.rst(rst),
		.load_baud(1'b1),
		.baud_val(16'h0516),
		//.baud_val(16'h0010),
		.rx_data(_spart_rx_data),
		.RX(rxd), 
		.rdy(rdy)
	);

endmodule 