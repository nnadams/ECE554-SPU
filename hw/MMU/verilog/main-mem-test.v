`timescale 1ns/1ns

module test();
reg clka, rst, cpu_we;
reg [31:0]  PC, cpu_wdata, cpu_addr;
reg [127:0] spu_wdata;
reg [31:0]  spu_addr, spu_res_data;
reg [3:0] spu_res_addr;
reg [7:0] spart_rx_data;
reg spart_tx_full, spart_rx_empty;

wire [31:0]  cpu_read_data;
wire [31:0]  instruction;
wire [127:0] spu_read_data;
wire [31:0]  vga_data_1;
wire [31:0]  vga_data_2;
wire [31:0]  vga_data_3;
wire [7:0]   spart_tx_data;


mmu_hier iDUT( 
    .clk(clka),
    .rst(rst),
    .PC(PC),
    .cpu_wdata(cpu_wdata),
    .cpu_addr(cpu_addr),
    .cpu_we(cpu_we),
    .spu_wdata(spu_wdata),
    .spu_addr(spu_addr),
    .spu_res_addr(spu_res_addr),
    .spu_res_data(spu_res_data),
    .spart_tx_full(spart_tx_full),
    .spart_rx_empty(spart_rx_empty),
    .spart_rx_data(spart_rx_data),
                   
    .cpu_read_data(cpu_read_data),
    .instruction(instruction),
    .spu_read_data(spu_read_data),
    .vga_data_1(vga_data_1),
    .vga_data_2(vga_data_2),
    .vga_data_3(vga_data_3),
    .spart_tx_data(spart_tx_data)
);
initial begin 
	clka = 1'b0;
    spart_tx_full = 1'b1;
    spart_rx_empty= 1'b1;
	forever #10 clka=~clka;
end

initial begin
    #0   spu_addr = 32'h00800000;
    cpu_addr = 32'h0080007c;
    rst = 1'b1;
    cpu_we = 1'b0;
    #10 rst = 1'b0;
    /* test cpu memory write*/
    repeat (32) begin
        @(posedge clka)
        cpu_wdata = cpu_addr*4 + cpu_addr;
        cpu_we = 1'b1;
        //$display ("@%d,\tcpu_addr=%x,\twrite-data=%x",$time,cpu_addr, cpu_wdata);
        cpu_addr = cpu_addr + 4;
    end
    cpu_we = 1'b0;
    /* test spu memory read and cpu write results */
    repeat (16) begin
        @(posedge clka)
        spu_addr = spu_addr + 4;
        //$display ("@%d,\tspu_addr=%x,\tread-data=%x",$time,spu_addr, spu_read_data);
    end
    /* test memory mapped spart read and write */
    @(posedge clka)
    cpu_addr = 32'h00a00000;
    cpu_we = 1'b1;
    //$display ("@%d,\tcpu_addr=%x,\twrite-data=%x",$time,cpu_addr, cpu_wdata);
    //$display ("@%d,\ttx_data=%x",$time, spart_tx_data);
    @(posedge clka)
    //$display ("@%d,\ttx_data=%x",$time, spart_tx_data);
    cpu_addr = 32'h00a00004;
    cpu_we = 1'b0;
    //$display ("@%d,\tcpu_addr=%x,\tread-data=%x",$time,cpu_addr, cpu_read_data);
    @(posedge clka)
    cpu_addr = 32'h00a00008;
    //$display ("@%d,\tcpu_addr=%x,\tread-data=%x",$time,cpu_addr, cpu_read_data);
    @(posedge clka)
    cpu_addr = 32'h00a0000c;
    //$display ("@%d,\tcpu_addr=%x,\tread-data=%x",$time,cpu_addr, cpu_read_data);
    @(posedge clka)
    //$display ("@%d,\tcpu_addr=%x,\tread-data=%x",$time,cpu_addr, cpu_read_data);
    /* test spu result write and VGA read */
    spu_res_addr = 4'h0;
    spu_res_data = 32'h0;    
    @(posedge clka)
    repeat (32) begin
        @(posedge clka)
        spu_res_addr = spu_res_addr + 1;
        spu_res_addr = spu_res_addr%3;
        spu_res_data = spu_res_addr + spu_res_data*4;
    end
    $finish;
end

/*monitor statements*/
initial begin
    //$$monitor ("[monitor]@%d,\tvga_data1=%x,\tvga_data2=%x,\tvga_data3=%x",$time, vga_data_1, vga_data_2, vga_data_3);
    //$monitor ("[monitor]@%d,\ttx_data_reg=%x",$time, iDUT.spart_tx_data_reg);
    //$monitor ("@%d,\tspu_addr=%x,\tread-data=%x",$time,spu_addr, spu_read_data);
end
endmodule
