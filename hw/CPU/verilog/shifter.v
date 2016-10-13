module shifter (In, Cnt, Op, Out);
   
   input [15:0] In;
   input [3:0]  Cnt;
   input [1:0]  Op;
   output [15:0] Out;

   /* Barrel Shifter. Instantiate one instance of each of the following shifters
    
      1 Bit shifter -> Sel connected to Cnt[0] 
      2 Bit shifter -> Sel connected to Cnt[1]
      4 Bit shifter -> Sel connected to Cnt[2]
      8 Bit shifter -> sel connected to Cnt[3]
    
    */
   
   wire [15:0] 	 out_s1;
   wire [15:0] 	 out_s2;
   wire [15:0] 	 out_s4;
   

   shft1 s1(.In(In), .Op(Op), .Sel(Cnt[0]), .Out(out_s1));
   shft2 s2(.In(out_s1), .Op(Op), .Sel(Cnt[1]), .Out(out_s2));
   shft4 s4(.In(out_s2), .Op(Op), .Sel(Cnt[2]), .Out(out_s4));
   shft8 s8(.In(out_s4), .Op(Op), .Sel(Cnt[3]), .Out(Out));
   
endmodule

