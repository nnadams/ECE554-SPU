module pipeReg_mem_wb
  (
   input clk,
   input rst,
   
   input [31:0] mem_mem_out,
   /* Carried From ALU */ 
   input [31:0] mem_alu_out,
   input 	    mem_Z,
   input        mem_N,
   input        mem_ofl,
   /* Carried From Decode */ 
   input [1:0]  mem_write_data_sel, 
   input [4:0]  mem_write_reg_sel,
   input        mem_write_reg_en,
   input [31:0] mem_reg_data_1, 
   input [31:0] mem_reg_data_2, 
   /* Carried From Fetch */ 
   input [31:0] mem_instruction,
   input [31:0] mem_PC_4,
   input        mem_HALT, 
   input stall,
   
   output [31:0] wb_mem_out,
   /* Carried From ALU */ 
   output [31:0] wb_alu_out,
   output 	     wb_Z,
   output        wb_N,
   output        wb_ofl,
   /* Carried From Decode */ 
   output [1:0]	 wb_write_data_sel,
   output [4:0]  wb_write_reg_sel, 
   output        wb_write_reg_en,
   output [31:0] wb_reg_data_1, 
   output [31:0] wb_reg_data_2, 
   /* Carried From Fetch */ 
   output [31:0] wb_instruction,
   output [31:0] wb_PC_4,
   output        wb_HALT
   );

   dff_en mem_out_ff [31:0] (.clk(clk), .rst(rst), .d(mem_mem_out), .q(wb_mem_out), .en(~stall));
   dff_en alu_out_ff [31:0] (.clk(clk), .rst(rst), .d(mem_alu_out), .q(wb_alu_out), .en(~stall));
   dff_en z_ff (.clk(clk), .rst(rst), .d(mem_Z), .q(wb_Z), .en(~stall));
   dff_en n_ff (.clk(clk), .rst(rst), .d(mem_N), .q(wb_N), .en(~stall));
   dff_en ofl_ff (.clk(clk), .rst(rst), .d(mem_ofl), .q(wb_ofl), .en(~stall));
   dff_en write_data_sel_ff [1:0] (.clk(clk), .rst(rst), .d(mem_write_data_sel), .q(wb_write_data_sel), .en(~stall)); 
   dff_en write_reg_sel_ff [4:0] (.clk(clk), .rst(rst), .d(mem_write_reg_sel), .q(wb_write_reg_sel), .en(~stall));
   dff_en write_reg_en_ff (.clk(clk), .rst(rst), .d(mem_write_reg_en), .q(wb_write_reg_en), .en(~stall));
   dff_en reg_data_1_ff [31:0] (.clk(clk), .rst(rst), .d(mem_reg_data_1), .q(wb_reg_data_1), .en(~stall)); 
   dff_en reg_data_2_ff [31:0] (.clk(clk), .rst(rst), .d(mem_reg_data_2), .q(wb_reg_data_2), .en(~stall));
   dff_en instr_ff[31:0] (.d(mem_instruction), .q(wb_instruction), .clk(clk), .rst(rst), .en(~stall));
   dff_en PC_4_ff[31:0] (.d(mem_PC_4), .q(wb_PC_4), .clk(clk), .rst(rst), .en(~stall));
   dff_en halt_ff (.clk(clk), .rst(rst), .d(mem_HALT), .q(wb_HALT), .en(~stall));
   
 endmodule
