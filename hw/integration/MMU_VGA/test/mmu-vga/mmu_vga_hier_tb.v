`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:30:39 11/01/2016 
// Design Name: 
// Module Name:    mmu_hier_tb 
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
module mmu_vga_hier_tb(
    input clk,          // 100mhz clock
    input rst,          // Asynchronous reset, tied to dip switch 0
	 input [5:0] vga_cfg, // vga output mux switches
    input rxd,          // RS232 Recieve Data
    output txd,         // RS232 Transmit Data
    output hsync,
    output vsync,
    output blank,
    output dvi_rst,
    output GPIO_LED_0,
    output GPIO_LED_1,
    output GPIO_LED_2,
    output GPIO_LED_3,
    output GPIO_LED_4,
    output GPIO_LED_5,
    output GPIO_LED_6,
    output GPIO_LED_7,
    output [7:0] pixel_r,
    output [7:0] pixel_g,
    output [7:0] pixel_b,
    output [11:0] D,
    output clk_vga,
    output clk_vga_n,
    inout scl_tri, sda_tri
);

    reg cpu_we, spart_tx_full, spart_rx_empty, data_mem_wr;
    reg [3:0] cpu_en;
    reg [7:0] spart_rx_data;
    reg [31:0] cpu_wdata, cpu_addr;
    reg [31:0] spu_addr, spu_res_addr, spu_res_data;
    reg [127:0] spu_wdata;
     
    wire clk_25mhz, clkin_ibufg_out, clk_100mhz_buf, locked_dcm;

    wire [63:0] clk_cnt;
    wire [7:0]  spart_tx_data;
    wire [31:0] PC, cpu_read_data, instruction;
    reg  [31:0] vga_data_1_reg, vga_data_2_reg, vga_data_3_reg;
    wire [31:0] data_1, data_2, data_3;
    wire [31:0] vga_data_1, vga_data_2, vga_data_3;
    wire [127:0] spu_read_data;

    assign data_1 = vga_data_1_reg;
    assign data_2 = vga_data_2_reg;
    assign data_3 = vga_data_3_reg;

    assign clk_vga = clk_25mhz;
    assign clk_vga_n = ~clk_25mhz;

    assign GPIO_LED_0 = 1'b1;
    assign GPIO_LED_1 = 1'b0;
    assign GPIO_LED_2 = 1'b1;
    assign GPIO_LED_3 = 1'b0;
    assign GPIO_LED_4 = 1'b1;
    assign GPIO_LED_5 = 1'b0;
    assign GPIO_LED_6 = 1'b1;
    assign GPIO_LED_7 = 1'b0;
    assign txd = 1'b1;

vga_clk vga_clk_gen1(
    .CLKIN_IN(clk), 
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
    .clk_cnt(clk_cnt),
    .dataa(data_1),
    .datab(data_2),
    .datac(data_3),
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

always @(posedge clk_100mhz_buf) begin 
    vga_data_1_reg = 32'h0;
    case(vga_cfg[5:4])
        4'h0 : vga_data_1_reg = 32'hFF;
        4'h1 : vga_data_1_reg = 32'hFF00;
        4'h2 : vga_data_1_reg = 32'hFF0000;
        4'h3 : vga_data_1_reg = 32'hFF000000;
    endcase
end
always @(posedge clk_100mhz_buf) begin 
    vga_data_2_reg = 32'h0;
    case(vga_cfg[3:2])
        4'h0 : vga_data_2_reg = 32'hFF;
        4'h1 : vga_data_2_reg = 32'hFF00;
        4'h2 : vga_data_2_reg = 32'hFF0000;
        4'h3 : vga_data_2_reg = 32'hFF000000;
    endcase
end
always @(posedge clk_100mhz_buf) begin 
    vga_data_3_reg = 32'h0;
    case(vga_cfg[1:0])
        4'h0 : vga_data_3_reg = 32'hFF;
        4'h1 : vga_data_3_reg = 32'hFF00;
        4'h2 : vga_data_3_reg = 32'hFF0000;
        4'h3 : vga_data_3_reg = 32'hFF000000;
    endcase
end

endmodule
