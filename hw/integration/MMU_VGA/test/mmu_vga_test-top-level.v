`timescale 1ns/1ps

module test(
    output hsync,
    output vsync,
    output blank,
    output dvi_rst,
    output [7:0] pixel_r,
    output [7:0] pixel_g,
    output [7:0] pixel_b,
    output [11:0] D,
    output clk,
    output clk_n,
    inout scl_tri, sda_tri
);
reg clka, rst, cpu_we;
reg [3:0] cpu_en;
reg [31:0]  PC, cpu_wdata, cpu_addr;
reg [127:0] spu_wdata;
reg [31:0]  spu_addr, spu_res_data;
reg [3:0] spu_res_addr;
reg [7:0] spart_rx_data;
reg spart_tx_full, spart_rx_empty;

wire [63:0]  clk_cnt;
wire [31:0]  cpu_read_data;
wire [31:0]  instruction;
wire [127:0] spu_read_data;
wire [31:0]  vga_data_1;
wire [31:0]  vga_data_2;
wire [31:0]  vga_data_3;
wire [7:0]   spart_tx_data;


vga_clk vga_clk_gen1(
    .CLKIN_IN(clka), 
     .RST_IN(rst), 
     .CLKDV_OUT(clk_25mhz), 
     .CLKIN_IBUFG_OUT(clkin_ibufg_out), 
     .CLK0_OUT(clk_100mhz_buf), 
     .LOCKED_OUT(locked_dcm)
);

mmu_hier mmu1( 
    .clk(clk_100mhz_buf),
    .rst(rst),
    .PC(PC),
    .cpu_wdata(cpu_wdata),
    .cpu_addr(cpu_addr),
    .cpu_we(cpu_we),
	 .cpu_en(cpu_en),
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

vgamult vga_hier(
    .clk(clk_25mhz),
    .rst(rst),
    .clk_cnt(clk_cnt[31:0]),
    .dataa(vga_data_1),
    .datab(vga_data_2),
    .datac(vga_data_3),
    .locked_dcm(locked_dcm),
    .hsync(hsync),
    .vsync(vsync),
    .blank(blank),
    .dvi_rst(dvi_rst),
    .pixel_r(pixel_r),
    .pixel_g(pixel_g),
    .pixel_b(pixel_b),
    .D(D),
    .scl_tri(scl_tri), 
    .sda_tri(sda_tri)
);

clk_counter cnt1(
    .clk(clk_100mhz_buf),
    .rst(rst),
    .halt(1'b0),
    .clk_cnt(clk_cnt)
);
initial begin 
	clka = 1'b0;
    spart_tx_full = 1'b1;
    spart_rx_empty= 1'b1;
	forever #10 clka=~clka;
end

initial begin
    #0   spu_addr = 32'h00800000;
    cpu_addr = 32'h0080007c;
    PC = 32'h00000000;
    rst = 1'b1;
    cpu_we = 1'b0;
	 cpu_en = 4'hf;
    #10 rst = 1'b0;
    /* test cpu instr read */
    $display("test cpu instr read");
    repeat (32) begin
        @(posedge clka)
        PC = PC + 4;
    end
    /* test cpu memory write*/
    $display("test cpu memory write");
    repeat (32) begin
        @(posedge clka)
        cpu_wdata = cpu_addr*4 + cpu_addr;
        cpu_we = 1'b1;
        //$display ("@%d,\tcpu_addr=%x,\twrite-data=%x",$time,cpu_addr, cpu_wdata);
        cpu_addr = cpu_addr + 4;
    end
    cpu_we = 1'b0;
    /* test spu memory read and cpu write results */
    $display("test spu memory read and cpu write results");
    repeat (16) begin
        @(posedge clka)
        spu_addr = spu_addr + 4;
        //$display ("@%d,\tspu_addr=%x,\tread-data=%x",$time,spu_addr, spu_read_data);
    end
    /* test memory mapped spart read and write */
    $display("test memory mapped spart read and write");
    @(posedge clka)
    cpu_addr = 32'h00a00000;
    cpu_we = 1'b1;
    //$display ("@%d,\tcpu_addr=%x,\twrite-data=%x",$time,cpu_addr, cpu_wdata);
    //$display ("@%d,\ttx_data=%x",$time, spart_tx_data);
    @(posedge clka)
    //$display ("@%d,\ttx_data=%x",$time, spart_tx_data);
    cpu_addr = cpu_addr + 4;
    cpu_we = 1'b0;
    //$display ("@%d,\tcpu_addr=%x,\tread-data=%x",$time,cpu_addr, cpu_read_data);
    @(posedge clka)
    cpu_addr = cpu_addr + 4;
    //$display ("@%d,\tcpu_addr=%x,\tread-data=%x",$time,cpu_addr, cpu_read_data);
    @(posedge clka)
    cpu_addr = cpu_addr + 4;
    //$display ("@%d,\tcpu_addr=%x,\tread-data=%x",$time,cpu_addr, cpu_read_data);
    @(posedge clka)
    //$display ("@%d,\tcpu_addr=%x,\tread-data=%x",$time,cpu_addr, cpu_read_data);
    /* test spu result write and VGA read */
    $display("test spu result write and VGA read");
    spu_res_addr = 4'h0;
    spu_res_data = 32'h0;    
    @(posedge clka)
    repeat (32) begin
        @(posedge clka)
        spu_res_addr = spu_res_addr + 1;
        spu_res_data = spu_res_addr + spu_res_data*4;
    end
    /* test cpu read spu register */
    $display("test cpu read spu registers");
    cpu_addr = 32'h00b00000;
    repeat (16) begin
        @(posedge clka)
        cpu_addr = cpu_addr + 4;
    end
    $finish;
end

/*monitor statements*/
initial begin
    //$monitor ("[monitor]@%d,\tvga_data1=%x,\tvga_data2=%x,\tvga_data3=%x",$time, vga_data_1, vga_data_2, vga_data_3);
    //$monitor ("[monitor]@%d,\ttx_data_reg=%x",$time, iDUT.spart_tx_data_reg);
    $monitor ("@%d,\tspu_addr=%x,\tread-data=%x",$time,spu_addr, spu_read_data);
    //$monitor ("@%d,\tPC=%x,\tinstruction=%x",$time, PC, instruction);
    //$monitor ("@%d,\tcpu_addr=%x,\tread_data=%x",$time, cpu_addr, cpu_read_data);
    //$monitor ("@%d,\tcpu_addr=%x,\twrite_data=%x",$time, cpu_addr, cpu_write_data);
end
endmodule
