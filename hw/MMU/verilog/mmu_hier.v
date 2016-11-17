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
    input          clk,
    input          rst,
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
    output [7:0]   spart_tx_data
    );
	 
    reg [31:0] spu_reg [0:15];
    reg [31:0] cpu_rdata_reg, mem_mapped_reg;
    reg [7:0] spart_tx_reg, spart_rx_reg, spart_tx_data_reg;
    reg cpu_inst_read, mem_mapped_read;
    wire [31:0] cpu_data_mem, cpu_data_inst;
    reg [31:0] cpu_addr_mem, cpu_addr_inst;
    integer    i;
    
    assign vga_data_1 = spu_reg[0];
    assign vga_data_2 = spu_reg[1];
    assign vga_data_3 = spu_reg[2];
    assign cpu_read_data = cpu_rdata_reg;
    assign spart_tx_data = spart_tx_data_reg;
	 
	         
main_mem data_mem (
  .clka(clk), // input clka
  .rsta(rst), // input rsta
  .wea({4{cpu_we}}), // input [3 : 0] wea
  .addra(cpu_addr_mem), // input [31 : 0] addra
  .dina(cpu_wdata), // input [31 : 0] dina
  .douta(cpu_data_mem), // output [31 : 0] douta
  .clkb(clk), // input clkb
  .rstb(rst), // input rstb
  .web(16'h0), // input [15 : 0] web
  .addrb(spu_addr), // input [31 : 0] addrb
  .dinb(spu_wdata), // input [127 : 0] dinb
  .doutb(spu_read_data) // output [127 : 0] doutb
);

instruction_memory inst_mem(
  .clka(clk), // input clka
  .addra(PC), // input [31 : 0] addra
  .douta(instruction), // output [31 : 0] douta
  .clkb(clk), // input clkb
  .addrb(cpu_addr_inst), // input [31 : 0] addrb
  .doutb(cpu_data_inst) // output [31 : 0] doutb
);
    
    always@(posedge clk) begin
        if(rst) begin
            for(i = 0; i < 16; i=i+1) begin
                spu_reg[i] <= 32'h0;
            end
            spart_rx_reg <= 8'h0;
        end
        else begin
            spu_reg[spu_res_addr] <= spu_res_data;
            spart_rx_reg <= spart_rx_data;
        end
    end
    
    always@(*)
        if(cpu_we && mem_mapped_read)
            spart_tx_data_reg = spart_tx_reg;
        else
            spart_tx_data_reg = spart_tx_data;
    
    always@(*) begin
        case({cpu_inst_read, mem_mapped_read})
            2'b00 : begin
                cpu_rdata_reg = cpu_data_mem;
            end
            2'b01 : begin
                cpu_rdata_reg = mem_mapped_reg;
            end
            2'b10 : begin
                cpu_rdata_reg = cpu_data_inst;
            end
            2'b11 : begin
                cpu_rdata_reg = cpu_data_inst;
                // not posible
            end
        endcase
    end
    
    always@(*) begin
        cpu_inst_read = 1'b0;
        mem_mapped_read = 1'b0;
        cpu_addr_inst = 32'h0;
        cpu_addr_mem = 32'h0;
        spart_tx_reg = 8'h0;
        mem_mapped_reg = 32'h0;
        
        case(cpu_addr[23:20])
            4'h0 : begin
                cpu_inst_read = 1'b1;
                cpu_addr_inst = {17'h0,cpu_addr[14:0]};
            end
            4'h8, 4'h9 : begin
                cpu_addr_mem = {11'h0,cpu_addr[20:0]};
            end
            4'hA : begin
                mem_mapped_read = 1'b1;
                case(cpu_addr[3:0])
                    4'h0 : begin 
                        spart_tx_reg   = cpu_wdata[7:0];
                    end
                    4'h4 : mem_mapped_reg = {31'h0,spart_tx_full};
                    4'h8 : mem_mapped_reg = {31'h0,spart_rx_empty};
                    4'hC : mem_mapped_reg = {24'h0,spart_rx_reg};
                endcase
            end
            4'hB : begin
            end
            default : begin
                //memory fault
            end
        endcase
    end        


endmodule
