module spart_tx_fifo(
	input clk, 
	input rst, 
	input [7:0] tx_data, 
	input write, 
	output full, 
	output txd
);

	wire wr_en; 
	wire [7:0] data; 
	reg rd_en; 
	wire empty; 
	reg trmt;
	wire tbr; 
	reg rst_cnt; 
	reg [31:0] cnt; 
	reg [1:0] state; 
	reg [1:0] next_state; 
	
	assign wr_en = ~full & write; 
	
	always @(posedge clk, posedge rst) begin
		if(rst) state <= 0;
		else state <= next_state; 	
	end 
	
	// Counter so we dont overflow serial 
	always @(posedge clk, posedge rst) begin
		if(rst) cnt <= 0;
		else if(rst_cnt) cnt <= 0;
		else cnt <= cnt + 1;
	end
	
	always @(*) begin
		trmt = 0;
		rd_en = 0; 
		next_state = 2'b00;
		rst_cnt = 0; 
		case(state) 
			2'b00: begin
				if(~empty & tbr) begin
					next_state = 2'b01;
					rst_cnt = 1;
				end 
				else begin
					next_state = 2'b00;
				end
			end
			2'b01: begin 
				if (cnt > 32'd00100000)begin
					next_state = 2'b10;
					rd_en = 1; 
				end
				else begin
					next_state = 2'b01;
				end
			end
			2'b10: begin
				trmt = 1; 
				next_state = 2'b00;
			end
		endcase 	
	end 
	
	spart_fifo fifo (
	  .clk(clk),
	  .rst(rst),
	  .din(tx_data),
	  .wr_en(wr_en),
	  .rd_en(rd_en),
	  .dout(data),
	  .full(full),
	  .empty(empty)
	);

	spart_tx spart(
		.clk(clk),
		.rst(rst),
		.trmt(trmt),
		.tx_data(data),
		.load_baud(1'b1),
		.baud_val(16'h5160),
      //.baud_val(16'h0010),
		.TBR(tbr), 
		.TX(txd)
	);
	
endmodule 