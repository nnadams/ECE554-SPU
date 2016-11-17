module reg_32(
			  input clk,
			  input rst,
			  input [31:0] writeData,
			  input write,
			  output [31:0] data
);

wire [31:0]	newData;
   
assign newData = 
			rst   ?  32'h0000  :
		    write ?  writeData :
		    data;
   
dff regs[31:0] (.q(data), .d(newData), .rst(rst), .clk(clk));

endmodule

   
