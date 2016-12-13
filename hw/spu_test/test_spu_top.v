`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:40:08 11/29/2016 
// Design Name: 
// Module Name:    test 
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
module test_spu_top(
    input clk_100mhz,
    input rst, 
   /* input [31:0] str_a,
    input [31:0] str_b,
    input [3:0] spu_op,
    input [3:0] spu_dest,
    input [7:0] spu_imm,
    */
    output GPIO_LED_0, 
	output GPIO_LED_1, 
	output GPIO_LED_2, 
	output GPIO_LED_3, 
	output GPIO_LED_4, 
	output GPIO_LED_5, 
	output GPIO_LED_6, 
	output GPIO_LED_7,
    output txd
    );
 
	
    	// SPU stuff
	wire spu_int;
	wire spu_we; // FOR DEBUG
	wire [3:0] spu_res_addr;
	wire [31:0] spu_res_data, spu_addr;
	wire [127:0] spu_mem_data;
    
    wire spu_rd_mem; 
    wire clk;
	 wire locked_dcm;
	 //assign clk = clk_100mhz;
	wire locked_rst = rst | ~locked_dcm;

    pll instance_name (
    .CLKIN1_IN(clk_100mhz), 
    .RST_IN(rst), 
    .CLKOUT0_OUT(clk), 
    .LOCKED_OUT(locked_dcm)
    );
    
    reg [7:0] rd_mem_cnt;
    
    always @(posedge clk, posedge locked_rst) begin
        if(locked_rst) 
            rd_mem_cnt <= 8'd0; 
        else if (spu_rd_mem) 
            rd_mem_cnt <= rd_mem_cnt + 1; 
        else 
            rd_mem_cnt <= rd_mem_cnt;
    end 
	//LED Config 
	led_controller leds(
		 .clk(clk),
		 .rst(locked_rst),
		 /*.led0(spu_mem_data[120] == 1'b0 & spu_rd_mem & spu_addr[7:0] == 8'h80 ), .led0_triggered(1'b1),
		 .led1(spu_mem_data[121] == 1'b0 & spu_rd_mem & spu_addr[7:0] == 8'h80 ), .led1_triggered(1'b1),
		 .led2(spu_mem_data[122] == 1'b0 & spu_rd_mem & spu_addr[7:0] == 8'h80 ), .led2_triggered(1'b1),
		 .led3(spu_mem_data[123] == 1'b0 & spu_rd_mem & spu_addr[7:0] == 8'h80 ), .led3_triggered(1'b1),
		 .led4(spu_mem_data[124] == 1'b0 & spu_rd_mem & spu_addr[7:0] == 8'h80 ), .led4_triggered(1'b1),
		 .led5(spu_mem_data[125] == 1'b0 & spu_rd_mem & spu_addr[7:0] == 8'h80 ), .led5_triggered(1'b1),
		 .led6(spu_mem_data[126] == 1'b0 & spu_rd_mem & spu_addr[7:0] == 8'h80 ), .led6_triggered(1'b1),		
		 .led7(spu_mem_data[127] == 1'b0 & spu_rd_mem & spu_addr[7:0] == 8'h80 ), .led7_triggered(1'b1),*/
		 .led0(spu_res_data[0] & spu_we), .led0_triggered(1'b1),
		 .led1(spu_res_data[1] & spu_we), .led1_triggered(1'b1),
		 .led2(spu_res_data[2] & spu_we), .led2_triggered(1'b1),
		 .led3(spu_res_data[3] & spu_we), .led3_triggered(1'b1),
		 .led4(spu_res_data[4] & spu_we), .led4_triggered(1'b1),
		 .led5(spu_res_data[5] & spu_we), .led5_triggered(1'b1),
		 .led6(spu_res_data[6] & spu_we), .led6_triggered(1'b1),		
		 .led7(spu_res_data[7] & spu_we), .led7_triggered(1'b1),
		 .GPIO_LED_0(GPIO_LED_0),
		 .GPIO_LED_1(GPIO_LED_1),
		 .GPIO_LED_2(GPIO_LED_2),
		 .GPIO_LED_3(GPIO_LED_3),
		 .GPIO_LED_4(GPIO_LED_4),
		 .GPIO_LED_5(GPIO_LED_5),
		 .GPIO_LED_6(GPIO_LED_6),
		 .GPIO_LED_7(GPIO_LED_7)
	 );
     
	mmu_hier MMU(
		.clk(clk),
		.rst(locked_rst),
		.PC(32'd0),
		.cpu_wdata(32'd0),
		.cpu_addr(32'd0),
		.cpu_en(4'd0),
		.cpu_we(4'd0),
		.spu_wdata(128'd0),
		.spu_addr(spu_addr),
       .spu_res_wr_en(spu_we),
		.spu_res_addr(spu_res_addr),
		.spu_res_data(spu_res_data),
		.spart_tx_full(1'b0),
		.spart_rx_empty(1'b1),
		.spart_rx_data(8'd0),
		
		.cpu_read_data(),
		.instruction(),
		.spu_read_data(spu_mem_data),
		.vga_data_1(),
		.vga_data_2(),
		.vga_data_3(),
		.spart_tx_data(),
		.spart_trmt(),
		.spart_rd()
	 );
     
     
    reg [5:0] _i_start; 
    wire i_start; 
    always @(posedge clk, posedge locked_rst) begin
        if(locked_rst) 
            _i_start <= 6'd0; 
        else if(_i_start == 6'b111111)
           _i_start <= _i_start;
        else 
            _i_start <= _i_start + 1; 
    end 
    
    assign i_start = (_i_start == 6'd32)  ? 1'b1 : 1'b0; 
    
    SPU _spu   (
        .clk(clk),
		.rst(locked_rst),
		.i_start(i_start),
		/*.i_op(spu_op),
		.i_dest(spu_dest),
		.i_imm(spu_imm),
		.i_strAlocation(str_a),
		.i_strBlocation(str_b),*/
        .i_op(4'b0000),
		.i_dest(4'b0000),
		.i_imm(8'h00),
		.i_strAlocation(32'd0),
		.i_strBlocation(32'd128),
		.i_mem_data(spu_mem_data),
  		.o_mem_addr(spu_addr),
  		.o_sreg_data(spu_res_data),
  		.o_sreg_addr(spu_res_addr),
  		.o_sreg_we(spu_we),
  		.o_done(),
        .o_mem_re(spu_rd_mem)
        );
      reg write_spart;       
    always @(posedge clk, posedge locked_rst) begin
        if(locked_rst) 
            write_spart <=0; 
        else if(spu_rd_mem)
            write_spart <= 1; 
        else 
            write_spart <= 0; 
        
    end    
        
	spart_tx_fifo spart(
	 .clk(clk), 
	 .rst(locked_rst), 
	 .tx_data(spu_mem_data[7:0]), 
	 .write(write_spart), 
	 .full(), 
	 .txd(txd)
     );
endmodule
