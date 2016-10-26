`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:59:10 10/18/2016 
// Design Name: 
// Module Name:    mmu_hier 
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
module mmu_hier( 
    input          clk_100mhz,
    input [31:0]   PC,
    input [31:0]   cpu_wdata,
    input [31:0]   cpu_addr,
    input [127:0]  spu_wdata,
    input [31:0]   spu_addr,
                   
    output [31:0]  cpu_rdata,
    output [31:0]  instruction,
    output [127:0] spu_rdata,
    output [31:0]  vga_data_1,
    output [31:0]  vga_data_2,
    output [31:0]  vga_data_3,
                   
	 inout [7:0]    spart_databus,
	 inout [31:0]   ethernet_databus
    );
	 
    reg [31:0] [0:3] spu_reg;
    
    assign vga_data_1 = spu[0];
    assign vga_data_1 = spu[1];
    assign vga_data_2 = spu[2];
	 
main_mem data_mem (
  .clka(clk_100mhz), // input clka
  .rsta(rst), // input rsta
  .ena(1'b1), // input ena
  .wea(4'hF), // input [3 : 0] wea
  .addra(cpu_addr), // input [31 : 0] addra
  .dina(cpu_wdata), // input [31 : 0] dina
  .douta(cpu_rdata), // output [31 : 0] douta
  .clkb(clk_100mhz), // input clkb
  .rstb(rst), // input rstb
  .enb(enb), // input enb
  .web(web), // input [15 : 0] web
  .addrb(spu_addr), // input [31 : 0] addrb
  .dinb(spu_wdata), // input [127 : 0] dinb
  .doutb(spu_rdata) // output [127 : 0] doutb
);

instruction_memory inst_mem(
  .clka(clk_100mhz), // input clka
  .addra(PC), // input [31 : 0] addra
  .douta(instruction), // output [31 : 0] douta
  .clkb(clk_100mhz), // input clkb
  .addrb(addrb), // input [31 : 0] addrb
  .doutb(doutb) // output [31 : 0] doutb
);

endmodule
