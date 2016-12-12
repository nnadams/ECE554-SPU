module UpCounter (
  clk,
  rst,
  i_en,
  i_clear,
  o_value,
  o_done
);
    
	parameter LIMIT	  = 16'hFFFF;
	parameter MAXBITS = 16;
    
	input clk, rst, i_en, i_clear;
    
	output reg [MAXBITS-1:0] o_value;
	output o_done;
    
	assign o_done = (o_value >= LIMIT);
    
	always @(posedge clk or posedge rst) begin
    		if (rst)
        		o_value <= {(MAXBITS){1'b0}};
    		else if (i_clear)
        		o_value <= {(MAXBITS){1'b0}};
    		else if (i_en)
        		o_value <= o_value + 1'b1;
	end
endmodule
