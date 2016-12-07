module pipeReg_id_ex
  (
   input clk,
   input rst,
   input flush_id,
   
   input [31:0] id_reg_data_1,
   input [31:0] id_reg_data_2,
   input [3:0]  id_aluop,    
   input        id_invA, 
   input        id_invB,
   input        id_Cin, 
   input        id_sign,
   input        id_alusrc,
   input [31:0] id_imm_value,  
   input [3:0]  id_mem_write, 
   input [3:0]  id_mem_enable, 
   input        id_mem_read, 
   input [2:0]  id_write_data_sel,
   input [4:0]  id_write_reg_sel, 
   input        id_write_reg_en, 
   input        id_spu_en,
   input [3:0]  id_spu_op,
   /* Carried From FETCH */
   input [31:0] id_instruction,
   input [31:0] id_PC_4,
   input 		id_HALT,
   input stall,
   
   output [31:0] ex_reg_data_1,
   output [31:0] ex_reg_data_2,
   output [3:0]  ex_aluop,    
   output        ex_invA, 
   output        ex_invB,
   output        ex_Cin, 
   output        ex_sign,
   output        ex_alusrc,
   output [31:0] ex_imm_value,  
   output [3:0]  ex_mem_write, 
   output [3:0]  ex_mem_enable, 
   output        ex_mem_read, 
   output [2:0]  ex_write_data_sel,
   output [4:0]  ex_write_reg_sel, 
   output        ex_write_reg_en,
   output        ex_spu_en,
   output [3:0]  ex_spu_op,   
   /* Carried From FETCH */
   output [31:0] ex_instruction,
   output [31:0] ex_PC_4,
   output 		 ex_HALT
   );

   wire [31:0] id_instruction_in;
   wire id_write_reg_en_in;
   wire [3:0] id_mem_enable_in;
   wire [3:0] id_mem_write_in;
   wire halt_in; 
   wire spu_en; 
   assign id_instruction_in = flush_id ? 32'b000001xxxxxxxxxxxxxxxxxxxxxxxxxx : id_instruction;
   assign id_write_reg_en_in = flush_id ? 1'b0 : id_write_reg_en;
   assign id_mem_enable_in = flush_id ? 4'b0000 : id_mem_enable;
   assign id_mem_write_in = flush_id ? 4'b0000 : id_mem_write; 
   assign id_mem_read_in = flush_id ? 1'b0 : id_mem_read;
   assign halt_in = flush_id ? 1'b0 : id_HALT;
   assign spu_en = flush_id ? 1'b0 : id_spu_en;
   
   dff_en reg_data_1_ff [31:0] (.clk(clk), .rst(rst), .d(id_reg_data_1), .q(ex_reg_data_1), .en(~stall)); 
   dff_en reg_data_2_ff [31:0] (.clk(clk), .rst(rst), .d(id_reg_data_2), .q(ex_reg_data_2), .en(~stall)); 
   dff_en alu_op_ff [3:0]  (.clk(clk), .rst(rst), .d(id_aluop), .q(ex_aluop), .en(~stall)); 
   dff_en invA_ff(.clk(clk), .rst(rst), .d(id_invA), .q(ex_invA), .en(~stall)); 
   dff_en invB_ff(.clk(clk), .rst(rst), .d(id_invB), .q(ex_invB), .en(~stall)); 
   dff_en Cin_ff(.clk(clk), .rst(rst), .d(id_Cin), .q(ex_Cin), .en(~stall)); 
   dff_en sign_ff(.clk(clk), .rst(rst), .d(id_sign), .q(ex_sign), .en(~stall));
   dff_en alusrc_ff(.clk(clk), .rst(rst), .d(id_alusrc), .q(ex_alusrc), .en(~stall));    
   dff_en imm_value_ff [31:0] (.clk(clk), .rst(rst), .d(id_imm_value), .q(ex_imm_value), .en(~stall)); 
   dff_en mem_write_ff [3:0] (.clk(clk), .rst(rst), .d(id_mem_write_in), .q(ex_mem_write), .en(~stall)); 
   dff_en mem_enable_ff [3:0] (.clk(clk), .rst(rst), .d(id_mem_enable_in), .q(ex_mem_enable), .en(~stall)); 
   dff_en mem_read_ff(.clk(clk), .rst(rst), .d(id_mem_read_in), .q(ex_mem_read), .en(~stall)); 
   dff_en write_data_sel_ff [2:0] (.clk(clk), .rst(rst), .d(id_write_data_sel), .q(ex_write_data_sel), .en(~stall)); 
   dff_en write_reg_sel_ff [4:0] (.clk(clk), .rst(rst), .d(id_write_reg_sel), .q(ex_write_reg_sel), .en(~stall));
   dff_en write_reg_en_ff (.clk(clk), .rst(rst), .d(id_write_reg_en_in), .q(ex_write_reg_en), .en(~stall));
   dff_en instr_ff[31:0] (.d(id_instruction_in), .q(ex_instruction), .clk(clk), .rst(rst), .en(~stall));
   dff_en halt_ff (.d(halt_in), .q(ex_HALT), .clk(clk), .rst(rst), .en(~stall));
   dff_en PC_2_ff[31:0] (.d(id_PC_4), .q(ex_PC_4), .clk(clk), .rst(rst), .en(~stall));
   dff_en spu_en_ff (.d(spu_en), .q(ex_spu_en), .clk(clk), .rst(rst), .en(~stall));
   dff_en spu_op_ff [3:0] (.d(id_spu_op), .q(ex_spu_op), .clk(clk), .rst(rst), .en(~stall));
   endmodule
