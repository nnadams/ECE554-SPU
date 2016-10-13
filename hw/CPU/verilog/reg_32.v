module reg_16(
			  input clk,
			  input rst,
			  input [15:0] writeData,
			  input write,
			  output [15:0] data
);

   wire [15:0]	newData;
   
   assign newData = rst   ?  16'h0000  :
		    write ?  writeData :
		    data;
   
   dff regs[15:0] (.q(data), .d(newData), .rst(rst), .clk(clk));

endmodule

   
