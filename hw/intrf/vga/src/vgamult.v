`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:13:56 02/10/2014 
// Design Name: 
// Module Name:    vgamult 
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
module vgamult(
    input clk,
    input rst,
    input [63:0] clk_cnt, 
	 input [31:0] dataa, datab, datac,
	 input locked_dcm,
    output hsync,
    output vsync,
    output blank,
    output dvi_rst,
    output [7:0] pixel_r,
    output [7:0] pixel_g,
    output [7:0] pixel_b,
    output [11:0] D,
    inout scl_tri, sda_tri
    
);

    wire [9:0] pixel_x;
    wire [9:0] pixel_y;
    wire [23:0] pixel_gbrg;
     
    assign pixel_gbrg = {pixel_g[3:0], pixel_b, pixel_r, pixel_g[7:4]};
     
    wire clk_25mhz;
    wire clkn_25mhz;
    wire comp_sync;

    wire sda;
    wire scl;
     
    //DVI Interface
    assign dvi_rst = ~(rst|~locked_dcm);
    assign D = (clk)? pixel_gbrg[23:12] : pixel_gbrg[11:0];
    assign sda_tri = (sda)? 1'bz: 1'b0;
    assign scl_tri = (scl)? 1'bz: 1'b0;
     
    dvi_ifc dvi1(   .Clk(clk),                          // Clock input
                    .Reset_n(dvi_rst),                  // Reset input
                    .SDA(sda),                          // I2C data
                    .SCL(scl),                          // I2C clock
                    .Done(done),                        // I2C configuration done
                    .IIC_xfer_done(iic_tx_done),        // IIC configuration done
                    .init_IIC_xfer(1'b0)                // IIC configuration request
                );
        
    vga_logic  vgal1(clk, rst|~locked_dcm, blank, comp_sync, hsync, vsync, pixel_x, pixel_y);
    main_logic main1(clk, rst|~locked_dcm, pixel_x, pixel_y, clk_cnt, dataa, datab, datac, pixel_r, pixel_g, pixel_b);
     
endmodule
