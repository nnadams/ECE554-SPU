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

   wire        Halt;         /* Halt executed and in Memory or writeback stage */
        
   integer     inst_count;
   integer     trace_file;
   integer     sim_log_file;
     
    reg clk; 
    reg rst; 
    wire err; 
   proc DUT(.clk(clk), .rst(rst), .err(err));
  

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

   assign PC = DUT.F.ifetch.PC_curr;
   assign Inst = DUT.instruction;
   
   assign RegWrite = DUT.D.regfile.write;
   // Is memory being read, one bit signal (1 means yes, 0 means no)
   
   assign WriteRegister = DUT.D.regfile.writeregsel;
   // The name of the register being written to. (3 bit signal)

   assign WriteData = DUT.D.regfile.writedata;
   // Data being written to the register. (16 bits)
   
   assign MemRead =  DUT.mem_read;
   // Is memory being read, one bit signal (1 means yes, 0 means no)
   
   assign MemWrite = (DUT.mem_enable & DUT.mem_write);
   // Is memory being written to (1 bit signal)
   
   assign MemAddress = DUT.alu_out;
   // Address to access memory with (for both reads and writes to memory, 16 bits)
   
   assign MemData = DUT.reg_data_2;
   // Data to be written to memory for memory writes (16 bits)
   
   assign Halt = DUT.HALT;
   // Is processor halted (1 bit signal)

   always #5 clk = ~clk; 
   
endmodule
