`timescale 1ns / 1ps
module top_level_tb();
	reg clk, rst;
	reg rxd;
	reg [1:0] br_cfg;

	wire txd;
	reg [9:0] t_value; 
	reg [15:0] baud_cnt; 
	reg [4:0] data_cnt; 
	reg [8:0] send_cnt;
	reg [7:0] r_value; 
	reg test; 
	reg [7:0] prev_val;
	
	top_level DUT(
	  clk,         // 100mhz clock
	  rst,         // Asynchronous reset, tied to dip switch 0
	  txd,        // RS232 Transmit Data
	  rxd,         // RS232 Recieve Data
	  br_cfg 	// Baud Rate Configuration, Tied to dip switches 2 and 3
	);

	initial forever #5 clk = ~clk;

	initial begin
		clk = 1'b0;
		rst = 1'b1;
		br_cfg = 2'b00;
		rxd = 1'b1;
		
		// #8 rst = 1'b0;
		// repeat(4) @(posedge clk);

		//Test that the correct baud rates are loaded
		// if (DUT.spart0.TXD.BR.baud != 16'h0516) begin
			// $display("FAIL Baud Rate incorrect #1!");
			// $stop;
		// end

		// if (DUT.spart0.RXD.BR.baud != 16'h0516) begin
			// $display("FAIL Baud Rate incorrect #1!");
			// $stop;
		// end
		
		// rst = 1'b1;
		// br_cfg = 2'b01;
		// #8 rst = 1'b0;
		// repeat(4) @(posedge clk);

		// if (DUT.spart0.RXD.BR.baud != 16'h028B) begin
			// $display("FAIL Baud Rate incorrect #2!");
			// $stop;
		// end

		// if (DUT.spart0.TXD.BR.baud != 16'h028B) begin
			// $display("FAIL Baud Rate incorrect #2!");
			// $stop;
		// end
		
		// rst = 1'b1;
		// br_cfg = 2'b10;
		// #8 rst = 1'b0;
		// repeat(4) @(posedge clk);

		// if (DUT.spart0.RXD.BR.baud != 16'h0146) begin
			// $display("FAIL Baud Rate incorrect #3!");
			// $stop;
		// end

		// if (DUT.spart0.TXD.BR.baud != 16'h0146) begin
			// $display("FAIL Baud Rate incorrect #3!");
			// $stop;
		// end
		
		rst = 1'b1;
		br_cfg = 2'b11;
		#8 rst = 1'b0;
		repeat(4) @(posedge clk);

		// if (DUT.spart0.TXD.BR.baud != 16'h00A3) begin
			// $display("FAIL Baud Rate incorrect #4!");
			// $stop;
		// end

		// if (DUT.spart0.RXD.BR.baud != 16'h00A3) begin
			// $display("FAIL Baud Rate incorrect #4!");
			// $stop;
		// end
		
		repeat(4) @(posedge clk);

		for (send_cnt = 8'd0; send_cnt <= 8'hff; send_cnt = send_cnt + 1'd1) begin
			t_value = {1'b1, send_cnt, 1'b0};
			r_value = 0; 
			test = 0;
			for (data_cnt = 5'd0; data_cnt <= 5'd8; data_cnt = data_cnt + 1) begin
				rxd = t_value[0];
				repeat(16'h0A2C) @(posedge clk);
				t_value = {1'b1, t_value[9:1]};
			end
			rxd = 1;
			test = 1;
			while(txd) @(posedge clk);
			test = 0;
			repeat(16'h0A2C / 2) @(posedge clk);
			test = 1;
			for (data_cnt = 5'd0; data_cnt <= 5'd7; data_cnt = data_cnt + 1) begin
				repeat(16'h0A2C) @(posedge clk);
				r_value = {txd, r_value[7:1]};
			end	
			repeat(16'h0A2C) @(posedge clk);
			if (r_value != send_cnt) begin
				$display("FAILED%x\n", r_value);
				$stop;
			end
			$display("%x\n", r_value);
		end
		
		// t_value = 10'b1110000010; 
		 // for (data_cnt = 5'd0; data_cnt <= 5'd9; data_cnt = data_cnt + 1) begin
			 // rxd = t_value[0];
			 // repeat(16'h0A2C) @(posedge clk);
			 // t_value = {1'b1, t_value[9:1]};
		 // end
		
		// repeat(1) @(posedge clk);
		
		// t_value = 10'b1110000010; 
		 // for (data_cnt = 5'd0; data_cnt <= 5'd9; data_cnt = data_cnt + 1) begin
			 // rxd = t_value[0];
			 // repeat(16'h0A2C) @(posedge clk);
			 // t_value = {1'b1, t_value[9:1]};
		 // end
		 
		// while(txd) @(posedge clk);
		// repeat(16'h0A2C / 2) @(posedge clk);
		
		// for (data_cnt = 5'd0; data_cnt <= 5'd7; data_cnt = data_cnt + 1) begin
			// repeat(16'h0A2C) @(posedge clk);
			// t_value = {txd, t_value[8:0]};
		// end

		//$display("%x\n", t_value );
		$display("PASS");
		$stop;
	end
endmodule
