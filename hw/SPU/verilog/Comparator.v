module Comparator (
   clk,
   rst,
   i_set,
   i_stringA, 
   i_stringB,
   i_NullNeverMatches,
   o_result,
   o_zerosA,
   o_zerosB,
   o_greater,
   o_done
);

   input clk, rst;
   input i_set, i_NullNeverMatches;
   input [127:0] i_stringA, i_stringB;
   
   output reg [15:0] o_result, o_zerosA, o_zerosB;
   output reg o_done, o_greater;

   wire [15:0] compare, zerosA, zerosB, greater;
   wire [127:0] bitsA, bitsB;

   always @(posedge clk, posedge rst) begin
      if (rst)
		o_greater <= 1'b0;
      else if (i_set)
		o_greater <= |greater;
   end
   
   always @(posedge clk, posedge rst) begin
      if (rst)
		o_result <= 16'h0000;
      else if (i_set)
		o_result <= compare;
   end

   always @(posedge clk, posedge rst) begin
      if (rst)
		o_zerosA <= 16'h0000;
      else if (i_set)
		o_zerosA <= ~zerosA;
   end

   always @(posedge clk, posedge rst) begin
      if (rst)
		o_zerosB <= 16'h0000;
      else if (i_set)
		o_zerosB <= ~zerosB;
   end

   always @(posedge clk, posedge rst) begin
      if (rst)
		o_done <= 1'b0;
      else if (i_set)
		o_done <= 1'b1;
      else
		o_done <= 1'b0;
   end

   assign bitsA[7:0] = i_stringA[7:0];
   assign bitsB[7:0] = i_stringB[7:0];
   assign zerosA[0] = |(i_stringA[7:0]);
   assign zerosB[0] = |(i_stringB[7:0]);
   assign compare[0] = ((i_NullNeverMatches && bitsB[7:0] == 8'h00) ? 1'b1 : |(bitsA[7:0] ^ bitsB[7:0]));
   assign greater[0] = (bitsA[7:0] < bitsB[7:0]);

   genvar index;
   generate 
      for (index = 1; index < 16; index = index + 1) begin : gen_cmpr
		assign bitsA[(8*(index+1)-1):(8*index)] = ( (bitsA[(8*(index)-1):(8*(index-1))] != 8'h0) ? i_stringA[(8*(index+1)-1):(8*index)] : 8'h00 );
		assign bitsB[(8*(index+1)-1):(8*index)] = ( (bitsB[(8*(index)-1):(8*(index-1))] != 8'h0) ? i_stringB[(8*(index+1)-1):(8*index)] : 8'h00 );
		assign zerosA[index] = |(bitsA[(8*(index+1)-1):(8*index)]);
		assign zerosB[index] = |(bitsB[(8*(index+1)-1):(8*index)]);
		assign compare[index] = ((i_NullNeverMatches && bitsB[(8*(index+1)-1):(8*index)] == 8'h00) ? 1'b1 : |(bitsA[(8*(index+1)-1):(8*index)] ^ bitsB[(8*(index+1)-1):(8*index)]));
        assign greater[index] = (bitsA[(8*(index+1)-1):(8*index)] < bitsB[(8*(index+1)-1):(8*index)]);
      end
   endgenerate

endmodule
