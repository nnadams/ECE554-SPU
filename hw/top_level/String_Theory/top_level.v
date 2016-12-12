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
	
	// SPU stuff
	wire spu_int;
	wire spu_we; // FOR DEBUG
	wire [3:0] spu_res_addr;
	wire [31:0] spu_res_data, spu_addr;
	wire [127:0] spu_mem_data;
	
	// Clk Count
	wire [63:0] clk_cnt; 
	wire clk_25mhz, clkin_ibufg_out, locked_dcm;
	assign clk_vga = clk_25mhz;
	assign clk_vga_n = ~clk_25mhz;

	wire locked_rst = rst; //| ~locked_dcm;
	assign clk = clk_100mhz;
	/*vga_clk vga_clk_gen1(
		.CLKIN_IN(clk_100mhz), 
		.RST_IN(rst), 
		.CLKDV_OUT(clk_25mhz), 
		.CLKIN_IBUFG_OUT(clkin_ibufg_out), 
		.CLK0_OUT(clk), 
		.LOCKED_OUT(locked_dcm)
	);*/

	 //LED Config 
	led_controller leds(
		 .clk(clk),
		 .rst(locked_rst),
		 .led0(spu_res_data[0] & spu_we), .led0_triggered(1'b1),
		 .led1(spu_res_data[1] & spu_we), .led1_triggered(1'b1),
		 .led2(spu_res_data[2] & spu_we), .led2_triggered(1'b1),
		 .led3(spu_res_data[3] & spu_we), .led3_triggered(1'b1),
		 .led4(spu_res_data[4] & spu_we), .led4_triggered(1'b1),
		 .led5(spu_res_data[5] & spu_we), .led5_triggered(1'b1),
		 .led6(spu_res_data[6] & spu_we), .led6_triggered(1'b1),		
		 .led7(spu_res_data[7] & spu_we), .led7_triggered(1'b1),
		 /*.led0(halt), .led0_triggered(1'b0),
		 .led1((spart_rx_data == 8'd97)), .led1_triggered(1'b1),
		 .led2((spart_rx_data == 8'd98)), .led2_triggered(1'b1),
		 .led3((spart_rx_data == 8'd4)), .led3_triggered(1'b1),
		 .led4(1'b1), .led4_triggered(1'b0),
		 .led5(1'b0), .led5_triggered(1'b0),
		 .led6(1'b0), .led6_triggered(1'b0),		
		 .led7(1'b0), .led7_triggered(1'b0),*/
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
		.rst(locked_rst),
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
		.rst(locked_rst),
		.PC(instr_addr),
		.cpu_wdata(data_mem_write_data),
		.cpu_addr(data_mem_addr),
		.cpu_en(data_mem_en),
		.cpu_we(data_mem_wr),
		.spu_wdata(128'd0),
		.spu_addr(spu_addr),
		.spu_res_addr(spu_res_addr),
		.spu_res_data(spu_res_data),
		.spart_tx_full(full),
		.spart_rx_empty(rx_empty),
		.spart_rx_data(spart_rx_data),
		
		.cpu_read_data(data_mem_data),
		.instruction(instruction),
		.spu_read_data(spu_mem_data),
		.vga_data_1(vga_data_1),
		.vga_data_2(vga_data_2),
		.vga_data_3(vga_data_3),
		.spart_tx_data(spart_tx_data),
		.spart_trmt(trmt),
		.spart_rd(rd_spart)
	 );
	
	SPU spu(
		.clk(clk),
		.rst(locked_rst),
		.i_start(spu_en),
		.i_op(spu_op),
		.i_dest(spu_reg),
		.i_imm(spu_delim),
		.i_strAlocation(spu_data_a),
		.i_strBlocation(spu_data_b),
		.i_mem_data(spu_mem_data),
  		.o_mem_addr(spu_addr),
  		.o_sreg_data(spu_res_data),
  		.o_sreg_addr(spu_res_addr),
  		.o_sreg_we(spu_we),
  		.o_done(spu_int)
	);
	
	spart_tx_fifo spart_tx(
		.clk(clk),
		.rst(locked_rst),
		.write(trmt),
		.tx_data(spart_tx_data),
		.full(full), 
		.txd(txd)
	);	
	
	spart_rx_fifo spart_rx(
		.clk(clk),
		.rst(locked_rst),
		.rxd(rxd),
		.rd_spart(rd_spart),
		.rx_data(spart_rx_data),
		.empty(rx_empty)
	);
	
	/*vgamult VGA(
		.clk(clk_25mhz),
		.rst(locked_rst),
		.clk_cnt(clk_cnt),
		.dataa(vga_data_1),
		.datab(vga_data_2),
		.datac(vga_data_3),
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
	);*/

	clk_counter clock_count(
		.clk(clk), 
		.rst(locked_rst),
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
