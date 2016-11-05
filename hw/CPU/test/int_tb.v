module int_tb();
	wire        Halt;         /* Halt executed and in Memory or writeback stage */
	integer     regDmpFile;
     
    reg clk; 
    reg rst; 
	wire [31:0] PC;
	wire [31:0] Inst;        
	wire        MemWrite;      
	wire [31:0] MemAddress;
	wire [31:0] MemData;
	wire [31:0] MemReadData; 

	wire [31:0] 	 r0Data;
	wire [31:0] 	 r1Data;
	wire [31:0] 	 r2Data;
	wire [31:0] 	 r3Data;
	wire [31:0] 	 r4Data;
	wire [31:0] 	 r5Data;
	wire [31:0] 	 r6Data;
	wire [31:0] 	 r7Data;
	wire [31:0] 	 r8Data;
	wire [31:0] 	 r9Data;
	wire [31:0] 	 r10Data;
	wire [31:0] 	 r11Data;
	wire [31:0] 	 r12Data;
	wire [31:0] 	 r13Data;
	wire [31:0] 	 r14Data;
	wire [31:0] 	 r15Data;
	wire [31:0] 	 r16Data;
	wire [31:0] 	 r17Data;
	wire [31:0] 	 r18Data;
	wire [31:0] 	 r19Data;
	wire [31:0] 	 r20Data;
	wire [31:0] 	 r21Data;
	wire [31:0] 	 r22Data;
	wire [31:0] 	 r23Data;
	wire [31:0] 	 r24Data;
	wire [31:0] 	 r25Data;
	wire [31:0] 	 r26Data;
	wire [31:0] 	 r27Data;
	wire [31:0] 	 r28Data;
	wire [31:0] 	 r29Data;
	wire [31:0] 	 r30Data;
	wire [31:0] 	 r31Data;

    reg stall; 
    
   proc DUT(
		.clk(clk), 
		.rst(rst),
		.data_mem_addr(MemAddress),
		.data_mem_write_data(MemData),
		.data_mem_wr(MemWrite),
		.data_mem_en(MemEnable),
		.PC_curr(PC),
		.data_mem_data(MemReadData),
		.instruction(Inst),
		.HALTED(Halt),
		.SPART_STALL_DBG_ONLY(stall)
	);
  

	memory2c #(0) d_mem(
		.data_out(MemReadData),
		.data_in(MemData),
		.addr(MemAddress),
		.enable(MemEnable),
		.wr(MemWrite),
		.createdump(Halt),
		.clk(clk),
		.rst(rst)
	);
	
	memory2c #(1) i_mem(
		.data_out(Inst),
		.data_in(32'h0),
		.addr(PC),
		.enable(1'b1),
		.wr(1'b0),
		.createdump(1'b0),
		.clk(clk),
		.rst(rst)
	);
	
   initial begin
      $display("Hello world...simulation starting");
      $display("See verilogsim.log and verilogsim.trace for output");
      clk = 0; 
      rst = 1; 
      stall = 0; 
      repeat (5) @(posedge clk);
      rst = 0; 
      @(posedge clk);
      stall = 1;
      repeat (5) @(posedge clk);
      stall = 0; 
      @(posedge clk);
      stall = 1;
      repeat (5) @(posedge clk);
      stall = 0; 
      @(posedge clk);
      stall = 1;
      repeat (5) @(posedge clk);
      stall = 0; 
   end

   always @ (posedge DUT.clk) begin
      if (!DUT.rst) begin
         if (Halt) begin
			regDmpFile = $fopen("reg_dump.dmp");
            $fdisplay(regDmpFile,"%8h", r0Data);
			$fdisplay(regDmpFile,"%8h", r1Data);
			$fdisplay(regDmpFile,"%8h", r2Data);
			$fdisplay(regDmpFile,"%8h", r3Data);
			$fdisplay(regDmpFile,"%8h", r4Data);
			$fdisplay(regDmpFile,"%8h", r5Data);
			$fdisplay(regDmpFile,"%8h", r6Data);
		    $fdisplay(regDmpFile,"%8h", r7Data);
			$fdisplay(regDmpFile,"%8h", r8Data);
			$fdisplay(regDmpFile,"%8h", r9Data);
			$fdisplay(regDmpFile,"%8h", r10Data);
			$fdisplay(regDmpFile,"%8h", r11Data);
			$fdisplay(regDmpFile,"%8h", r12Data);
			$fdisplay(regDmpFile,"%8h", r13Data);
			$fdisplay(regDmpFile,"%8h", r14Data);
			$fdisplay(regDmpFile,"%8h", r15Data);
			$fdisplay(regDmpFile,"%8h", r16Data);
			$fdisplay(regDmpFile,"%8h", r17Data);
			$fdisplay(regDmpFile,"%8h", r18Data);
			$fdisplay(regDmpFile,"%8h", r19Data);
			$fdisplay(regDmpFile,"%8h", r20Data);
			$fdisplay(regDmpFile,"%8h", r21Data);
			$fdisplay(regDmpFile,"%8h", r22Data);
			$fdisplay(regDmpFile,"%8h", r23Data);
			$fdisplay(regDmpFile,"%8h", r24Data);
			$fdisplay(regDmpFile,"%8h", r25Data);
			$fdisplay(regDmpFile,"%8h", r26Data);
			$fdisplay(regDmpFile,"%8h", r27Data);
			$fdisplay(regDmpFile,"%8h", r28Data);
			$fdisplay(regDmpFile,"%8h", r29Data);
			$fdisplay(regDmpFile,"%8h", r30Data);
			$fdisplay(regDmpFile,"%8h", r31Data);
			$fclose(regDmpFile);
			$stop;
		 end
	  end 
   end

   assign r0Data = DUT.D.regfile.regfile.r0Data;
   assign r1Data = DUT.D.regfile.regfile.r1Data;
   assign r2Data = DUT.D.regfile.regfile.r2Data;
   assign r3Data = DUT.D.regfile.regfile.r3Data;
   assign r4Data = DUT.D.regfile.regfile.r4Data;
   assign r5Data = DUT.D.regfile.regfile.r5Data;
   assign r6Data = DUT.D.regfile.regfile.r6Data;
   assign r7Data = DUT.D.regfile.regfile.r7Data;
   assign r8Data = DUT.D.regfile.regfile.r8Data;
   assign r9Data = DUT.D.regfile.regfile.r9Data;
   assign r10Data = DUT.D.regfile.regfile.r10Data;
   assign r11Data = DUT.D.regfile.regfile.r11Data;
   assign r12Data = DUT.D.regfile.regfile.r12Data;
   assign r13Data = DUT.D.regfile.regfile.r13Data;
   assign r14Data = DUT.D.regfile.regfile.r14Data;
   assign r15Data = DUT.D.regfile.regfile.r15Data;
   assign r16Data = DUT.D.regfile.regfile.r16Data;
   assign r17Data = DUT.D.regfile.regfile.r17Data;
   assign r18Data = DUT.D.regfile.regfile.r18Data;
   assign r19Data = DUT.D.regfile.regfile.r19Data;
   assign r20Data = DUT.D.regfile.regfile.r20Data;
   assign r21Data = DUT.D.regfile.regfile.r21Data;
   assign r22Data = DUT.D.regfile.regfile.r22Data;
   assign r23Data = DUT.D.regfile.regfile.r23Data;
   assign r24Data = DUT.D.regfile.regfile.r24Data;
   assign r25Data = DUT.D.regfile.regfile.r25Data;
   assign r26Data = DUT.D.regfile.regfile.r26Data;
   assign r27Data = DUT.D.regfile.regfile.r27Data;
   assign r28Data = DUT.D.regfile.regfile.r28Data;
   assign r29Data = DUT.D.regfile.regfile.r29Data;
   assign r30Data = DUT.D.regfile.regfile.r30Data;
   assign r31Data = DUT.D.regfile.regfile.r31Data;
   
   always #5 clk = ~clk; 
   
endmodule
