`timescale 1ns / 1ps
module driver_bus_baud_tb();
	reg clk, rst;
	reg rda, tbr;
	reg [1:0] br_cfg;
	reg [7:0] dataout;

	wire iocs, iorw;
	wire [1:0] ioaddr;
	wire [7:0] datain;

	wire [7:0] databus;

	reg [8:0] t_value;

	driver drvrDUT(
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

	busintrf bsDUT(
		iocs,
		iorw,
		rda,
		tbr,
		ioaddr,
		dataout,
		datain,
		databus
	);

	baudgen bdDUT(
	  clk,
	  rst,
	  ioaddr,
	  datain, // i_divisor,
	  enable
	);

	initial forever #5 clk = ~clk;

	initial begin
		t_value = 8'h00;
		clk = 1'b0;
		rst = 1'b1;
		br_cfg = 2'b00;
		rda = 1'b0;
		tbr = 1'b0;
		#8 rst = 1'b0;
		repeat(5) @(posedge clk);

		for (t_value = 8'd0; t_value <= 8'hFF; t_value = t_value + 1'd1) begin
			@(posedge clk);
			rda = 1'b1;
			dataout = t_value;

			@(posedge clk);
			rda = 1'b0;
			tbr = 1'b1;
			@(posedge clk);
			tbr = 1'b0;
			if (datain != t_value) begin
				$display("FAIL on %d", t_value);
				$stop;
			end
		end

		@(posedge clk);
		$display("PASS");
		$stop;
	end
endmodule
