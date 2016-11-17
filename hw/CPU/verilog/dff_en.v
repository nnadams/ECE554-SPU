module dff_en(
	      input clk,
	      input rst,
	      input d,
	      input en,
	      output q
	      );

   wire 	     d_in = en ? d : q;

   dff dff_w_en (.d(d_in), .q(q), .clk(clk), .rst(rst));
   
endmodule 
