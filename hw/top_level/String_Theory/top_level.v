`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:07:48 11/17/2016 
// Design Name: 
// Module Name:    cpu_mmu_integration 
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
module top_level(
	input clk_100mhz, 
	input rst,
	input spu_int,
	input rxd,
	input [5:0] vga_cfg,
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
	inout scl_tri, sda_tri,
	output txd
);
	
	// Outputs From CPU 
	wire [31:0] data_mem_addr;
	wire [31:0] data_mem_write_data;
	wire [3:0] data_mem_wr;
	wire [3:0] data_mem_en;
	wire [31:0] instr_addr;
	wire HALTED; 
	wire [3:0] spu_op;
	wire spu_en; 
	wire [31:0] spu_data_a; 
	wire [31:0] spu_data_b;
	wire [7:0] spu_delim;
    wire [3:0] spu_reg;
	
	// Inputs to CPU
	wire [31:0] data_mem_data;
	wire [31:0] instruction;
	wire HALT_CPU;
	
	// spart stuff
	wire trmt; 
	wire full; 
	wire [7:0] spart_tx_data;
	wire [7:0] spart_rx_data;
	wire rx_empty; 
	wire rd_spart;
	
	//vga stuff    
	reg  [31:0] vga_data_1_reg, vga_data_2_reg, vga_data_3_reg;
	wire [31:0] vga_data_1, vga_data_2, vga_data_3;
	
	// Clk Count
	wire [63:0] clk_cnt; 
	wire clk_25mhz, clkin_ibufg_out, locked_dcm;
	assign clk_vga = clk_25mhz;
	assign clk_vga_n = ~clk_25mhz;

	vga_clk vga_clk_gen1(
		.CLKIN_IN(clk_100mhz), 
		.RST_IN(rst), 
		.CLKDV_OUT(clk_25mhz), 
		.CLKIN_IBUFG_OUT(clkin_ibufg_out), 
		.CLK0_OUT(clk), 
		.LOCKED_OUT(locked_dcm)
	);

	 //LED Config 
	led_controller leds(
		 .clk(clk),
		 .rst(rst),
		 .led0(halt), .led0_triggered(1'b0),
		 .led1((spart_rx_data == 8'd97)), .led1_triggered(1'b1),
		 .led2((spart_rx_data == 8'd98)), .led2_triggered(1'b1),
		 .led3((spart_rx_data == 8'd4)), .led3_triggered(1'b1),
		 .led4(1'b0), .led4_triggered(1'b0),
		 .led5(1'b0), .led5_triggered(1'b0),
		 .led6(1'b0), .led6_triggered(1'b0),		
		 .led7(1'b0), .led7_triggered(1'b0),
		 .GPIO_LED_0(GPIO_LED_0),
		 .GPIO_LED_1(GPIO_LED_1),
		 .GPIO_LED_2(GPIO_LED_2),
		 .GPIO_LED_3(GPIO_LED_3),
		 .GPIO_LED_4(GPIO_LED_4),
		 .GPIO_LED_5(GPIO_LED_5),
		 .GPIO_LED_6(GPIO_LED_6),
		 .GPIO_LED_7(GPIO_LED_7)
	 );
	
	proc PROC (
		.clk(clk),
		.rst(rst),
		.data_mem_addr(data_mem_addr),
		.data_mem_write_data(data_mem_write_data),
		.data_mem_wr(data_mem_wr),
		.data_mem_en(data_mem_en),
		.instr_addr(instr_addr),
		.data_mem_data(data_mem_data),
		.instruction(instruction),
		.HALTED(HALTED),
		.spart_int(~rx_empty),
		.spu_int(spu_int),
		.spu_en_out(spu_en),
		.spu_op_out(spu_op),
		.spu_data_a(spu_data_a),
		.spu_data_b(spu_data_b),
		.spu_delim(spu_delim),
      .spu_dest_reg(spu_reg),
		
		// TEST signal only, used to stall proc until 
		// Theres room in the fifo to send more uart data_mem_addr
		.SPART_STALL_DBG_ONLY(1'b0)
	);
	 
	 mmu_hier MMU(
		.clk(clk),
		.rst(rst),
		.PC(instr_addr),
		.cpu_wdata(data_mem_write_data),
		.cpu_addr(data_mem_addr),
		.cpu_en(data_mem_en),
		.cpu_we(data_mem_wr),
		.spu_wdata(128'd0),
		.spu_addr(32'd0),
		.spu_res_addr(4'd0),
		.spu_res_data(32'd0),
		.spart_tx_full(full),
		.spart_rx_empty(rx_empty),
		.spart_rx_data(spart_rx_data),
		
		.cpu_read_data(data_mem_data),
		.instruction(instruction),
		.spu_read_data(),
		.vga_data_1(vga_data_1),
		.vga_data_2(vga_data_2),
		.vga_data_3(vga_data_3),
		.spart_tx_data(spart_tx_data),
		.spart_trmt(trmt),
		.spart_rd(rd_spart)
	 );
	
	spart_tx_fifo spart_tx(
		.clk(clk),
		.rst(rst),
		.write(trmt),
		.tx_data(spart_tx_data),
		.full(full), 
		.txd(txd)
	);	
	
	spart_rx_fifo spart_rx(
		.clk(clk),
		.rst(rst),
		.rxd(rxd),
		.rd_spart(rd_spart),
		.rx_data(spart_rx_data),
		.empty(rx_empty)
	);
	
	vgamult VGA(
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

	clk_counter clock_count(
		.clk(clk), 
		.rst(rst),
		.halt(HALTED), 
		.clk_cnt(clk_cnt)
	);
    assign data_1 = vga_data_1_reg;
    assign data_2 = vga_data_2_reg;
    assign data_3 = vga_data_3_reg;	
always @(posedge clk) begin 
    vga_data_1_reg = 32'h0;
    case(vga_cfg[5:4])
        4'h0 : vga_data_1_reg = 32'hFF;
        4'h1 : vga_data_1_reg = 32'hFF00;
        4'h2 : vga_data_1_reg = 32'hFF0000;
        4'h3 : vga_data_1_reg = 32'hFF000000;
    endcase
end
always @(posedge clk) begin 
    vga_data_2_reg = 32'h0;
    case(vga_cfg[3:2])
        4'h0 : vga_data_2_reg = 32'hFF;
        4'h1 : vga_data_2_reg = 32'hFF00;
        4'h2 : vga_data_2_reg = 32'hFF0000;
        4'h3 : vga_data_2_reg = 32'hFF000000;
    endcase
end
always @(posedge clk) begin 
    vga_data_3_reg = 32'h0;
    case(vga_cfg[1:0])
        4'h0 : vga_data_3_reg = 32'hFF;
        4'h1 : vga_data_3_reg = 32'hFF00;
        4'h2 : vga_data_3_reg = 32'hFF0000;
        4'h3 : vga_data_3_reg = 32'hFF000000;
    endcase
end
endmodule
