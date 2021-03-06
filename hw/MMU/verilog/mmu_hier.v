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
    input [3:0]    cpu_we,
    input [3:0]    cpu_en, 
    input [127:0]  spu_wdata,
    input [31:0]   spu_addr,
    input [3:0]    spu_res_addr,
    input [31:0]   spu_res_data,
    input          spu_res_wr_en, 
    input          spart_tx_full,
    input          spart_rx_empty,
    input [7:0]    spart_rx_data,
                  
    output [31:0]  cpu_read_data,
    output [31:0]  instruction,
    output [127:0] spu_read_data,
    output [31:0]  vga_data_1,
    output [31:0]  vga_data_2,
    output [31:0]  vga_data_3,
    output [7:0]   spart_tx_data,
    output         spart_trmt,
    output           spart_rd
    );
     
    reg [31:0] spu_reg [0:15];
    reg [31:0] cpu_rdata_reg, mem_mapped_reg, spu_res_mapped_reg;
    reg [7:0] spart_tx_reg;
    reg cpu_inst_read, mem_mapped_read, spu_res_mapped_read;
    wire [31:0] cpu_data_mem, cpu_data_inst;
    reg [31:0] cpu_addr_mem, cpu_addr_inst;
    wire [3:0] aligned_cpu_wr_en;
    wire [31:0] cpu_wr_data; 
    integer    i;
    reg spart_trmt_reg; 
	 reg spart_rd_reg; 
	wire [3:0] cpu_data_mem_wr_en; 
	 wire [3:0] cpu_imem_we;
    wire [63:0] clk_cnt;
	
    assign vga_data_1 = spu_reg[0];
    assign vga_data_2 = spu_reg[1];
    assign vga_data_3 = spu_reg[2];
    assign spart_tx_data = spart_tx_reg;
	assign spart_trmt = spart_trmt_reg & |cpu_we;
	assign cpu_data_mem_wr_en = mem_mapped_read ? 4'b0000 : cpu_we;
	assign spart_rd = spart_rd_reg & |cpu_en;
	assign cpu_imem_we = (cpu_inst_read && &cpu_we) ? 4'b1111 : 4'b0000;
	// For byte reads 
	assign cpu_read_data = (cpu_en == 4'b1111) ? cpu_rdata_reg :
						   (cpu_addr[1:0] == 2'b00) ? (cpu_rdata_reg & 32'h000000ff) :
						   (cpu_addr[1:0] == 2'b01) ? (cpu_rdata_reg & 32'h0000ff00) >> 8 :
						   (cpu_addr[1:0] == 2'b10) ? (cpu_rdata_reg & 32'h00ff0000) >> 16 :
						   (cpu_addr[1:0] == 2'b11) ? (cpu_rdata_reg & 32'hff000000) >> 24: cpu_rdata_reg;
	
    // For Byte writes 
    assign aligned_cpu_wr_en = (cpu_data_mem_wr_en == 4'b0000) ? 4'b0000 :
                               (cpu_data_mem_wr_en == 4'b1111) ? 4'b1111 :
                               (cpu_addr[1:0] == 2'b00) ? 4'b0001 :
                               (cpu_addr[1:0] == 2'b01) ? 4'b0010 :
                               (cpu_addr[1:0] == 2'b10) ? 4'b0100 :
                               (cpu_addr[1:0] == 2'b11) ? 4'b1000 : 4'b0000;
    
    assign cpu_wr_data =  (cpu_data_mem_wr_en == 4'b1111) ? cpu_wdata :
						  (cpu_addr[1:0] == 2'b00) ? (cpu_wdata & 32'h000000ff) :
						  (cpu_addr[1:0] == 2'b01) ? (cpu_wdata & 32'h000000ff) << 8 :
						  (cpu_addr[1:0] == 2'b10) ? (cpu_wdata & 32'h000000ff) << 16 :
						  (cpu_addr[1:0] == 2'b11) ? (cpu_wdata & 32'h000000ff) << 24: cpu_wdata; 
     
    wire [31:0] spu_data_mem_addr;
    assign spu_data_mem_addr = (spu_addr & 32'h000fffff) >> 0;
    
data_mem main_mem (
  .clka(clk), // input clka
  .rsta(rst), // input rsta
  .wea(aligned_cpu_wr_en), // input [3 : 0] wea
  .addra(cpu_addr_mem), // input [31 : 0] addra
  .dina(cpu_wr_data), // input [31 : 0] dina
  .douta(cpu_data_mem), // output [31 : 0] douta
  .clkb(clk), // input clkb
  .rstb(rst), // input rstb
  .web(16'h0), // input [15 : 0] web
  .addrb(spu_data_mem_addr), // input [31 : 0] addrb
  .dinb(spu_wdata), // input [127 : 0] dinb
  .doutb(spu_read_data) // output [127 : 0] doutb
);
wire rst_clk_cnt; 
assign rst_clk_cnt = &cpu_we & ((cpu_addr == 32'h00B00040) || (cpu_addr == 32'h00B00044));
clk_counter cnt(.clk(clk), .rst(rst), .soft_rst(rst_clk_cnt) , .clk_cnt(clk_cnt));

clk_counter cnt(clk, (rst|| ((cpu_addr == 32'h00B00040) || (cpu_addr == 32'h00B00044))) , clk_cnt);

inst_mem imem(
  .clka(clk), // input clka
  .addra(PC), // input [31 : 0] addra
  .dina(32'h0000),
  .wea(4'h0),
  .rsta(rst),
  .douta(instruction), // output [31 : 0] douta
  .clkb(clk), // input clkb
  .rstb(rst),
  .web(cpu_imem_we),
  .dinb(cpu_wdata),
  .addrb(cpu_addr_inst), // input [31 : 0] addrb
  .doutb(cpu_data_inst) // output [31 : 0] doutb
);
    
    always@(posedge clk) begin
        if(rst) begin
            for(i = 0; i < 16; i=i+1) begin
                spu_reg[i] <= 32'h0;
            end
        end
        else if(spu_res_mapped_read) begin
              if(cpu_addr[7:0] == 8'h40)
                 spu_res_mapped_reg <= clk_cnt[31:0];
             else if(cpu_addr[7:0] == 8'h44)
                 spu_res_mapped_reg <= clk_cnt[63:32];
             else
                 spu_res_mapped_reg <= spu_reg[cpu_addr[5:2]];
        end
        else if(spu_res_wr_en) begin
            spu_reg[spu_res_addr] <= spu_res_data;
        end
    end
    
    always@(*) begin
        case({spu_res_mapped_read, cpu_inst_read, mem_mapped_read})
            3'b000 : begin
                cpu_rdata_reg = cpu_data_mem;
            end
            3'b001 : begin
                cpu_rdata_reg = mem_mapped_reg;
            end
            3'b010 : begin
                cpu_rdata_reg = cpu_data_inst;
            end
            3'b100 : begin
                cpu_rdata_reg = spu_res_mapped_reg;
            end
            default : begin
                cpu_rdata_reg = cpu_data_mem;
            end
        endcase
    end
    
    always@(*) begin
        cpu_inst_read = 1'b0;
        mem_mapped_read = 1'b0;
        spu_res_mapped_read = 1'b0;
        cpu_addr_inst = 32'h0;
        cpu_addr_mem = 32'h0;
        spart_tx_reg = 8'h0;
        mem_mapped_reg = 32'h0;
        spart_trmt_reg = 1'b0; 
        spart_rd_reg = 1'b0;
          
        case(cpu_addr[23:20])
            4'h0 : begin
                cpu_inst_read = 1'b1;
                cpu_addr_inst = {17'h0,cpu_addr[14:0]};
            end
            4'h8, 4'h9 : begin
                cpu_addr_mem = {11'h0, (cpu_addr[20:0] & 21'h1ffffc) };
            end
            4'hA : begin
                mem_mapped_read = 1'b1;
                case(cpu_addr[3:0])
                    4'h0 : begin 
                        spart_tx_reg   = cpu_wdata[7:0];
                        spart_trmt_reg = 1'b1; 
                    end
                    4'h4 : mem_mapped_reg = {31'h0,spart_tx_full};
                    4'h8 : mem_mapped_reg = {31'h0,spart_rx_empty};
                    4'hC : begin 
                                mem_mapped_reg = {24'h0,spart_rx_data};
                                spart_rd_reg = 1'b1;
                            end
                endcase
            end
            4'hB : begin
                spu_res_mapped_read = 1'b1;

            end
            default : begin
                //memory fault
            end
        endcase
    end        


endmodule
