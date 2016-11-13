/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
//////////////////////////////////////
//
// Memory -- single cycle version
//
// written for CS/ECE 552, Spring '07
// Pratap Ramamurthy, 19 Mar 2006
//
// This is a byte-addressable,
// 16-bit wide, 64K-byte memory.
//
// All reads happen combinationally with zero delay.
// All writes occur on rising clock edge.
// Concurrent read and write not allowed.
//
// On reset, memory loads from file "loadfile_all.img".
// (You may change the name of the file in
// the $readmemh statement below.)
// File format:
//     @0
//     <hex data 0>
//     <hex data 1>
//     ...etc
//
// If input "createdump" is true on rising clock,
// contents of memory will be dumped to
// file "dumpfile", from location 0 up through
// the highest location modified by a write.
//
//
//////////////////////////////////////

module memory2c (data_out, data_in, addr, enable, wr, createdump, clk, rst);
   parameter mem_type = 0; 
   
   output  [31:0] data_out;
   input [31:0]   data_in;
   input [31:0]   addr;
   input          enable;
   input          wr;
   input          createdump;
   input          clk;
   input          rst;

   wire [31:0]    data_out;
   
   reg [7:0]      mem [0:65535];
   reg            loaded;
   reg [31:0] rd_addr; 
   //reg [31:0]     largest;

   integer        mcd;
   integer        i;


   assign         data_out = (enable & (~wr))? {mem[rd_addr],mem[rd_addr+8'h1], mem[rd_addr+8'h2], mem[rd_addr+8'h3]}: 0;
   
   initial begin
      loaded = 0;
      for (i = 0; i< 65536; i=i+1) begin
         mem[i] = 8'd0;
      end
   end

   always @(posedge clk) begin
      if (rst) begin
         // first init to 0, then load loadfile.img
         if (!loaded) begin
			if(mem_type) begin
				$readmemh("loadfile.img", mem);
			end
			else begin
			   for (i=0; i<=65535; i=i+1) begin
			      mem[i] = 0;
			   end
			end
            loaded = 1;
         end
		 rd_addr = 0; 
      end
      else begin
		rd_addr = addr;
         if (enable & wr) begin
	        mem[addr] = data_in[31:24];       // The actual write
	        mem[addr+1] = data_in[23:16];    // The actual write
			mem[addr+2] = data_in[15:8];    // The actual write
			mem[addr+3] = data_in[7:0];    // The actual write
         end
         if (createdump) begin
            mcd = $fopen("mem_dmp.dmp", "w");
            for (i=0; i<=65535; i=i+1) begin
               $fdisplay(mcd,"%8h %2h", i, mem[i]);
            end
            $fclose(mcd);
         end
      end
   end


endmodule  // memory2c
// DUMMY LINE FOR REV CONTROL :0:
