module pipeReg_ex_mem
  (
   input clk,
   input rst,
   input flush_ex,
   
   /* Execute Outputs */
   input [31:0] ex_alu_out,
   input ex_Z, 
   input ex_N,
   input ex_ofl, 
   /* Carried From Decode */
   input [31:0] ex_reg_data_1,
   input [31:0] ex_reg_data_2,  
   input        ex_mem_write, 
   input        ex_mem_enable, 
   input        ex_mem_read, 
   input [1:0]  ex_write_data_sel,
   input [4:0]  ex_write_reg_sel,
   input        ex_write_reg_en,
   /* Carried From FETCH */
   input [31:0] ex_instruction,
   input [31:0] ex_PC_4,
   input 		ex_HALT,
   input stall,
   
   output [31:0] mem_alu_out,
   output mem_Z, 
   output mem_N,
   output mem_ofl, 
   output [31:0] mem_reg_data_1,
   output [31:0] mem_reg_data_2,  
   output        mem_mem_write, 
   output        mem_mem_enable, 
   output        mem_mem_read, 
   output [1:0]  mem_write_data_sel,
   output [4:0]  mem_write_reg_sel,
   output        mem_write_reg_en,
   output [31:0] mem_instruction,
   output [31:0] mem_PC_4,
   output 		mem_HALT
   );

   wire [31:0] ex_instruction_in;
   wire ex_write_reg_en_in;
   wire ex_mem_enable_in;
   wire halt_in; 
   
   assign ex_instruction_in = flush_ex ? 32'b00001xxxxxxxxxxxxxxxxxxxxxxxxxxx : ex_instruction;
   assign ex_write_reg_en_in = flush_ex ? 1'b0 : ex_write_reg_en;
   assign ex_mem_enable_in = flush_ex ? 1'b0 : ex_mem_enable;
   assign ex_mem_write_in = flush_ex ? 1'b0 : ex_mem_write; 
   assign ex_mem_read_in = flush_ex ? 1'b0 : ex_mem_read;
   assign halt_in = flush_ex ? 1'b0 : ex_HALT;
   
   dff_en alu_out_ff [31:0] (.clk(clk), .rst(rst), .d(ex_alu_out), .q(mem_alu_out), .en(~stall));
   dff_en z_ff (.clk(clk), .rst(rst), .d(ex_Z), .q(mem_Z), .en(~stall));
   dff_en n_ff (.clk(clk), .rst(rst), .d(ex_N), .q(mem_N), .en(~stall));
   dff_en ofl_ff (.clk(clk), .rst(rst), .d(ex_ofl), .q(mem_ofl), .en(~stall)); 
   dff_en reg_data_1_ff [31:0] (.clk(clk), .rst(rst), .d(ex_reg_data_1), .q(mem_reg_data_1), .en(~stall)); 
   dff_en reg_data_2_ff [31:0] (.clk(clk), .rst(rst), .d(ex_reg_data_2), .q(mem_reg_data_2), .en(~stall)); 
   dff_en mem_write_ff(.clk(clk), .rst(rst), .d(ex_mem_write_in), .q(mem_mem_write), .en(~stall)); 
   dff_en mem_enable_ff(.clk(clk), .rst(rst), .d(ex_mem_enable_in), .q(mem_mem_enable), .en(~stall)); 
   dff_en mem_read_ff(.clk(clk), .rst(rst), .d(ex_mem_read_in), .q(mem_mem_read), .en(~stall)); 
   dff_en write_data_sel_ff [1:0] (.clk(clk), .rst(rst), .d(ex_write_data_sel), .q(mem_write_data_sel), .en(~stall)); 
   dff_en write_reg_sel_ff [4:0] (.clk(clk), .rst(rst), .d(ex_write_reg_sel), .q(mem_write_reg_sel), .en(~stall));
   dff_en write_reg_en_ff (.clk(clk), .rst(rst), .d(ex_write_reg_en_in), .q(mem_write_reg_en), .en(~stall));
   dff_en instr_ff[31:0] (.d(ex_instruction_in), .q(mem_instruction), .clk(clk), .rst(rst), .en(~stall));
   dff_en halt_ff (.d(halt_in), .q(mem_HALT), .clk(clk), .rst(rst), .en(~stall));
   dff_en PC_4_ff[31:0] (.d(ex_PC_4), .q(mem_PC_4), .clk(clk), .rst(rst), .en(~stall));
   
 endmodule
