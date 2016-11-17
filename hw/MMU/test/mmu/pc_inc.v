`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:35:29 11/08/2016 
// Design Name: 
// Module Name:    pc_inc 
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
module pc_inc(
    input clk,
    input rst,
    input HALT_CPU,
    output [31:0] PC
    );
    reg [31:0] pc_reg;
    assign PC = pc_reg;
    always@(posedge clk) begin
        if(rst) pc_reg <= 32'h00800000;
        else if(HALT_CPU) pc_reg <= pc_reg;
        else pc_reg <= pc_reg + 32'h4;
    end
endmodule
