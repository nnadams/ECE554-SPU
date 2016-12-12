`timescale 1ns/1ps 
module SPUCore_tb;

localparam STRLEN  = 4'd0;
localparam STRCMP  = 4'd1;
localparam STRCHR  = 4'd2;
localparam STRRCHR = 4'd3;
localparam STRCCHR = 4'd4;
localparam STRSTR  = 4'd5;

reg clk, rst, new_job;
reg [31:0] strAloc, strBloc;
reg [127:0] mem_data;

wire [31:0] mem_addr;
wire done, re;

wire sreg_we;
wire [3:0] sreg_addr;
wire signed [31:0] sreg_data;

initial forever #5 clk = ~clk;

SPUCore DUT (
  .clk(clk),
  .rst(rst),
  .i_start(new_job),
  .i_op(STRCCHR),
  .i_dest(4'hA),
  .i_imm(8'h21),
  .i_strAlocation(strAloc),
  .i_strBlocation(strBloc),
  .i_mem_data(mem_data),
  .o_mem_addr(mem_addr),
  .o_mem_re(re),
  .o_sreg_data(sreg_data),
  .o_sreg_addr(sreg_addr),
  .o_sreg_we(sreg_we),
  .o_done(done)
);

integer i,j;
initial begin
	clk = 1'b0;
	rst = 1'b1;
	new_job = 1'b0;

	#13 rst = 1'b0;

    /*repeat(2) @(posedge clk);
    strAloc = 32'h0012;
    //strBloc = 32'h0012;
    new_job = 1'b1;
    repeat(4) @(posedge clk);
    new_job = 1'b0;
    @(posedge done);*/
    for (i = 0; i < 32'h0014; i = i+1) begin
        //for (j = 0; j < 32'h0011; j = j+1) begin
            repeat(2) @(posedge clk);
            strAloc = i;
            strBloc = j;
            new_job = 1'b1;
            repeat(4) @(posedge clk);
            new_job = 1'b0;
            @(posedge done);
            /*if ( (sreg_data < 0) && (strAloc > strBloc) ) begin
                $display("FAIL A:%d B:%d", strAloc, strBloc);
            end
            else if ( (sreg_data > 0) && (strAloc < strBloc) ) begin
                $display("FAIL A:%d B:%d", strAloc, strBloc);
            end
            else if ( (sreg_data == 0) && (strAloc != strBloc) ) begin
                $display("FAIL A:%d B:%d", strAloc, strBloc);
            end*/
        //end
    end
    
	/*for (i = 0; i < 32'h0014; i = i+1) begin
		repeat(2) @(posedge clk);
		strAloc = i;
		new_job = 1'b1;
		repeat(4) @(posedge clk);
		new_job = 1'b0;
		@(posedge done);
	end*/

	repeat(2) @(posedge clk);
	$stop;
end

always @(posedge clk) begin
	if (re) begin
		if (mem_addr == 32'hAAAA)
			mem_data <= 128'hfff00021646c726f57202c6f6c6c6548;
		else if (mem_addr == 32'h0001)
			mem_data <= 128'h00000000000000000000000000000048;
		else if (mem_addr == 32'h0002)
			mem_data <= 128'h00000000000000000000000000006548;
		else if (mem_addr == 32'h0003)
			mem_data <= 128'h000000000000000000000000006c6548;
		else if (mem_addr == 32'h0004)
			mem_data <= 128'h0000000000000000000000006c6c6548;
		else if (mem_addr == 32'h0005)
			mem_data <= 128'h00000000000000000000006f6c6c6548;
		else if (mem_addr == 32'h0006)
			mem_data <= 128'h000000000000000000002c6f6c6c6548;
		else if (mem_addr == 32'h0007)
			mem_data <= 128'h000000000000000000202c6f6c6c6548;
		else if (mem_addr == 32'h0008)
			mem_data <= 128'h000000000000000057202c6f6c6c6548;
		else if (mem_addr == 32'h0009)
			mem_data <= 128'h000000000000006f57202c6f6c6c6548;
		else if (mem_addr == 32'h000a)
			mem_data <= 128'h000000000000726f57202c6f6c6c6548;
		else if (mem_addr == 32'h000b)
			mem_data <= 128'h00000000006c726f57202c6f6c6c6548;
		else if (mem_addr == 32'h000c)
			mem_data <= 128'h00000000646c726f57202c6f6c6c6548;
		else if (mem_addr == 32'h000d)
			mem_data <= 128'h00000021646c726f57202c6f6c6c6548;
		else if (mem_addr == 32'h000e)
			mem_data <= 128'h00002121646c726f57202c6f6c6c6548;
		else if (mem_addr == 32'h000f)
			mem_data <= 128'h00212121646c726f57202c6f6c6c6548;
		else if (mem_addr == 32'h0010)
			mem_data <= 128'h22212121646c726f57202c6f6c6c6548;
		else if (mem_addr == 32'h0011)
			mem_data <= 128'h00000000000000000000000000000000;
		else if (mem_addr == 32'h0012)
			mem_data <= 128'h21212121646c726f57202c6f6c6c6548;
		else if (mem_addr == 32'h0013)
			mem_data <= 128'h00000000000000000000000000212121;
		else
			mem_data <= 128'd0;
	end
end
	

endmodule
