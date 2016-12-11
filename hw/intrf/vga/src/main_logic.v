`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:39:06 02/10/2014 
// Design Name: 
// Module Name:    main_logic 
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
module main_logic(
    input clk,
    input rst,
    input [9:0] pixel_x,
    input [9:0] pixel_y,
    input [63:0] PC,
    input [31:0] dataa,
    input [31:0] datab,
    input [31:0] datac,
    output [7:0] pixel_r,
    output [7:0] pixel_g,
    output [7:0] pixel_b
);
    
    /*assign PC    = 32'h00000000;
    assign dataa = 32'hDEAD0000;
    assign datab = 32'h0000BEEF;
    assign datac = 32'h49830000;*/
     
    draw_logic draw1(clk, rst, pixel_x, pixel_y, pixel_r, pixel_g, pixel_b, PC, dataa, datab, datac);
     
endmodule
