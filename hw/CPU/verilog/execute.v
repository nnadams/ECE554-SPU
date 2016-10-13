module execute(
	       input [15:0] reg_data_1,
	       input [15:0] reg_data_2,
	       input [15:0] imm_value,
	       input alusrc,
	       input invA,
	       input invB,
	       input sign,
	       input Cin,
	       input [3:0] aluop,
	       output [15:0] Out,
	       output Z,
	       output ofl,
	       output N
	       );

   wire [15:0] 	      alusrc1;
   wire [15:0] 	      alusrc2;
   
   assign alusrc1 = reg_data_1;
   assign alusrc2 = (alusrc == 1'b0) ? reg_data_2 : imm_value;
   
   alu alu_unit (
		 /*Inputs*/
		 .A(alusrc1),
		 .B(alusrc2), 
		 .Cin(Cin),
		 .Op(aluop), 
		 .invA(invA), 
		 .invB(invB),
		 .sign(sign), 
		 /*Outputs*/
		 .Out(Out),
		 .Ofl(ofl),
		 .Z(Z), 
		 .N(N)
		 );
endmodule 
