module ofl_detect(
		  input  Signed,
		  input  Cout,
		  input  A_Sign,
		  input  B_Sign,
		  input  Out_Sign,
		  output Ofl
);
  
reg overflow; 

always @(*) 
begin
   casex({Signed, Cout, A_Sign, B_Sign, Out_Sign})
     // UNSIGNED DETECTION DOESNT CARE ABOUT SIGNS, Only cout
     5'b01xxx:
       overflow = 1'b1;
     // FOR SIGNED, ONLY CARE IF SIGNS ARE SAME, CHECK IF OUTPUTTED SIGN DIFFERENT
     5'b1x001:
       overflow = 1'b1;
     5'b1x110:
       overflow = 1'b1;
     default:
       overflow = 1'b0;   
   endcase // case ({Signed, Cout, A_Sign, B_Sign})
end

assign Ofl = overflow; 

endmodule // ofl_detect
