`timescale 1ns/1ns

module test();
reg clk, rst;
reg [31:0]  spu_addr;
wire [127:0] spu_read_data;


mmu_hier iDUT( 
    .clk(clk),
    .rst(rst),
    .PC(PC),
    .cpu_wdata(32'd0),
    .cpu_addr(32'd0),
    .cpu_we(4'b0000),
	 .cpu_en(4'b0000),
    .spu_wdata(128'd0),
    .spu_addr(spu_addr),
    .spu_res_addr(4'h0),
    .spu_res_data(32'h00000000),
    .spart_tx_full(1'b0),
    .spart_rx_empty(1'b1),
    .spart_rx_data(8'h00),
    .spu_res_wr_en(1'b0),               
    .cpu_read_data(),
    .instruction(),
    .spu_read_data(spu_read_data),
    .vga_data_1(),
    .vga_data_2(),
    .vga_data_3(),
    .spart_tx_data(),
	 .spart_rd(),
	 .spart_trmt()
);

initial begin
    clk = 0;
	 rst = 1; 
	 spu_addr = 32'd0;
	 repeat(5) @(posedge clk);
	 rst = 0; 
	 repeat(5) @(posedge clk);
	 spu_addr = 32'h04;
	 repeat(5) @(posedge clk);
	 spu_addr = 32'h20;
	 repeat(5) @(posedge clk);
	 spu_addr = 32'h40;
	 repeat(5) @(posedge clk);
    $stop;
end

always #5 clk = ~clk; 
endmodule
