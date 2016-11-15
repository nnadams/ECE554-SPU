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
module mmu_hier_tb(
    input clk,          // 100mhz clock
    input rst,          // Asynchronous reset, tied to dip switch 0
    output txd,         // RS232 Transmit Data
    input rxd          // RS232 Recieve Data
    //input [1:0] br_cfg // Baud Rate Configuration, Tied to dip switches 2 and 3
);

    reg cpu_we, spart_tx_full, spart_rx_empty, data_mem_wr;
    reg [7:0] spart_rx_data;
    reg [31:0] cpu_wdata, cpu_addr;
    reg [31:0] spu_addr, spu_res_addr, spu_res_data;
    reg [127:0] spu_wdata;

    wire       HALT_CPU;
    wire [7:0]  spart_tx_data;
    wire [31:0] PC, cpu_read_data, instruction;
    wire [31:0] vga_data_1, vga_data_2, vga_data_3;
    wire [127:0] spu_read_data;

/*  input          clk,
    input          rst_n,
    input [31:0]   PC,
    input [31:0]   cpu_wdata,
    input [31:0]   cpu_addr,
    input          cpu_we,
    input [127:0]  spu_wdata,
    input [31:0]   spu_addr,
    input [3:0]    spu_res_addr,
    input [31:0]   spu_res_data,
    input          spart_tx_full,
    input          spart_rx_empty,
    input [7:0]    spart_rx_data,
                   
    output [31:0]  cpu_read_data,
    output [31:0]  instruction,
    output [127:0] spu_read_data,
    output [31:0]  vga_data_1,
    output [31:0]  vga_data_2,
    output [31:0]  vga_data_3,
    output [7:0]   spart_tx_data*/
mmu_hier iDUT( 
    .clk(clk),
    .rst_n(rst),
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
    
    // outputs
    .cpu_read_data(cpu_read_data),
    .instruction(instruction),
    .spu_read_data(spu_read_data),
    .vga_data_1(vga_data_1),
    .vga_data_2(vga_data_2),
    .vga_data_3(vga_data_3),
    .spart_tx_data(spart_tx_data)
);
	 
/*  input clk,
    input rst,
    input [31:0] instruction,
    input [31:0] data_mem_addr,
    input [31:0] data_mem_read_data,
    input data_mem_wr,
    input CPU_HALTED,
    output tx, 
    output HALT_CPU*/
cpu_trace trace(
    .clk(clk), 
    .rst(rst),
    .data1((PC - 32'h4)),
    .data2(instruction),
    .data3(PC),
    .data4(PC),
    .data5(PC),
    .data6(PC),
    .CPU_HALTED(1'b0),
    .tx(txd),
    .HALT_CPU(HALT_CPU)
);

pc_inc inc(
    .clk(clk),
    .rst(rst),
    .HALT_CPU(HALT_CPU),
    .PC(PC)
    );

endmodule
