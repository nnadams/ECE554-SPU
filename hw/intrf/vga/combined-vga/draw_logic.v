`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:39:31 02/10/2014 
// Design Name: 
// Module Name:    draw_logic 
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

module draw_logic(clk, rst, pixel_x, pixel_y, pixel_r, pixel_g, pixel_b, PC, dataa, datab, datac);
    input clk;
    input rst;
    input [9:0] pixel_x;
    input [9:0] pixel_y;
    input [31:0] PC;
    input [31:0] dataa;
    input [31:0] datab;
    input [31:0] datac;
	 
    output reg [7:0] pixel_r;
    output reg [7:0] pixel_g;
    output reg [7:0] pixel_b;
	 
    localparam R_TEXT = 3'b000;
    localparam E_TEXT = 3'b001;
    localparam G_TEXT = 3'b010;
    localparam _1_TEXT = 3'b011;
    localparam _2_TEXT = 3'b100;
    localparam _3_TEXT = 3'b101;
    localparam colon_TEXT = 3'b110;
    localparam space_TEXT = 3'b111;
	 
	 reg [3:0] cur_dataa_digit;
    reg [3:0] cur_datab_digit;
    reg [3:0] cur_datac_digit;
    reg [3:0] cur_PC_digit;
    wire [11:0] result_rom_addr;
    wire [23:0] result_rom_color;
	 
    reg [2:0] cur_dataa_text;
    reg [2:0] cur_datab_text;
    reg [2:0] cur_datac_text;
    reg [2:0] cur_PC_text;
    wire [10:0] text_rom_addr;
    wire [23:0] text_rom_color;
	 
    always@(*)
        case(pixel_x[6:4]) 
            3'h0: begin
                cur_PC_digit = PC[23:20];
                cur_dataa_digit = dataa[23:20];
                cur_datab_digit = datab[23:20];
                cur_datac_digit = datac[23:20];
                cur_PC_text    = space_TEXT;
                cur_dataa_text = R_TEXT;
                cur_datab_text = R_TEXT;
                cur_datac_text = R_TEXT;
            end
            3'h1: begin
                cur_PC_digit = PC[19:16];
                cur_dataa_digit = dataa[19:16];
                cur_datab_digit = datab[19:16];
                cur_datac_digit = datac[19:16];
                cur_PC_text    = space_TEXT;
                cur_dataa_text = E_TEXT;
                cur_datab_text = E_TEXT;
                cur_datac_text = E_TEXT;
            end
            3'h2: begin
                cur_PC_digit = PC[15:12];
                cur_dataa_digit = dataa[15:12];
                cur_datab_digit = datab[15:12];
                cur_datac_digit = datac[15:12];
                cur_PC_text    = space_TEXT;
                cur_dataa_text = G_TEXT;
                cur_datab_text = G_TEXT;
                cur_datac_text = G_TEXT;
            end
            3'h3: begin
                cur_PC_digit = PC[11:8];
                cur_dataa_digit = dataa[11:8];
                cur_datab_digit = datab[11:8];
                cur_datac_digit = datac[11:8];
                cur_PC_text    = space_TEXT;
                cur_dataa_text = _1_TEXT;
                cur_datab_text = _2_TEXT;
                cur_datac_text = _3_TEXT;
            end
            3'h4: begin
                cur_PC_digit = PC[7:4];
                cur_dataa_digit = dataa[7:4];
                cur_datab_digit = datab[7:4];
                cur_datac_digit = datac[7:4];
                cur_PC_text    = space_TEXT;
                cur_dataa_text = colon_TEXT;
                cur_datab_text = colon_TEXT;
                cur_datac_text = colon_TEXT;
            end
            3'h5: begin
                cur_PC_digit = PC[3:0];
                cur_dataa_digit = dataa[3:0];
                cur_datab_digit = datab[3:0];
                cur_datac_digit = datac[3:0];
                cur_PC_text    = space_TEXT;
                cur_dataa_text = space_TEXT;
                cur_datab_text = space_TEXT;
                cur_datac_text = space_TEXT;
            end
            3'h6: begin
                cur_PC_digit = PC[31:28];
                cur_dataa_digit = dataa[31:28];
                cur_datab_digit = datab[31:28];
                cur_datac_digit = datac[31:28];
                cur_PC_text    = space_TEXT;
                cur_dataa_text = space_TEXT;
                cur_datab_text = space_TEXT;
                cur_datac_text = space_TEXT;
            end
            3'h7: begin
                cur_PC_digit = PC[27:24];
                cur_dataa_digit = dataa[27:24];
                cur_datab_digit = datab[27:24];
                cur_datac_digit = datac[27:24];
                cur_PC_text    = space_TEXT;
                cur_dataa_text = space_TEXT;
                cur_datab_text = space_TEXT;
                cur_datac_text = space_TEXT;
            end
            default: begin 
                cur_PC_text    = 0;
                cur_dataa_text = 0;
                cur_datab_text = 0;
                cur_datac_text = 0;
            end
    endcase	
    
    wire [3:0] next_pixy;
    wire [3:0] next_pixx;
    wire [2:0] cur_text;
    wire [3:0] cur_digit;
	 
    assign next_pixy = pixel_y+4'h1;
    assign next_pixx = pixel_x+4'h1;
	 
	 assign cur_digit = (pixel_y<15) ? cur_PC_digit : ( pixel_y<31 ? cur_dataa_digit : (pixel_y < 47 ? cur_datab_digit : cur_datac_digit )); 
    assign result_rom_addr = {next_pixy,cur_digit,next_pixx};
	 
    simple_rom #(12,24,"numbers.mem") result_rom(clk, result_rom_addr, result_rom_color);
    
    assign cur_text = (pixel_y<15) ? cur_PC_text : ( pixel_y<31 ? cur_dataa_text : (pixel_y < 47 ? cur_datab_text : cur_datac_text )); 
    assign text_rom_addr = {next_pixy,cur_text,next_pixx};
	 
    simple_rom #(11,24,"reg.mem") text_rom(clk, text_rom_addr, text_rom_color);

    always@(*) begin
        pixel_r = 8'h00;
        pixel_g = 8'h00;
        pixel_b = 8'h00;
        if(~rst) begin
            if(pixel_x < 224 && pixel_y==15) begin
                pixel_r = 8'hC0;
                pixel_g = 8'hC0;
                pixel_b = 8'hFF;
            end 
				else if(pixel_x<96 && pixel_y <64) begin
                pixel_r = text_rom_color[23:16];
                pixel_g = text_rom_color[15:8];
                pixel_b = text_rom_color[7:0];
            end
            else if(pixel_x>=96 && pixel_x < 224 && pixel_y <64) begin
                pixel_r = result_rom_color[23:16];
                pixel_g = result_rom_color[15:8];
                pixel_b = result_rom_color[7:0];
            end
        end
    end 
endmodule

