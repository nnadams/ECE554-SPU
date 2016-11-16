module pipeReg_if_id
  (
   input clk,
   input rst,
   input flush_if,
   input stall, 
   
   input [31:0] if_instruction,
   input if_HALT,
   input [31:0] if_PC_4,
   
   output [31:0] id_instruction,
   output id_HALT,
   output [31:0] id_PC_4
   );

   wire [31:0] if_instruction_in;
   assign if_instruction_in = flush_if ? 32'b000001xxxxxxxxxxxxxxxxxxxxxxxxxx : 
						      stall    ? id_instruction : if_instruction;
   
   wire [31:0] PC_4_in;
   assign PC_4_in = stall ? id_PC_4 : if_PC_4;
   
   wire halt_in;
   assign halt_in = flush_if ? 1'b0 :
					stall    ? id_HALT : if_HALT;
   
   dff instr_ff[31:0] (.d(if_instruction_in), .q(id_instruction), .clk(clk), .rst(rst));
   dff halt_ff (.d(halt_in), .q(id_HALT), .clk(clk), .rst(rst));
   dff PC_4_ff[31:0] (.d(PC_4_in), .q(id_PC_4), .clk(clk), .rst(rst));
   
endmodule
