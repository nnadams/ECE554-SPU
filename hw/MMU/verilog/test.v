`timescale 1ns/1ns

module test();
reg clka, rst, cpu_we;
reg [31:0]  PC, cpu_wdata, cpu_addr;
reg [127:0] spu_wdata;
reg [31:0]  spu_addr, spu_res_data;
reg [3:0] spu_res_addr;
reg [7:0] spart_rx_data;
reg spart_tx_full, spart_rx_empty;

wire [31:0]  cpu_read_data;
wire [31:0]  instruction;
wire [127:0] spu_read_data;
wire [31:0]  vga_data_1;
wire [31:0]  vga_data_2;
wire [31:0]  vga_data_3;
wire [7:0]   spart_tx_data;


mmu_hier iDUT( 
    .clk(clka),
    .rst(rst),
    .PC(PC),
    .cpu_wdata(cpu_wdata),
    .cpu_addr(cpu_addr),
    .cpu_we(cpu_we),
    .spu_wdata(spu_wdata),
    .spu_addr(spu_addr),
    .spu_res_addr(spu_res_addr),
    .spu_res_data(spu_res_data),
    .spart_tx_full(spart_tx_full),
    .spart_rx_empty(spart_rx_empty),
    .spart_rx_data(spart_rx_data),
                   
    .cpu_read_data(cpu_read_data),
    .instruction(instruction),
    .spu_read_data(spu_read_data),
    .vga_data_1(vga_data_1),
    .vga_data_2(vga_data_2),
    .vga_data_3(vga_data_3),
    .spart_tx_data(spart_tx_data)
);
initial begin 
	clka =1'b0;
	forever #10 clka=~clka;
end

initial begin
    #0   PC=0;
    rst = 1'b1;
    #10 rst = 1'b0;
    repeat (16) begin
        @(posedge clka)
        PC = PC + 4;
    end
    $finish;
end

initial begin
    $monitor ("@%d,PC=%d,instruction=%x",$time,PC,instruction);
end
endmodule
