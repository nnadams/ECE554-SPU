// SystemVerilog, I miss you, my friend.
`define CLOG2(x) \
   (x <= 2) ? 1 : \
   (x <= 4) ? 2 : \
   (x <= 8) ? 3 : \
   (x <= 16) ? 4 : \
   (x <= 32) ? 5 : \
   (x <= 64) ? 6 : \
   (x <= 128) ? 7 : \
   -1

module ZeroCounter (
  in,
  out
);

  parameter WIDTH = 16;

  input [(WIDTH-1):0] in; 
  output reg [(`CLOG2(WIDTH)):0] out;

  integer i;
  always @(*) begin
    out = 0; // default, for all 0s
    for (i = 0; i <= (WIDTH-1); i = i+1)
        out = out + ~in[i];
  end
endmodule
