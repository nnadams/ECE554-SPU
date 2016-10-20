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
    );
main_mem mainMEM (
  .clka(clka), // input clka
  .rsta(rsta), // input rsta
  .ena(ena), // input ena
  .wea(wea), // input [3 : 0] wea
  .addra(addra), // input [31 : 0] addra
  .dina(dina), // input [31 : 0] dina
  .douta(douta), // output [31 : 0] douta
  .clkb(clkb), // input clkb
  .rstb(rstb), // input rstb
  .enb(enb), // input enb
  .web(web), // input [15 : 0] web
  .addrb(addrb), // input [31 : 0] addrb
  .dinb(dinb), // input [127 : 0] dinb
  .doutb(doutb) // output [127 : 0] doutb
);

endmodule
