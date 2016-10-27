module proc_hier_bench();

   wire [31:0] PC;
   wire [31:0] Inst; 
   wire        RegWrite;       
   wire [4:0]  WriteRegister;  
   wire [31:0] WriteData;     
   wire        MemWrite;      
   wire        MemRead;
   wire [31:0] MemAddress;
   wire [31:0] MemData;
   wire [31:0] MemReadData; 
   wire        Halt;         /* Halt executed and in Memory or writeback stage */
        
   integer     inst_count;
   integer     trace_file;
   integer     sim_log_file;
     
    reg clk; 
    reg rst; 
    wire err;

	
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
		.SPART_STALL_DBG_ONLY(1'b0)
	);
  

	memory2c d_mem(
		.data_out(MemReadData),
		.data_in(MemData),
		.addr(MemAddress),
		.enable(MemEnable),
		.wr(MemWrite),
		.createdump(1'b0),
		.clk(clk),
		.rst(rst)
	);
	
	memory2c i_mem(
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
      inst_count = 0;
      trace_file = $fopen("verilogsim.trace");
      sim_log_file = $fopen("verilogsim.log");
      
      clk = 0; 
      rst = 1; 
      repeat (5) @(posedge clk);
      rst = 0; 
   end

   always @ (posedge DUT.clk) begin
      if (!DUT.rst) begin
         if (Halt || RegWrite || MemWrite) begin
            inst_count = inst_count + 1;
         end
         $fdisplay(sim_log_file, "SIMLOG:: PC: %8x I: %8x R: %d %3d %8x M: %d %d %8x %8x",
                  PC,
                  Inst,
                  RegWrite,
                  WriteRegister,
                  WriteData,
                  MemRead,
                  MemWrite,
                  MemAddress,
                  MemData);
         if (RegWrite) begin
            if (MemWrite) begin
               // stu
               $fdisplay(trace_file,"INUM: %8d PC: 0x%08x REG: %d VALUE: 0x%08x ADDR: 0x%08x VALUE: 0x%08x",
                        (inst_count-1),
                        PC,
                        WriteRegister,
                        WriteData,
                        MemAddress,
                        MemData);
            end else if (MemRead) begin
               // ld
               $fdisplay(trace_file,"INUM: %8d PC: 0x%08x REG: %d VALUE: 0x%08x ADDR: 0x%08x",
                        (inst_count-1),
                        PC,
                        WriteRegister,
                        WriteData,
                        MemAddress);
            end else begin
               $fdisplay(trace_file,"INUM: %8d PC: 0x%08x REG: %d VALUE: 0x%08x",
                        (inst_count-1),
                        PC,
                        WriteRegister,
                        WriteData );
            end
         end else if (Halt) begin
            $fdisplay(sim_log_file, "SIMLOG:: Processor halted\n");
            $fdisplay(sim_log_file, "SIMLOG:: inst_count %d\n", inst_count);
            $fdisplay(trace_file, "INUM: %8d PC: 0x%08x",
                      (inst_count-1),
                      PC );

            $fclose(trace_file);
            $fclose(sim_log_file);
            
            $finish;
         end else begin // if (RegWrite)
            if (MemWrite) begin
               // st
               $fdisplay(trace_file,"INUM: %8d PC: 0x%08x ADDR: 0x%08x VALUE: 0x%08x",
                         (inst_count-1),
                        PC,
                        MemAddress,
                        MemData);
            end else begin
               // conditional branch or NOP
               // Need better checking in pipelined testbench
               inst_count = inst_count + 1;
               $fdisplay(trace_file, "INUM: %8d PC: 0x%08x",
                         (inst_count-1),
                         PC );
            end
         end 
      end
      
   end
   
   assign RegWrite = DUT.D.regfile.write;
   // Is memory being read, one bit signal (1 means yes, 0 means no)
   
   assign WriteRegister = DUT.D.regfile.writeregsel;
   // The name of the register being written to. (3 bit signal)

   assign WriteData = DUT.D.regfile.writedata;
   // Data being written to the register. (16 bits)
   
   assign MemRead =  DUT.mem_read;
   // Is memory being read, one bit signal (1 means yes, 0 means no)
   
   always #5 clk = ~clk; 
   
endmodule
