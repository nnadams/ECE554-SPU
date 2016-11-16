module dff (
	output reg q,
	input d,
	input clk,
	input rst
);

always @(posedge clk) begin
      if(rst) begin
		q <= 1'b0;
	  end
	  else begin
		q <= d;
	  end
end

endmodule
