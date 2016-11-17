`timescale 1ns / 1ps
module driver_tb();
	reg clk, rst;
	reg rda, tbr;
	reg [1:0] br_cfg;

	wire iocs, iorw;
	wire [1:0] ioaddr;

	wire [7:0] databus;
	wire [7:0] databus_in;
	reg [7:0] databus_out;
	reg databus_en;

	assign databus_in = databus;
	assign databus = (databus_en) ? databus_out : 8'hZZ;

	reg [8:0] t_value;

	driver DUT(
	  clk,
	  rst,
	  br_cfg,
	  iocs,
	  iorw,
	  rda,
	  tbr,
	  ioaddr,
	  databus
	);

	initial forever #5 clk = ~clk;

	initial begin
		clk = 1'b0;
		rst = 1'b1;
		databus_en = 1'b0;
		databus_out = 8'hZZ;
		br_cfg = 2'b00;
		rda = 1'b0;
		tbr = 1'b0;
		#8 rst = 1'b0;
		repeat(5) @(posedge clk);

		for (t_value = 8'd0; t_value <= 8'hFF; t_value = t_value + 1'd1) begin
			@(posedge clk);
			rda = 1'b1;
			databus_out = t_value;
			databus_en  = 1'b1;

			@(posedge clk);
			databus_out = 8'hZZ;
			databus_en  = 1'b0;
			rda = 1'b0;
			tbr = 1'b1;
			@(posedge clk);
			tbr = 1'b0;
			if (databus_in != t_value) begin
				$display("FAIL on %d", t_value);
				$stop;
			end
		end

		@(posedge clk);
		$display("PASS");
		$stop;
	end
endmodule
