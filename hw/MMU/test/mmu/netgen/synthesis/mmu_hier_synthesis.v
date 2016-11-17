////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.20131013
//  \   \         Application: netgen
//  /   /         Filename: mmu_hier_synthesis.v
// /___/   /\     Timestamp: Thu Oct 27 18:32:42 2016
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -insert_glbl true -w -dir netgen/synthesis -ofmt verilog -sim mmu_hier.ngc mmu_hier_synthesis.v 
// Device	: xc5vlx110t-1-ff1136
// Input file	: mmu_hier.ngc
// Output file	: \\userspace.cae.wisc.edu\people\b\barry-lenoch\Documents\School\Classes\5th_year\Fall_2016\ece554\project\ECE554-SPU\hw\MMU\test\mmu\netgen\synthesis\mmu_hier_synthesis.v
// # of Modules	: 1
// Design Name	: mmu_hier
// Xilinx        : C:\ProgramData\App-V\DAA02E26-5322-4947-BF0F-062031F30E14\68790BDD-0F39-406E-A1BC-DAF286566E4F\Root\14.7\ISE_DS\ISE\
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module mmu_hier (
  clk, rst_n, spart_databus, spu_read_data, instruction, vga_data_1, vga_data_2, vga_data_3, cpu_read_data, cpu_wdata, PC, spu_res_data, spu_read_addr
, spu_res_addr, cpu_addr
)/* synthesis syn_black_box syn_noprune=1 */;
  input clk;
  input rst_n;
  inout [7 : 0] spart_databus;
  output [127 : 0] spu_read_data;
  output [31 : 0] instruction;
  output [31 : 0] vga_data_1;
  output [31 : 0] vga_data_2;
  output [31 : 0] vga_data_3;
  output [31 : 0] cpu_read_data;
  input [31 : 0] cpu_wdata;
  input [31 : 0] PC;
  input [31 : 0] spu_res_data;
  input [31 : 0] spu_read_addr;
  input [3 : 0] spu_res_addr;
  input [31 : 0] cpu_addr;
  
  // synthesis translate_off
  
  wire N0;
  wire N1;
  wire PC_0_IBUF_34;
  wire PC_10_IBUF_35;
  wire PC_11_IBUF_36;
  wire PC_12_IBUF_37;
  wire PC_13_IBUF_38;
  wire PC_14_IBUF_39;
  wire PC_15_IBUF_40;
  wire PC_16_IBUF_41;
  wire PC_17_IBUF_42;
  wire PC_18_IBUF_43;
  wire PC_19_IBUF_44;
  wire PC_1_IBUF_45;
  wire PC_20_IBUF_46;
  wire PC_21_IBUF_47;
  wire PC_22_IBUF_48;
  wire PC_23_IBUF_49;
  wire PC_24_IBUF_50;
  wire PC_25_IBUF_51;
  wire PC_26_IBUF_52;
  wire PC_27_IBUF_53;
  wire PC_28_IBUF_54;
  wire PC_29_IBUF_55;
  wire PC_2_IBUF_56;
  wire PC_30_IBUF_57;
  wire PC_31_IBUF_58;
  wire PC_3_IBUF_59;
  wire PC_4_IBUF_60;
  wire PC_5_IBUF_61;
  wire PC_6_IBUF_62;
  wire PC_7_IBUF_63;
  wire PC_8_IBUF_64;
  wire PC_9_IBUF_65;
  wire clk_BUFGP_67;
  wire cpu_wdata_0_IBUF_100;
  wire cpu_wdata_10_IBUF_101;
  wire cpu_wdata_11_IBUF_102;
  wire cpu_wdata_12_IBUF_103;
  wire cpu_wdata_13_IBUF_104;
  wire cpu_wdata_14_IBUF_105;
  wire cpu_wdata_15_IBUF_106;
  wire cpu_wdata_16_IBUF_107;
  wire cpu_wdata_17_IBUF_108;
  wire cpu_wdata_18_IBUF_109;
  wire cpu_wdata_19_IBUF_110;
  wire cpu_wdata_1_IBUF_111;
  wire cpu_wdata_20_IBUF_112;
  wire cpu_wdata_21_IBUF_113;
  wire cpu_wdata_22_IBUF_114;
  wire cpu_wdata_23_IBUF_115;
  wire cpu_wdata_24_IBUF_116;
  wire cpu_wdata_25_IBUF_117;
  wire cpu_wdata_26_IBUF_118;
  wire cpu_wdata_27_IBUF_119;
  wire cpu_wdata_28_IBUF_120;
  wire cpu_wdata_29_IBUF_121;
  wire cpu_wdata_2_IBUF_122;
  wire cpu_wdata_30_IBUF_123;
  wire cpu_wdata_31_IBUF_124;
  wire cpu_wdata_3_IBUF_125;
  wire cpu_wdata_4_IBUF_126;
  wire cpu_wdata_5_IBUF_127;
  wire cpu_wdata_6_IBUF_128;
  wire cpu_wdata_7_IBUF_129;
  wire cpu_wdata_8_IBUF_130;
  wire cpu_wdata_9_IBUF_131;
  wire instruction_0_OBUF_164;
  wire instruction_10_OBUF_165;
  wire instruction_11_OBUF_166;
  wire instruction_12_OBUF_167;
  wire instruction_13_OBUF_168;
  wire instruction_14_OBUF_169;
  wire instruction_15_OBUF_170;
  wire instruction_16_OBUF_171;
  wire instruction_17_OBUF_172;
  wire instruction_18_OBUF_173;
  wire instruction_19_OBUF_174;
  wire instruction_1_OBUF_175;
  wire instruction_20_OBUF_176;
  wire instruction_21_OBUF_177;
  wire instruction_22_OBUF_178;
  wire instruction_23_OBUF_179;
  wire instruction_24_OBUF_180;
  wire instruction_25_OBUF_181;
  wire instruction_26_OBUF_182;
  wire instruction_27_OBUF_183;
  wire instruction_28_OBUF_184;
  wire instruction_29_OBUF_185;
  wire instruction_2_OBUF_186;
  wire instruction_30_OBUF_187;
  wire instruction_31_OBUF_188;
  wire instruction_3_OBUF_189;
  wire instruction_4_OBUF_190;
  wire instruction_5_OBUF_191;
  wire instruction_6_OBUF_192;
  wire instruction_7_OBUF_193;
  wire instruction_8_OBUF_194;
  wire instruction_9_OBUF_195;
  wire rst_n_IBUF_197;
  wire spu_reg_0_0_198;
  wire spu_reg_0_1_199;
  wire spu_reg_0_10_200;
  wire spu_reg_0_11_201;
  wire spu_reg_0_12_202;
  wire spu_reg_0_13_203;
  wire spu_reg_0_14_204;
  wire spu_reg_0_15_205;
  wire spu_reg_0_16_206;
  wire spu_reg_0_17_207;
  wire spu_reg_0_18_208;
  wire spu_reg_0_19_209;
  wire spu_reg_0_2_210;
  wire spu_reg_0_20_211;
  wire spu_reg_0_21_212;
  wire spu_reg_0_22_213;
  wire spu_reg_0_23_214;
  wire spu_reg_0_24_215;
  wire spu_reg_0_25_216;
  wire spu_reg_0_26_217;
  wire spu_reg_0_27_218;
  wire spu_reg_0_28_219;
  wire spu_reg_0_29_220;
  wire spu_reg_0_3_221;
  wire spu_reg_0_30_222;
  wire spu_reg_0_31_223;
  wire spu_reg_0_4_224;
  wire spu_reg_0_5_225;
  wire spu_reg_0_6_226;
  wire spu_reg_0_7_227;
  wire spu_reg_0_8_228;
  wire spu_reg_0_9_229;
  wire spu_reg_0_and0000;
  wire spu_reg_1_0_231;
  wire spu_reg_1_1_232;
  wire spu_reg_1_10_233;
  wire spu_reg_1_11_234;
  wire spu_reg_1_12_235;
  wire spu_reg_1_13_236;
  wire spu_reg_1_14_237;
  wire spu_reg_1_15_238;
  wire spu_reg_1_16_239;
  wire spu_reg_1_17_240;
  wire spu_reg_1_18_241;
  wire spu_reg_1_19_242;
  wire spu_reg_1_2_243;
  wire spu_reg_1_20_244;
  wire spu_reg_1_21_245;
  wire spu_reg_1_22_246;
  wire spu_reg_1_23_247;
  wire spu_reg_1_24_248;
  wire spu_reg_1_25_249;
  wire spu_reg_1_26_250;
  wire spu_reg_1_27_251;
  wire spu_reg_1_28_252;
  wire spu_reg_1_29_253;
  wire spu_reg_1_3_254;
  wire spu_reg_1_30_255;
  wire spu_reg_1_31_256;
  wire spu_reg_1_4_257;
  wire spu_reg_1_5_258;
  wire spu_reg_1_6_259;
  wire spu_reg_1_7_260;
  wire spu_reg_1_8_261;
  wire spu_reg_1_9_262;
  wire spu_reg_1_and0000;
  wire spu_reg_2_0_264;
  wire spu_reg_2_1_265;
  wire spu_reg_2_10_266;
  wire spu_reg_2_11_267;
  wire spu_reg_2_12_268;
  wire spu_reg_2_13_269;
  wire spu_reg_2_14_270;
  wire spu_reg_2_15_271;
  wire spu_reg_2_16_272;
  wire spu_reg_2_17_273;
  wire spu_reg_2_18_274;
  wire spu_reg_2_19_275;
  wire spu_reg_2_2_276;
  wire spu_reg_2_20_277;
  wire spu_reg_2_21_278;
  wire spu_reg_2_22_279;
  wire spu_reg_2_23_280;
  wire spu_reg_2_24_281;
  wire spu_reg_2_25_282;
  wire spu_reg_2_26_283;
  wire spu_reg_2_27_284;
  wire spu_reg_2_28_285;
  wire spu_reg_2_29_286;
  wire spu_reg_2_3_287;
  wire spu_reg_2_30_288;
  wire spu_reg_2_31_289;
  wire spu_reg_2_4_290;
  wire spu_reg_2_5_291;
  wire spu_reg_2_6_292;
  wire spu_reg_2_7_293;
  wire spu_reg_2_8_294;
  wire spu_reg_2_9_295;
  wire spu_reg_2_and0000;
  wire spu_res_addr_0_IBUF_299;
  wire spu_res_addr_1_IBUF_300;
  wire spu_res_data_0_IBUF_333;
  wire spu_res_data_10_IBUF_334;
  wire spu_res_data_11_IBUF_335;
  wire spu_res_data_12_IBUF_336;
  wire spu_res_data_13_IBUF_337;
  wire spu_res_data_14_IBUF_338;
  wire spu_res_data_15_IBUF_339;
  wire spu_res_data_16_IBUF_340;
  wire spu_res_data_17_IBUF_341;
  wire spu_res_data_18_IBUF_342;
  wire spu_res_data_19_IBUF_343;
  wire spu_res_data_1_IBUF_344;
  wire spu_res_data_20_IBUF_345;
  wire spu_res_data_21_IBUF_346;
  wire spu_res_data_22_IBUF_347;
  wire spu_res_data_23_IBUF_348;
  wire spu_res_data_24_IBUF_349;
  wire spu_res_data_25_IBUF_350;
  wire spu_res_data_26_IBUF_351;
  wire spu_res_data_27_IBUF_352;
  wire spu_res_data_28_IBUF_353;
  wire spu_res_data_29_IBUF_354;
  wire spu_res_data_2_IBUF_355;
  wire spu_res_data_30_IBUF_356;
  wire spu_res_data_31_IBUF_357;
  wire spu_res_data_3_IBUF_358;
  wire spu_res_data_4_IBUF_359;
  wire spu_res_data_5_IBUF_360;
  wire spu_res_data_6_IBUF_361;
  wire spu_res_data_7_IBUF_362;
  wire spu_res_data_8_IBUF_363;
  wire spu_res_data_9_IBUF_364;
  wire \NLW_data_mem_douta<31>_UNCONNECTED ;
  wire \NLW_data_mem_douta<30>_UNCONNECTED ;
  wire \NLW_data_mem_douta<29>_UNCONNECTED ;
  wire \NLW_data_mem_douta<28>_UNCONNECTED ;
  wire \NLW_data_mem_douta<27>_UNCONNECTED ;
  wire \NLW_data_mem_douta<26>_UNCONNECTED ;
  wire \NLW_data_mem_douta<25>_UNCONNECTED ;
  wire \NLW_data_mem_douta<24>_UNCONNECTED ;
  wire \NLW_data_mem_douta<23>_UNCONNECTED ;
  wire \NLW_data_mem_douta<22>_UNCONNECTED ;
  wire \NLW_data_mem_douta<21>_UNCONNECTED ;
  wire \NLW_data_mem_douta<20>_UNCONNECTED ;
  wire \NLW_data_mem_douta<19>_UNCONNECTED ;
  wire \NLW_data_mem_douta<18>_UNCONNECTED ;
  wire \NLW_data_mem_douta<17>_UNCONNECTED ;
  wire \NLW_data_mem_douta<16>_UNCONNECTED ;
  wire \NLW_data_mem_douta<15>_UNCONNECTED ;
  wire \NLW_data_mem_douta<14>_UNCONNECTED ;
  wire \NLW_data_mem_douta<13>_UNCONNECTED ;
  wire \NLW_data_mem_douta<12>_UNCONNECTED ;
  wire \NLW_data_mem_douta<11>_UNCONNECTED ;
  wire \NLW_data_mem_douta<10>_UNCONNECTED ;
  wire \NLW_data_mem_douta<9>_UNCONNECTED ;
  wire \NLW_data_mem_douta<8>_UNCONNECTED ;
  wire \NLW_data_mem_douta<7>_UNCONNECTED ;
  wire \NLW_data_mem_douta<6>_UNCONNECTED ;
  wire \NLW_data_mem_douta<5>_UNCONNECTED ;
  wire \NLW_data_mem_douta<4>_UNCONNECTED ;
  wire \NLW_data_mem_douta<3>_UNCONNECTED ;
  wire \NLW_data_mem_douta<2>_UNCONNECTED ;
  wire \NLW_data_mem_douta<1>_UNCONNECTED ;
  wire \NLW_data_mem_douta<0>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<127>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<126>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<125>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<124>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<123>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<122>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<121>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<120>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<119>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<118>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<117>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<116>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<115>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<114>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<113>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<112>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<111>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<110>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<109>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<108>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<107>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<106>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<105>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<104>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<103>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<102>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<101>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<100>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<99>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<98>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<97>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<96>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<95>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<94>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<93>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<92>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<91>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<90>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<89>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<88>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<87>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<86>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<85>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<84>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<83>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<82>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<81>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<80>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<79>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<78>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<77>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<76>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<75>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<74>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<73>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<72>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<71>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<70>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<69>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<68>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<67>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<66>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<65>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<64>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<63>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<62>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<61>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<60>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<59>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<58>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<57>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<56>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<55>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<54>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<53>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<52>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<51>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<50>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<49>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<48>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<47>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<46>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<45>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<44>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<43>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<42>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<41>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<40>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<39>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<38>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<37>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<36>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<35>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<34>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<33>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<32>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<31>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<30>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<29>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<28>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<27>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<26>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<25>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<24>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<23>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<22>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<21>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<20>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<19>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<18>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<17>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<16>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<15>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<14>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<13>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<12>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<11>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<10>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<9>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<8>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<7>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<6>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<5>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<4>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<3>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<2>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<1>_UNCONNECTED ;
  wire \NLW_data_mem_doutb<0>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<31>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<30>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<29>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<28>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<27>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<26>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<25>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<24>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<23>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<22>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<21>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<20>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<19>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<18>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<17>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<16>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<15>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<14>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<13>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<12>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<11>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<10>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<9>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<8>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<7>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<6>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<5>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<4>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<3>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<2>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<1>_UNCONNECTED ;
  wire \NLW_inst_mem_doutb<0>_UNCONNECTED ;
  GND   XST_GND (
    .G(N0)
  );
  VCC   XST_VCC (
    .P(N1)
  );
  FDE   spu_reg_2_0 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_0_IBUF_333),
    .Q(spu_reg_2_0_264)
  );
  FDE   spu_reg_2_1 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_1_IBUF_344),
    .Q(spu_reg_2_1_265)
  );
  FDE   spu_reg_2_2 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_2_IBUF_355),
    .Q(spu_reg_2_2_276)
  );
  FDE   spu_reg_2_3 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_3_IBUF_358),
    .Q(spu_reg_2_3_287)
  );
  FDE   spu_reg_2_4 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_4_IBUF_359),
    .Q(spu_reg_2_4_290)
  );
  FDE   spu_reg_2_5 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_5_IBUF_360),
    .Q(spu_reg_2_5_291)
  );
  FDE   spu_reg_2_6 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_6_IBUF_361),
    .Q(spu_reg_2_6_292)
  );
  FDE   spu_reg_2_7 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_7_IBUF_362),
    .Q(spu_reg_2_7_293)
  );
  FDE   spu_reg_2_8 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_8_IBUF_363),
    .Q(spu_reg_2_8_294)
  );
  FDE   spu_reg_2_9 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_9_IBUF_364),
    .Q(spu_reg_2_9_295)
  );
  FDE   spu_reg_2_10 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_10_IBUF_334),
    .Q(spu_reg_2_10_266)
  );
  FDE   spu_reg_2_11 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_11_IBUF_335),
    .Q(spu_reg_2_11_267)
  );
  FDE   spu_reg_2_12 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_12_IBUF_336),
    .Q(spu_reg_2_12_268)
  );
  FDE   spu_reg_2_13 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_13_IBUF_337),
    .Q(spu_reg_2_13_269)
  );
  FDE   spu_reg_2_14 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_14_IBUF_338),
    .Q(spu_reg_2_14_270)
  );
  FDE   spu_reg_2_15 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_15_IBUF_339),
    .Q(spu_reg_2_15_271)
  );
  FDE   spu_reg_2_16 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_16_IBUF_340),
    .Q(spu_reg_2_16_272)
  );
  FDE   spu_reg_2_17 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_17_IBUF_341),
    .Q(spu_reg_2_17_273)
  );
  FDE   spu_reg_2_18 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_18_IBUF_342),
    .Q(spu_reg_2_18_274)
  );
  FDE   spu_reg_2_19 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_19_IBUF_343),
    .Q(spu_reg_2_19_275)
  );
  FDE   spu_reg_2_20 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_20_IBUF_345),
    .Q(spu_reg_2_20_277)
  );
  FDE   spu_reg_2_21 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_21_IBUF_346),
    .Q(spu_reg_2_21_278)
  );
  FDE   spu_reg_2_22 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_22_IBUF_347),
    .Q(spu_reg_2_22_279)
  );
  FDE   spu_reg_2_23 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_23_IBUF_348),
    .Q(spu_reg_2_23_280)
  );
  FDE   spu_reg_2_24 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_24_IBUF_349),
    .Q(spu_reg_2_24_281)
  );
  FDE   spu_reg_2_25 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_25_IBUF_350),
    .Q(spu_reg_2_25_282)
  );
  FDE   spu_reg_2_26 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_26_IBUF_351),
    .Q(spu_reg_2_26_283)
  );
  FDE   spu_reg_2_27 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_27_IBUF_352),
    .Q(spu_reg_2_27_284)
  );
  FDE   spu_reg_2_28 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_28_IBUF_353),
    .Q(spu_reg_2_28_285)
  );
  FDE   spu_reg_2_29 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_29_IBUF_354),
    .Q(spu_reg_2_29_286)
  );
  FDE   spu_reg_2_30 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_30_IBUF_356),
    .Q(spu_reg_2_30_288)
  );
  FDE   spu_reg_2_31 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_2_and0000),
    .D(spu_res_data_31_IBUF_357),
    .Q(spu_reg_2_31_289)
  );
  FDE   spu_reg_0_0 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_0_IBUF_333),
    .Q(spu_reg_0_0_198)
  );
  FDE   spu_reg_0_1 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_1_IBUF_344),
    .Q(spu_reg_0_1_199)
  );
  FDE   spu_reg_0_2 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_2_IBUF_355),
    .Q(spu_reg_0_2_210)
  );
  FDE   spu_reg_0_3 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_3_IBUF_358),
    .Q(spu_reg_0_3_221)
  );
  FDE   spu_reg_0_4 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_4_IBUF_359),
    .Q(spu_reg_0_4_224)
  );
  FDE   spu_reg_0_5 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_5_IBUF_360),
    .Q(spu_reg_0_5_225)
  );
  FDE   spu_reg_0_6 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_6_IBUF_361),
    .Q(spu_reg_0_6_226)
  );
  FDE   spu_reg_0_7 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_7_IBUF_362),
    .Q(spu_reg_0_7_227)
  );
  FDE   spu_reg_0_8 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_8_IBUF_363),
    .Q(spu_reg_0_8_228)
  );
  FDE   spu_reg_0_9 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_9_IBUF_364),
    .Q(spu_reg_0_9_229)
  );
  FDE   spu_reg_0_10 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_10_IBUF_334),
    .Q(spu_reg_0_10_200)
  );
  FDE   spu_reg_0_11 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_11_IBUF_335),
    .Q(spu_reg_0_11_201)
  );
  FDE   spu_reg_0_12 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_12_IBUF_336),
    .Q(spu_reg_0_12_202)
  );
  FDE   spu_reg_0_13 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_13_IBUF_337),
    .Q(spu_reg_0_13_203)
  );
  FDE   spu_reg_0_14 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_14_IBUF_338),
    .Q(spu_reg_0_14_204)
  );
  FDE   spu_reg_0_15 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_15_IBUF_339),
    .Q(spu_reg_0_15_205)
  );
  FDE   spu_reg_0_16 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_16_IBUF_340),
    .Q(spu_reg_0_16_206)
  );
  FDE   spu_reg_0_17 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_17_IBUF_341),
    .Q(spu_reg_0_17_207)
  );
  FDE   spu_reg_0_18 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_18_IBUF_342),
    .Q(spu_reg_0_18_208)
  );
  FDE   spu_reg_0_19 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_19_IBUF_343),
    .Q(spu_reg_0_19_209)
  );
  FDE   spu_reg_0_20 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_20_IBUF_345),
    .Q(spu_reg_0_20_211)
  );
  FDE   spu_reg_0_21 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_21_IBUF_346),
    .Q(spu_reg_0_21_212)
  );
  FDE   spu_reg_0_22 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_22_IBUF_347),
    .Q(spu_reg_0_22_213)
  );
  FDE   spu_reg_0_23 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_23_IBUF_348),
    .Q(spu_reg_0_23_214)
  );
  FDE   spu_reg_0_24 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_24_IBUF_349),
    .Q(spu_reg_0_24_215)
  );
  FDE   spu_reg_0_25 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_25_IBUF_350),
    .Q(spu_reg_0_25_216)
  );
  FDE   spu_reg_0_26 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_26_IBUF_351),
    .Q(spu_reg_0_26_217)
  );
  FDE   spu_reg_0_27 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_27_IBUF_352),
    .Q(spu_reg_0_27_218)
  );
  FDE   spu_reg_0_28 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_28_IBUF_353),
    .Q(spu_reg_0_28_219)
  );
  FDE   spu_reg_0_29 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_29_IBUF_354),
    .Q(spu_reg_0_29_220)
  );
  FDE   spu_reg_0_30 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_30_IBUF_356),
    .Q(spu_reg_0_30_222)
  );
  FDE   spu_reg_0_31 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_0_and0000),
    .D(spu_res_data_31_IBUF_357),
    .Q(spu_reg_0_31_223)
  );
  FDE   spu_reg_1_0 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_0_IBUF_333),
    .Q(spu_reg_1_0_231)
  );
  FDE   spu_reg_1_1 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_1_IBUF_344),
    .Q(spu_reg_1_1_232)
  );
  FDE   spu_reg_1_2 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_2_IBUF_355),
    .Q(spu_reg_1_2_243)
  );
  FDE   spu_reg_1_3 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_3_IBUF_358),
    .Q(spu_reg_1_3_254)
  );
  FDE   spu_reg_1_4 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_4_IBUF_359),
    .Q(spu_reg_1_4_257)
  );
  FDE   spu_reg_1_5 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_5_IBUF_360),
    .Q(spu_reg_1_5_258)
  );
  FDE   spu_reg_1_6 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_6_IBUF_361),
    .Q(spu_reg_1_6_259)
  );
  FDE   spu_reg_1_7 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_7_IBUF_362),
    .Q(spu_reg_1_7_260)
  );
  FDE   spu_reg_1_8 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_8_IBUF_363),
    .Q(spu_reg_1_8_261)
  );
  FDE   spu_reg_1_9 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_9_IBUF_364),
    .Q(spu_reg_1_9_262)
  );
  FDE   spu_reg_1_10 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_10_IBUF_334),
    .Q(spu_reg_1_10_233)
  );
  FDE   spu_reg_1_11 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_11_IBUF_335),
    .Q(spu_reg_1_11_234)
  );
  FDE   spu_reg_1_12 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_12_IBUF_336),
    .Q(spu_reg_1_12_235)
  );
  FDE   spu_reg_1_13 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_13_IBUF_337),
    .Q(spu_reg_1_13_236)
  );
  FDE   spu_reg_1_14 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_14_IBUF_338),
    .Q(spu_reg_1_14_237)
  );
  FDE   spu_reg_1_15 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_15_IBUF_339),
    .Q(spu_reg_1_15_238)
  );
  FDE   spu_reg_1_16 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_16_IBUF_340),
    .Q(spu_reg_1_16_239)
  );
  FDE   spu_reg_1_17 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_17_IBUF_341),
    .Q(spu_reg_1_17_240)
  );
  FDE   spu_reg_1_18 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_18_IBUF_342),
    .Q(spu_reg_1_18_241)
  );
  FDE   spu_reg_1_19 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_19_IBUF_343),
    .Q(spu_reg_1_19_242)
  );
  FDE   spu_reg_1_20 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_20_IBUF_345),
    .Q(spu_reg_1_20_244)
  );
  FDE   spu_reg_1_21 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_21_IBUF_346),
    .Q(spu_reg_1_21_245)
  );
  FDE   spu_reg_1_22 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_22_IBUF_347),
    .Q(spu_reg_1_22_246)
  );
  FDE   spu_reg_1_23 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_23_IBUF_348),
    .Q(spu_reg_1_23_247)
  );
  FDE   spu_reg_1_24 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_24_IBUF_349),
    .Q(spu_reg_1_24_248)
  );
  FDE   spu_reg_1_25 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_25_IBUF_350),
    .Q(spu_reg_1_25_249)
  );
  FDE   spu_reg_1_26 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_26_IBUF_351),
    .Q(spu_reg_1_26_250)
  );
  FDE   spu_reg_1_27 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_27_IBUF_352),
    .Q(spu_reg_1_27_251)
  );
  FDE   spu_reg_1_28 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_28_IBUF_353),
    .Q(spu_reg_1_28_252)
  );
  FDE   spu_reg_1_29 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_29_IBUF_354),
    .Q(spu_reg_1_29_253)
  );
  FDE   spu_reg_1_30 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_30_IBUF_356),
    .Q(spu_reg_1_30_255)
  );
  FDE   spu_reg_1_31 (
    .C(clk_BUFGP_67),
    .CE(spu_reg_1_and0000),
    .D(spu_res_data_31_IBUF_357),
    .Q(spu_reg_1_31_256)
  );
  LUT3 #(
    .INIT ( 8'h20 ))
  spu_reg_2_and00001 (
    .I0(rst_n_IBUF_197),
    .I1(spu_res_addr_0_IBUF_299),
    .I2(spu_res_addr_1_IBUF_300),
    .O(spu_reg_2_and0000)
  );
  LUT3 #(
    .INIT ( 8'h20 ))
  spu_reg_1_and00001 (
    .I0(spu_res_addr_0_IBUF_299),
    .I1(spu_res_addr_1_IBUF_300),
    .I2(rst_n_IBUF_197),
    .O(spu_reg_1_and0000)
  );
  LUT3 #(
    .INIT ( 8'h02 ))
  spu_reg_0_and00001 (
    .I0(rst_n_IBUF_197),
    .I1(spu_res_addr_0_IBUF_299),
    .I2(spu_res_addr_1_IBUF_300),
    .O(spu_reg_0_and0000)
  );
  IBUF   rst_n_IBUF (
    .I(rst_n),
    .O(rst_n_IBUF_197)
  );
  IBUF   cpu_wdata_31_IBUF (
    .I(cpu_wdata[31]),
    .O(cpu_wdata_31_IBUF_124)
  );
  IBUF   cpu_wdata_30_IBUF (
    .I(cpu_wdata[30]),
    .O(cpu_wdata_30_IBUF_123)
  );
  IBUF   cpu_wdata_29_IBUF (
    .I(cpu_wdata[29]),
    .O(cpu_wdata_29_IBUF_121)
  );
  IBUF   cpu_wdata_28_IBUF (
    .I(cpu_wdata[28]),
    .O(cpu_wdata_28_IBUF_120)
  );
  IBUF   cpu_wdata_27_IBUF (
    .I(cpu_wdata[27]),
    .O(cpu_wdata_27_IBUF_119)
  );
  IBUF   cpu_wdata_26_IBUF (
    .I(cpu_wdata[26]),
    .O(cpu_wdata_26_IBUF_118)
  );
  IBUF   cpu_wdata_25_IBUF (
    .I(cpu_wdata[25]),
    .O(cpu_wdata_25_IBUF_117)
  );
  IBUF   cpu_wdata_24_IBUF (
    .I(cpu_wdata[24]),
    .O(cpu_wdata_24_IBUF_116)
  );
  IBUF   cpu_wdata_23_IBUF (
    .I(cpu_wdata[23]),
    .O(cpu_wdata_23_IBUF_115)
  );
  IBUF   cpu_wdata_22_IBUF (
    .I(cpu_wdata[22]),
    .O(cpu_wdata_22_IBUF_114)
  );
  IBUF   cpu_wdata_21_IBUF (
    .I(cpu_wdata[21]),
    .O(cpu_wdata_21_IBUF_113)
  );
  IBUF   cpu_wdata_20_IBUF (
    .I(cpu_wdata[20]),
    .O(cpu_wdata_20_IBUF_112)
  );
  IBUF   cpu_wdata_19_IBUF (
    .I(cpu_wdata[19]),
    .O(cpu_wdata_19_IBUF_110)
  );
  IBUF   cpu_wdata_18_IBUF (
    .I(cpu_wdata[18]),
    .O(cpu_wdata_18_IBUF_109)
  );
  IBUF   cpu_wdata_17_IBUF (
    .I(cpu_wdata[17]),
    .O(cpu_wdata_17_IBUF_108)
  );
  IBUF   cpu_wdata_16_IBUF (
    .I(cpu_wdata[16]),
    .O(cpu_wdata_16_IBUF_107)
  );
  IBUF   cpu_wdata_15_IBUF (
    .I(cpu_wdata[15]),
    .O(cpu_wdata_15_IBUF_106)
  );
  IBUF   cpu_wdata_14_IBUF (
    .I(cpu_wdata[14]),
    .O(cpu_wdata_14_IBUF_105)
  );
  IBUF   cpu_wdata_13_IBUF (
    .I(cpu_wdata[13]),
    .O(cpu_wdata_13_IBUF_104)
  );
  IBUF   cpu_wdata_12_IBUF (
    .I(cpu_wdata[12]),
    .O(cpu_wdata_12_IBUF_103)
  );
  IBUF   cpu_wdata_11_IBUF (
    .I(cpu_wdata[11]),
    .O(cpu_wdata_11_IBUF_102)
  );
  IBUF   cpu_wdata_10_IBUF (
    .I(cpu_wdata[10]),
    .O(cpu_wdata_10_IBUF_101)
  );
  IBUF   cpu_wdata_9_IBUF (
    .I(cpu_wdata[9]),
    .O(cpu_wdata_9_IBUF_131)
  );
  IBUF   cpu_wdata_8_IBUF (
    .I(cpu_wdata[8]),
    .O(cpu_wdata_8_IBUF_130)
  );
  IBUF   cpu_wdata_7_IBUF (
    .I(cpu_wdata[7]),
    .O(cpu_wdata_7_IBUF_129)
  );
  IBUF   cpu_wdata_6_IBUF (
    .I(cpu_wdata[6]),
    .O(cpu_wdata_6_IBUF_128)
  );
  IBUF   cpu_wdata_5_IBUF (
    .I(cpu_wdata[5]),
    .O(cpu_wdata_5_IBUF_127)
  );
  IBUF   cpu_wdata_4_IBUF (
    .I(cpu_wdata[4]),
    .O(cpu_wdata_4_IBUF_126)
  );
  IBUF   cpu_wdata_3_IBUF (
    .I(cpu_wdata[3]),
    .O(cpu_wdata_3_IBUF_125)
  );
  IBUF   cpu_wdata_2_IBUF (
    .I(cpu_wdata[2]),
    .O(cpu_wdata_2_IBUF_122)
  );
  IBUF   cpu_wdata_1_IBUF (
    .I(cpu_wdata[1]),
    .O(cpu_wdata_1_IBUF_111)
  );
  IBUF   cpu_wdata_0_IBUF (
    .I(cpu_wdata[0]),
    .O(cpu_wdata_0_IBUF_100)
  );
  IBUF   PC_31_IBUF (
    .I(PC[31]),
    .O(PC_31_IBUF_58)
  );
  IBUF   PC_30_IBUF (
    .I(PC[30]),
    .O(PC_30_IBUF_57)
  );
  IBUF   PC_29_IBUF (
    .I(PC[29]),
    .O(PC_29_IBUF_55)
  );
  IBUF   PC_28_IBUF (
    .I(PC[28]),
    .O(PC_28_IBUF_54)
  );
  IBUF   PC_27_IBUF (
    .I(PC[27]),
    .O(PC_27_IBUF_53)
  );
  IBUF   PC_26_IBUF (
    .I(PC[26]),
    .O(PC_26_IBUF_52)
  );
  IBUF   PC_25_IBUF (
    .I(PC[25]),
    .O(PC_25_IBUF_51)
  );
  IBUF   PC_24_IBUF (
    .I(PC[24]),
    .O(PC_24_IBUF_50)
  );
  IBUF   PC_23_IBUF (
    .I(PC[23]),
    .O(PC_23_IBUF_49)
  );
  IBUF   PC_22_IBUF (
    .I(PC[22]),
    .O(PC_22_IBUF_48)
  );
  IBUF   PC_21_IBUF (
    .I(PC[21]),
    .O(PC_21_IBUF_47)
  );
  IBUF   PC_20_IBUF (
    .I(PC[20]),
    .O(PC_20_IBUF_46)
  );
  IBUF   PC_19_IBUF (
    .I(PC[19]),
    .O(PC_19_IBUF_44)
  );
  IBUF   PC_18_IBUF (
    .I(PC[18]),
    .O(PC_18_IBUF_43)
  );
  IBUF   PC_17_IBUF (
    .I(PC[17]),
    .O(PC_17_IBUF_42)
  );
  IBUF   PC_16_IBUF (
    .I(PC[16]),
    .O(PC_16_IBUF_41)
  );
  IBUF   PC_15_IBUF (
    .I(PC[15]),
    .O(PC_15_IBUF_40)
  );
  IBUF   PC_14_IBUF (
    .I(PC[14]),
    .O(PC_14_IBUF_39)
  );
  IBUF   PC_13_IBUF (
    .I(PC[13]),
    .O(PC_13_IBUF_38)
  );
  IBUF   PC_12_IBUF (
    .I(PC[12]),
    .O(PC_12_IBUF_37)
  );
  IBUF   PC_11_IBUF (
    .I(PC[11]),
    .O(PC_11_IBUF_36)
  );
  IBUF   PC_10_IBUF (
    .I(PC[10]),
    .O(PC_10_IBUF_35)
  );
  IBUF   PC_9_IBUF (
    .I(PC[9]),
    .O(PC_9_IBUF_65)
  );
  IBUF   PC_8_IBUF (
    .I(PC[8]),
    .O(PC_8_IBUF_64)
  );
  IBUF   PC_7_IBUF (
    .I(PC[7]),
    .O(PC_7_IBUF_63)
  );
  IBUF   PC_6_IBUF (
    .I(PC[6]),
    .O(PC_6_IBUF_62)
  );
  IBUF   PC_5_IBUF (
    .I(PC[5]),
    .O(PC_5_IBUF_61)
  );
  IBUF   PC_4_IBUF (
    .I(PC[4]),
    .O(PC_4_IBUF_60)
  );
  IBUF   PC_3_IBUF (
    .I(PC[3]),
    .O(PC_3_IBUF_59)
  );
  IBUF   PC_2_IBUF (
    .I(PC[2]),
    .O(PC_2_IBUF_56)
  );
  IBUF   PC_1_IBUF (
    .I(PC[1]),
    .O(PC_1_IBUF_45)
  );
  IBUF   PC_0_IBUF (
    .I(PC[0]),
    .O(PC_0_IBUF_34)
  );
  IBUF   spu_res_data_31_IBUF (
    .I(spu_res_data[31]),
    .O(spu_res_data_31_IBUF_357)
  );
  IBUF   spu_res_data_30_IBUF (
    .I(spu_res_data[30]),
    .O(spu_res_data_30_IBUF_356)
  );
  IBUF   spu_res_data_29_IBUF (
    .I(spu_res_data[29]),
    .O(spu_res_data_29_IBUF_354)
  );
  IBUF   spu_res_data_28_IBUF (
    .I(spu_res_data[28]),
    .O(spu_res_data_28_IBUF_353)
  );
  IBUF   spu_res_data_27_IBUF (
    .I(spu_res_data[27]),
    .O(spu_res_data_27_IBUF_352)
  );
  IBUF   spu_res_data_26_IBUF (
    .I(spu_res_data[26]),
    .O(spu_res_data_26_IBUF_351)
  );
  IBUF   spu_res_data_25_IBUF (
    .I(spu_res_data[25]),
    .O(spu_res_data_25_IBUF_350)
  );
  IBUF   spu_res_data_24_IBUF (
    .I(spu_res_data[24]),
    .O(spu_res_data_24_IBUF_349)
  );
  IBUF   spu_res_data_23_IBUF (
    .I(spu_res_data[23]),
    .O(spu_res_data_23_IBUF_348)
  );
  IBUF   spu_res_data_22_IBUF (
    .I(spu_res_data[22]),
    .O(spu_res_data_22_IBUF_347)
  );
  IBUF   spu_res_data_21_IBUF (
    .I(spu_res_data[21]),
    .O(spu_res_data_21_IBUF_346)
  );
  IBUF   spu_res_data_20_IBUF (
    .I(spu_res_data[20]),
    .O(spu_res_data_20_IBUF_345)
  );
  IBUF   spu_res_data_19_IBUF (
    .I(spu_res_data[19]),
    .O(spu_res_data_19_IBUF_343)
  );
  IBUF   spu_res_data_18_IBUF (
    .I(spu_res_data[18]),
    .O(spu_res_data_18_IBUF_342)
  );
  IBUF   spu_res_data_17_IBUF (
    .I(spu_res_data[17]),
    .O(spu_res_data_17_IBUF_341)
  );
  IBUF   spu_res_data_16_IBUF (
    .I(spu_res_data[16]),
    .O(spu_res_data_16_IBUF_340)
  );
  IBUF   spu_res_data_15_IBUF (
    .I(spu_res_data[15]),
    .O(spu_res_data_15_IBUF_339)
  );
  IBUF   spu_res_data_14_IBUF (
    .I(spu_res_data[14]),
    .O(spu_res_data_14_IBUF_338)
  );
  IBUF   spu_res_data_13_IBUF (
    .I(spu_res_data[13]),
    .O(spu_res_data_13_IBUF_337)
  );
  IBUF   spu_res_data_12_IBUF (
    .I(spu_res_data[12]),
    .O(spu_res_data_12_IBUF_336)
  );
  IBUF   spu_res_data_11_IBUF (
    .I(spu_res_data[11]),
    .O(spu_res_data_11_IBUF_335)
  );
  IBUF   spu_res_data_10_IBUF (
    .I(spu_res_data[10]),
    .O(spu_res_data_10_IBUF_334)
  );
  IBUF   spu_res_data_9_IBUF (
    .I(spu_res_data[9]),
    .O(spu_res_data_9_IBUF_364)
  );
  IBUF   spu_res_data_8_IBUF (
    .I(spu_res_data[8]),
    .O(spu_res_data_8_IBUF_363)
  );
  IBUF   spu_res_data_7_IBUF (
    .I(spu_res_data[7]),
    .O(spu_res_data_7_IBUF_362)
  );
  IBUF   spu_res_data_6_IBUF (
    .I(spu_res_data[6]),
    .O(spu_res_data_6_IBUF_361)
  );
  IBUF   spu_res_data_5_IBUF (
    .I(spu_res_data[5]),
    .O(spu_res_data_5_IBUF_360)
  );
  IBUF   spu_res_data_4_IBUF (
    .I(spu_res_data[4]),
    .O(spu_res_data_4_IBUF_359)
  );
  IBUF   spu_res_data_3_IBUF (
    .I(spu_res_data[3]),
    .O(spu_res_data_3_IBUF_358)
  );
  IBUF   spu_res_data_2_IBUF (
    .I(spu_res_data[2]),
    .O(spu_res_data_2_IBUF_355)
  );
  IBUF   spu_res_data_1_IBUF (
    .I(spu_res_data[1]),
    .O(spu_res_data_1_IBUF_344)
  );
  IBUF   spu_res_data_0_IBUF (
    .I(spu_res_data[0]),
    .O(spu_res_data_0_IBUF_333)
  );
  IBUF   spu_res_addr_1_IBUF (
    .I(spu_res_addr[1]),
    .O(spu_res_addr_1_IBUF_300)
  );
  IBUF   spu_res_addr_0_IBUF (
    .I(spu_res_addr[0]),
    .O(spu_res_addr_0_IBUF_299)
  );
  OBUF   instruction_31_OBUF (
    .I(instruction_31_OBUF_188),
    .O(instruction[31])
  );
  OBUF   instruction_30_OBUF (
    .I(instruction_30_OBUF_187),
    .O(instruction[30])
  );
  OBUF   instruction_29_OBUF (
    .I(instruction_29_OBUF_185),
    .O(instruction[29])
  );
  OBUF   instruction_28_OBUF (
    .I(instruction_28_OBUF_184),
    .O(instruction[28])
  );
  OBUF   instruction_27_OBUF (
    .I(instruction_27_OBUF_183),
    .O(instruction[27])
  );
  OBUF   instruction_26_OBUF (
    .I(instruction_26_OBUF_182),
    .O(instruction[26])
  );
  OBUF   instruction_25_OBUF (
    .I(instruction_25_OBUF_181),
    .O(instruction[25])
  );
  OBUF   instruction_24_OBUF (
    .I(instruction_24_OBUF_180),
    .O(instruction[24])
  );
  OBUF   instruction_23_OBUF (
    .I(instruction_23_OBUF_179),
    .O(instruction[23])
  );
  OBUF   instruction_22_OBUF (
    .I(instruction_22_OBUF_178),
    .O(instruction[22])
  );
  OBUF   instruction_21_OBUF (
    .I(instruction_21_OBUF_177),
    .O(instruction[21])
  );
  OBUF   instruction_20_OBUF (
    .I(instruction_20_OBUF_176),
    .O(instruction[20])
  );
  OBUF   instruction_19_OBUF (
    .I(instruction_19_OBUF_174),
    .O(instruction[19])
  );
  OBUF   instruction_18_OBUF (
    .I(instruction_18_OBUF_173),
    .O(instruction[18])
  );
  OBUF   instruction_17_OBUF (
    .I(instruction_17_OBUF_172),
    .O(instruction[17])
  );
  OBUF   instruction_16_OBUF (
    .I(instruction_16_OBUF_171),
    .O(instruction[16])
  );
  OBUF   instruction_15_OBUF (
    .I(instruction_15_OBUF_170),
    .O(instruction[15])
  );
  OBUF   instruction_14_OBUF (
    .I(instruction_14_OBUF_169),
    .O(instruction[14])
  );
  OBUF   instruction_13_OBUF (
    .I(instruction_13_OBUF_168),
    .O(instruction[13])
  );
  OBUF   instruction_12_OBUF (
    .I(instruction_12_OBUF_167),
    .O(instruction[12])
  );
  OBUF   instruction_11_OBUF (
    .I(instruction_11_OBUF_166),
    .O(instruction[11])
  );
  OBUF   instruction_10_OBUF (
    .I(instruction_10_OBUF_165),
    .O(instruction[10])
  );
  OBUF   instruction_9_OBUF (
    .I(instruction_9_OBUF_195),
    .O(instruction[9])
  );
  OBUF   instruction_8_OBUF (
    .I(instruction_8_OBUF_194),
    .O(instruction[8])
  );
  OBUF   instruction_7_OBUF (
    .I(instruction_7_OBUF_193),
    .O(instruction[7])
  );
  OBUF   instruction_6_OBUF (
    .I(instruction_6_OBUF_192),
    .O(instruction[6])
  );
  OBUF   instruction_5_OBUF (
    .I(instruction_5_OBUF_191),
    .O(instruction[5])
  );
  OBUF   instruction_4_OBUF (
    .I(instruction_4_OBUF_190),
    .O(instruction[4])
  );
  OBUF   instruction_3_OBUF (
    .I(instruction_3_OBUF_189),
    .O(instruction[3])
  );
  OBUF   instruction_2_OBUF (
    .I(instruction_2_OBUF_186),
    .O(instruction[2])
  );
  OBUF   instruction_1_OBUF (
    .I(instruction_1_OBUF_175),
    .O(instruction[1])
  );
  OBUF   instruction_0_OBUF (
    .I(instruction_0_OBUF_164),
    .O(instruction[0])
  );
  OBUF   vga_data_1_31_OBUF (
    .I(spu_reg_0_31_223),
    .O(vga_data_1[31])
  );
  OBUF   vga_data_1_30_OBUF (
    .I(spu_reg_0_30_222),
    .O(vga_data_1[30])
  );
  OBUF   vga_data_1_29_OBUF (
    .I(spu_reg_0_29_220),
    .O(vga_data_1[29])
  );
  OBUF   vga_data_1_28_OBUF (
    .I(spu_reg_0_28_219),
    .O(vga_data_1[28])
  );
  OBUF   vga_data_1_27_OBUF (
    .I(spu_reg_0_27_218),
    .O(vga_data_1[27])
  );
  OBUF   vga_data_1_26_OBUF (
    .I(spu_reg_0_26_217),
    .O(vga_data_1[26])
  );
  OBUF   vga_data_1_25_OBUF (
    .I(spu_reg_0_25_216),
    .O(vga_data_1[25])
  );
  OBUF   vga_data_1_24_OBUF (
    .I(spu_reg_0_24_215),
    .O(vga_data_1[24])
  );
  OBUF   vga_data_1_23_OBUF (
    .I(spu_reg_0_23_214),
    .O(vga_data_1[23])
  );
  OBUF   vga_data_1_22_OBUF (
    .I(spu_reg_0_22_213),
    .O(vga_data_1[22])
  );
  OBUF   vga_data_1_21_OBUF (
    .I(spu_reg_0_21_212),
    .O(vga_data_1[21])
  );
  OBUF   vga_data_1_20_OBUF (
    .I(spu_reg_0_20_211),
    .O(vga_data_1[20])
  );
  OBUF   vga_data_1_19_OBUF (
    .I(spu_reg_0_19_209),
    .O(vga_data_1[19])
  );
  OBUF   vga_data_1_18_OBUF (
    .I(spu_reg_0_18_208),
    .O(vga_data_1[18])
  );
  OBUF   vga_data_1_17_OBUF (
    .I(spu_reg_0_17_207),
    .O(vga_data_1[17])
  );
  OBUF   vga_data_1_16_OBUF (
    .I(spu_reg_0_16_206),
    .O(vga_data_1[16])
  );
  OBUF   vga_data_1_15_OBUF (
    .I(spu_reg_0_15_205),
    .O(vga_data_1[15])
  );
  OBUF   vga_data_1_14_OBUF (
    .I(spu_reg_0_14_204),
    .O(vga_data_1[14])
  );
  OBUF   vga_data_1_13_OBUF (
    .I(spu_reg_0_13_203),
    .O(vga_data_1[13])
  );
  OBUF   vga_data_1_12_OBUF (
    .I(spu_reg_0_12_202),
    .O(vga_data_1[12])
  );
  OBUF   vga_data_1_11_OBUF (
    .I(spu_reg_0_11_201),
    .O(vga_data_1[11])
  );
  OBUF   vga_data_1_10_OBUF (
    .I(spu_reg_0_10_200),
    .O(vga_data_1[10])
  );
  OBUF   vga_data_1_9_OBUF (
    .I(spu_reg_0_9_229),
    .O(vga_data_1[9])
  );
  OBUF   vga_data_1_8_OBUF (
    .I(spu_reg_0_8_228),
    .O(vga_data_1[8])
  );
  OBUF   vga_data_1_7_OBUF (
    .I(spu_reg_0_7_227),
    .O(vga_data_1[7])
  );
  OBUF   vga_data_1_6_OBUF (
    .I(spu_reg_0_6_226),
    .O(vga_data_1[6])
  );
  OBUF   vga_data_1_5_OBUF (
    .I(spu_reg_0_5_225),
    .O(vga_data_1[5])
  );
  OBUF   vga_data_1_4_OBUF (
    .I(spu_reg_0_4_224),
    .O(vga_data_1[4])
  );
  OBUF   vga_data_1_3_OBUF (
    .I(spu_reg_0_3_221),
    .O(vga_data_1[3])
  );
  OBUF   vga_data_1_2_OBUF (
    .I(spu_reg_0_2_210),
    .O(vga_data_1[2])
  );
  OBUF   vga_data_1_1_OBUF (
    .I(spu_reg_0_1_199),
    .O(vga_data_1[1])
  );
  OBUF   vga_data_1_0_OBUF (
    .I(spu_reg_0_0_198),
    .O(vga_data_1[0])
  );
  OBUF   vga_data_2_31_OBUF (
    .I(spu_reg_1_31_256),
    .O(vga_data_2[31])
  );
  OBUF   vga_data_2_30_OBUF (
    .I(spu_reg_1_30_255),
    .O(vga_data_2[30])
  );
  OBUF   vga_data_2_29_OBUF (
    .I(spu_reg_1_29_253),
    .O(vga_data_2[29])
  );
  OBUF   vga_data_2_28_OBUF (
    .I(spu_reg_1_28_252),
    .O(vga_data_2[28])
  );
  OBUF   vga_data_2_27_OBUF (
    .I(spu_reg_1_27_251),
    .O(vga_data_2[27])
  );
  OBUF   vga_data_2_26_OBUF (
    .I(spu_reg_1_26_250),
    .O(vga_data_2[26])
  );
  OBUF   vga_data_2_25_OBUF (
    .I(spu_reg_1_25_249),
    .O(vga_data_2[25])
  );
  OBUF   vga_data_2_24_OBUF (
    .I(spu_reg_1_24_248),
    .O(vga_data_2[24])
  );
  OBUF   vga_data_2_23_OBUF (
    .I(spu_reg_1_23_247),
    .O(vga_data_2[23])
  );
  OBUF   vga_data_2_22_OBUF (
    .I(spu_reg_1_22_246),
    .O(vga_data_2[22])
  );
  OBUF   vga_data_2_21_OBUF (
    .I(spu_reg_1_21_245),
    .O(vga_data_2[21])
  );
  OBUF   vga_data_2_20_OBUF (
    .I(spu_reg_1_20_244),
    .O(vga_data_2[20])
  );
  OBUF   vga_data_2_19_OBUF (
    .I(spu_reg_1_19_242),
    .O(vga_data_2[19])
  );
  OBUF   vga_data_2_18_OBUF (
    .I(spu_reg_1_18_241),
    .O(vga_data_2[18])
  );
  OBUF   vga_data_2_17_OBUF (
    .I(spu_reg_1_17_240),
    .O(vga_data_2[17])
  );
  OBUF   vga_data_2_16_OBUF (
    .I(spu_reg_1_16_239),
    .O(vga_data_2[16])
  );
  OBUF   vga_data_2_15_OBUF (
    .I(spu_reg_1_15_238),
    .O(vga_data_2[15])
  );
  OBUF   vga_data_2_14_OBUF (
    .I(spu_reg_1_14_237),
    .O(vga_data_2[14])
  );
  OBUF   vga_data_2_13_OBUF (
    .I(spu_reg_1_13_236),
    .O(vga_data_2[13])
  );
  OBUF   vga_data_2_12_OBUF (
    .I(spu_reg_1_12_235),
    .O(vga_data_2[12])
  );
  OBUF   vga_data_2_11_OBUF (
    .I(spu_reg_1_11_234),
    .O(vga_data_2[11])
  );
  OBUF   vga_data_2_10_OBUF (
    .I(spu_reg_1_10_233),
    .O(vga_data_2[10])
  );
  OBUF   vga_data_2_9_OBUF (
    .I(spu_reg_1_9_262),
    .O(vga_data_2[9])
  );
  OBUF   vga_data_2_8_OBUF (
    .I(spu_reg_1_8_261),
    .O(vga_data_2[8])
  );
  OBUF   vga_data_2_7_OBUF (
    .I(spu_reg_1_7_260),
    .O(vga_data_2[7])
  );
  OBUF   vga_data_2_6_OBUF (
    .I(spu_reg_1_6_259),
    .O(vga_data_2[6])
  );
  OBUF   vga_data_2_5_OBUF (
    .I(spu_reg_1_5_258),
    .O(vga_data_2[5])
  );
  OBUF   vga_data_2_4_OBUF (
    .I(spu_reg_1_4_257),
    .O(vga_data_2[4])
  );
  OBUF   vga_data_2_3_OBUF (
    .I(spu_reg_1_3_254),
    .O(vga_data_2[3])
  );
  OBUF   vga_data_2_2_OBUF (
    .I(spu_reg_1_2_243),
    .O(vga_data_2[2])
  );
  OBUF   vga_data_2_1_OBUF (
    .I(spu_reg_1_1_232),
    .O(vga_data_2[1])
  );
  OBUF   vga_data_2_0_OBUF (
    .I(spu_reg_1_0_231),
    .O(vga_data_2[0])
  );
  OBUF   vga_data_3_31_OBUF (
    .I(spu_reg_2_31_289),
    .O(vga_data_3[31])
  );
  OBUF   vga_data_3_30_OBUF (
    .I(spu_reg_2_30_288),
    .O(vga_data_3[30])
  );
  OBUF   vga_data_3_29_OBUF (
    .I(spu_reg_2_29_286),
    .O(vga_data_3[29])
  );
  OBUF   vga_data_3_28_OBUF (
    .I(spu_reg_2_28_285),
    .O(vga_data_3[28])
  );
  OBUF   vga_data_3_27_OBUF (
    .I(spu_reg_2_27_284),
    .O(vga_data_3[27])
  );
  OBUF   vga_data_3_26_OBUF (
    .I(spu_reg_2_26_283),
    .O(vga_data_3[26])
  );
  OBUF   vga_data_3_25_OBUF (
    .I(spu_reg_2_25_282),
    .O(vga_data_3[25])
  );
  OBUF   vga_data_3_24_OBUF (
    .I(spu_reg_2_24_281),
    .O(vga_data_3[24])
  );
  OBUF   vga_data_3_23_OBUF (
    .I(spu_reg_2_23_280),
    .O(vga_data_3[23])
  );
  OBUF   vga_data_3_22_OBUF (
    .I(spu_reg_2_22_279),
    .O(vga_data_3[22])
  );
  OBUF   vga_data_3_21_OBUF (
    .I(spu_reg_2_21_278),
    .O(vga_data_3[21])
  );
  OBUF   vga_data_3_20_OBUF (
    .I(spu_reg_2_20_277),
    .O(vga_data_3[20])
  );
  OBUF   vga_data_3_19_OBUF (
    .I(spu_reg_2_19_275),
    .O(vga_data_3[19])
  );
  OBUF   vga_data_3_18_OBUF (
    .I(spu_reg_2_18_274),
    .O(vga_data_3[18])
  );
  OBUF   vga_data_3_17_OBUF (
    .I(spu_reg_2_17_273),
    .O(vga_data_3[17])
  );
  OBUF   vga_data_3_16_OBUF (
    .I(spu_reg_2_16_272),
    .O(vga_data_3[16])
  );
  OBUF   vga_data_3_15_OBUF (
    .I(spu_reg_2_15_271),
    .O(vga_data_3[15])
  );
  OBUF   vga_data_3_14_OBUF (
    .I(spu_reg_2_14_270),
    .O(vga_data_3[14])
  );
  OBUF   vga_data_3_13_OBUF (
    .I(spu_reg_2_13_269),
    .O(vga_data_3[13])
  );
  OBUF   vga_data_3_12_OBUF (
    .I(spu_reg_2_12_268),
    .O(vga_data_3[12])
  );
  OBUF   vga_data_3_11_OBUF (
    .I(spu_reg_2_11_267),
    .O(vga_data_3[11])
  );
  OBUF   vga_data_3_10_OBUF (
    .I(spu_reg_2_10_266),
    .O(vga_data_3[10])
  );
  OBUF   vga_data_3_9_OBUF (
    .I(spu_reg_2_9_295),
    .O(vga_data_3[9])
  );
  OBUF   vga_data_3_8_OBUF (
    .I(spu_reg_2_8_294),
    .O(vga_data_3[8])
  );
  OBUF   vga_data_3_7_OBUF (
    .I(spu_reg_2_7_293),
    .O(vga_data_3[7])
  );
  OBUF   vga_data_3_6_OBUF (
    .I(spu_reg_2_6_292),
    .O(vga_data_3[6])
  );
  OBUF   vga_data_3_5_OBUF (
    .I(spu_reg_2_5_291),
    .O(vga_data_3[5])
  );
  OBUF   vga_data_3_4_OBUF (
    .I(spu_reg_2_4_290),
    .O(vga_data_3[4])
  );
  OBUF   vga_data_3_3_OBUF (
    .I(spu_reg_2_3_287),
    .O(vga_data_3[3])
  );
  OBUF   vga_data_3_2_OBUF (
    .I(spu_reg_2_2_276),
    .O(vga_data_3[2])
  );
  OBUF   vga_data_3_1_OBUF (
    .I(spu_reg_2_1_265),
    .O(vga_data_3[1])
  );
  OBUF   vga_data_3_0_OBUF (
    .I(spu_reg_2_0_264),
    .O(vga_data_3[0])
  );
  BUFGP   clk_BUFGP (
    .I(clk),
    .O(clk_BUFGP_67)
  );
  main_mem   data_mem (
    .clka(clk_BUFGP_67),
    .rsta(N0),
    .ena(N1),
    .clkb(clk_BUFGP_67),
    .rstb(N0),
    .enb(N0),
    .wea({N1, N1, N1, N1}),
    .addra({N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0}),
    .dina({cpu_wdata_31_IBUF_124, cpu_wdata_30_IBUF_123, cpu_wdata_29_IBUF_121, cpu_wdata_28_IBUF_120, cpu_wdata_27_IBUF_119, cpu_wdata_26_IBUF_118, 
cpu_wdata_25_IBUF_117, cpu_wdata_24_IBUF_116, cpu_wdata_23_IBUF_115, cpu_wdata_22_IBUF_114, cpu_wdata_21_IBUF_113, cpu_wdata_20_IBUF_112, 
cpu_wdata_19_IBUF_110, cpu_wdata_18_IBUF_109, cpu_wdata_17_IBUF_108, cpu_wdata_16_IBUF_107, cpu_wdata_15_IBUF_106, cpu_wdata_14_IBUF_105, 
cpu_wdata_13_IBUF_104, cpu_wdata_12_IBUF_103, cpu_wdata_11_IBUF_102, cpu_wdata_10_IBUF_101, cpu_wdata_9_IBUF_131, cpu_wdata_8_IBUF_130, 
cpu_wdata_7_IBUF_129, cpu_wdata_6_IBUF_128, cpu_wdata_5_IBUF_127, cpu_wdata_4_IBUF_126, cpu_wdata_3_IBUF_125, cpu_wdata_2_IBUF_122, 
cpu_wdata_1_IBUF_111, cpu_wdata_0_IBUF_100}),
    .web({N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0}),
    .addrb({N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0}),
    .dinb({N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0
, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, 
N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0
, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0}),
    .douta({\NLW_data_mem_douta<31>_UNCONNECTED , \NLW_data_mem_douta<30>_UNCONNECTED , \NLW_data_mem_douta<29>_UNCONNECTED , 
\NLW_data_mem_douta<28>_UNCONNECTED , \NLW_data_mem_douta<27>_UNCONNECTED , \NLW_data_mem_douta<26>_UNCONNECTED , \NLW_data_mem_douta<25>_UNCONNECTED 
, \NLW_data_mem_douta<24>_UNCONNECTED , \NLW_data_mem_douta<23>_UNCONNECTED , \NLW_data_mem_douta<22>_UNCONNECTED , 
\NLW_data_mem_douta<21>_UNCONNECTED , \NLW_data_mem_douta<20>_UNCONNECTED , \NLW_data_mem_douta<19>_UNCONNECTED , \NLW_data_mem_douta<18>_UNCONNECTED 
, \NLW_data_mem_douta<17>_UNCONNECTED , \NLW_data_mem_douta<16>_UNCONNECTED , \NLW_data_mem_douta<15>_UNCONNECTED , 
\NLW_data_mem_douta<14>_UNCONNECTED , \NLW_data_mem_douta<13>_UNCONNECTED , \NLW_data_mem_douta<12>_UNCONNECTED , \NLW_data_mem_douta<11>_UNCONNECTED 
, \NLW_data_mem_douta<10>_UNCONNECTED , \NLW_data_mem_douta<9>_UNCONNECTED , \NLW_data_mem_douta<8>_UNCONNECTED , \NLW_data_mem_douta<7>_UNCONNECTED 
, \NLW_data_mem_douta<6>_UNCONNECTED , \NLW_data_mem_douta<5>_UNCONNECTED , \NLW_data_mem_douta<4>_UNCONNECTED , \NLW_data_mem_douta<3>_UNCONNECTED , 
\NLW_data_mem_douta<2>_UNCONNECTED , \NLW_data_mem_douta<1>_UNCONNECTED , \NLW_data_mem_douta<0>_UNCONNECTED }),
    .doutb({\NLW_data_mem_doutb<127>_UNCONNECTED , \NLW_data_mem_doutb<126>_UNCONNECTED , \NLW_data_mem_doutb<125>_UNCONNECTED , 
\NLW_data_mem_doutb<124>_UNCONNECTED , \NLW_data_mem_doutb<123>_UNCONNECTED , \NLW_data_mem_doutb<122>_UNCONNECTED , 
\NLW_data_mem_doutb<121>_UNCONNECTED , \NLW_data_mem_doutb<120>_UNCONNECTED , \NLW_data_mem_doutb<119>_UNCONNECTED , 
\NLW_data_mem_doutb<118>_UNCONNECTED , \NLW_data_mem_doutb<117>_UNCONNECTED , \NLW_data_mem_doutb<116>_UNCONNECTED , 
\NLW_data_mem_doutb<115>_UNCONNECTED , \NLW_data_mem_doutb<114>_UNCONNECTED , \NLW_data_mem_doutb<113>_UNCONNECTED , 
\NLW_data_mem_doutb<112>_UNCONNECTED , \NLW_data_mem_doutb<111>_UNCONNECTED , \NLW_data_mem_doutb<110>_UNCONNECTED , 
\NLW_data_mem_doutb<109>_UNCONNECTED , \NLW_data_mem_doutb<108>_UNCONNECTED , \NLW_data_mem_doutb<107>_UNCONNECTED , 
\NLW_data_mem_doutb<106>_UNCONNECTED , \NLW_data_mem_doutb<105>_UNCONNECTED , \NLW_data_mem_doutb<104>_UNCONNECTED , 
\NLW_data_mem_doutb<103>_UNCONNECTED , \NLW_data_mem_doutb<102>_UNCONNECTED , \NLW_data_mem_doutb<101>_UNCONNECTED , 
\NLW_data_mem_doutb<100>_UNCONNECTED , \NLW_data_mem_doutb<99>_UNCONNECTED , \NLW_data_mem_doutb<98>_UNCONNECTED , 
\NLW_data_mem_doutb<97>_UNCONNECTED , \NLW_data_mem_doutb<96>_UNCONNECTED , \NLW_data_mem_doutb<95>_UNCONNECTED , \NLW_data_mem_doutb<94>_UNCONNECTED 
, \NLW_data_mem_doutb<93>_UNCONNECTED , \NLW_data_mem_doutb<92>_UNCONNECTED , \NLW_data_mem_doutb<91>_UNCONNECTED , 
\NLW_data_mem_doutb<90>_UNCONNECTED , \NLW_data_mem_doutb<89>_UNCONNECTED , \NLW_data_mem_doutb<88>_UNCONNECTED , \NLW_data_mem_doutb<87>_UNCONNECTED 
, \NLW_data_mem_doutb<86>_UNCONNECTED , \NLW_data_mem_doutb<85>_UNCONNECTED , \NLW_data_mem_doutb<84>_UNCONNECTED , 
\NLW_data_mem_doutb<83>_UNCONNECTED , \NLW_data_mem_doutb<82>_UNCONNECTED , \NLW_data_mem_doutb<81>_UNCONNECTED , \NLW_data_mem_doutb<80>_UNCONNECTED 
, \NLW_data_mem_doutb<79>_UNCONNECTED , \NLW_data_mem_doutb<78>_UNCONNECTED , \NLW_data_mem_doutb<77>_UNCONNECTED , 
\NLW_data_mem_doutb<76>_UNCONNECTED , \NLW_data_mem_doutb<75>_UNCONNECTED , \NLW_data_mem_doutb<74>_UNCONNECTED , \NLW_data_mem_doutb<73>_UNCONNECTED 
, \NLW_data_mem_doutb<72>_UNCONNECTED , \NLW_data_mem_doutb<71>_UNCONNECTED , \NLW_data_mem_doutb<70>_UNCONNECTED , 
\NLW_data_mem_doutb<69>_UNCONNECTED , \NLW_data_mem_doutb<68>_UNCONNECTED , \NLW_data_mem_doutb<67>_UNCONNECTED , \NLW_data_mem_doutb<66>_UNCONNECTED 
, \NLW_data_mem_doutb<65>_UNCONNECTED , \NLW_data_mem_doutb<64>_UNCONNECTED , \NLW_data_mem_doutb<63>_UNCONNECTED , 
\NLW_data_mem_doutb<62>_UNCONNECTED , \NLW_data_mem_doutb<61>_UNCONNECTED , \NLW_data_mem_doutb<60>_UNCONNECTED , \NLW_data_mem_doutb<59>_UNCONNECTED 
, \NLW_data_mem_doutb<58>_UNCONNECTED , \NLW_data_mem_doutb<57>_UNCONNECTED , \NLW_data_mem_doutb<56>_UNCONNECTED , 
\NLW_data_mem_doutb<55>_UNCONNECTED , \NLW_data_mem_doutb<54>_UNCONNECTED , \NLW_data_mem_doutb<53>_UNCONNECTED , \NLW_data_mem_doutb<52>_UNCONNECTED 
, \NLW_data_mem_doutb<51>_UNCONNECTED , \NLW_data_mem_doutb<50>_UNCONNECTED , \NLW_data_mem_doutb<49>_UNCONNECTED , 
\NLW_data_mem_doutb<48>_UNCONNECTED , \NLW_data_mem_doutb<47>_UNCONNECTED , \NLW_data_mem_doutb<46>_UNCONNECTED , \NLW_data_mem_doutb<45>_UNCONNECTED 
, \NLW_data_mem_doutb<44>_UNCONNECTED , \NLW_data_mem_doutb<43>_UNCONNECTED , \NLW_data_mem_doutb<42>_UNCONNECTED , 
\NLW_data_mem_doutb<41>_UNCONNECTED , \NLW_data_mem_doutb<40>_UNCONNECTED , \NLW_data_mem_doutb<39>_UNCONNECTED , \NLW_data_mem_doutb<38>_UNCONNECTED 
, \NLW_data_mem_doutb<37>_UNCONNECTED , \NLW_data_mem_doutb<36>_UNCONNECTED , \NLW_data_mem_doutb<35>_UNCONNECTED , 
\NLW_data_mem_doutb<34>_UNCONNECTED , \NLW_data_mem_doutb<33>_UNCONNECTED , \NLW_data_mem_doutb<32>_UNCONNECTED , \NLW_data_mem_doutb<31>_UNCONNECTED 
, \NLW_data_mem_doutb<30>_UNCONNECTED , \NLW_data_mem_doutb<29>_UNCONNECTED , \NLW_data_mem_doutb<28>_UNCONNECTED , 
\NLW_data_mem_doutb<27>_UNCONNECTED , \NLW_data_mem_doutb<26>_UNCONNECTED , \NLW_data_mem_doutb<25>_UNCONNECTED , \NLW_data_mem_doutb<24>_UNCONNECTED 
, \NLW_data_mem_doutb<23>_UNCONNECTED , \NLW_data_mem_doutb<22>_UNCONNECTED , \NLW_data_mem_doutb<21>_UNCONNECTED , 
\NLW_data_mem_doutb<20>_UNCONNECTED , \NLW_data_mem_doutb<19>_UNCONNECTED , \NLW_data_mem_doutb<18>_UNCONNECTED , \NLW_data_mem_doutb<17>_UNCONNECTED 
, \NLW_data_mem_doutb<16>_UNCONNECTED , \NLW_data_mem_doutb<15>_UNCONNECTED , \NLW_data_mem_doutb<14>_UNCONNECTED , 
\NLW_data_mem_doutb<13>_UNCONNECTED , \NLW_data_mem_doutb<12>_UNCONNECTED , \NLW_data_mem_doutb<11>_UNCONNECTED , \NLW_data_mem_doutb<10>_UNCONNECTED 
, \NLW_data_mem_doutb<9>_UNCONNECTED , \NLW_data_mem_doutb<8>_UNCONNECTED , \NLW_data_mem_doutb<7>_UNCONNECTED , \NLW_data_mem_doutb<6>_UNCONNECTED , 
\NLW_data_mem_doutb<5>_UNCONNECTED , \NLW_data_mem_doutb<4>_UNCONNECTED , \NLW_data_mem_doutb<3>_UNCONNECTED , \NLW_data_mem_doutb<2>_UNCONNECTED , 
\NLW_data_mem_doutb<1>_UNCONNECTED , \NLW_data_mem_doutb<0>_UNCONNECTED })
  );
  instruction_memory   inst_mem (
    .clka(clk_BUFGP_67),
    .clkb(clk_BUFGP_67),
    .addra({PC_31_IBUF_58, PC_30_IBUF_57, PC_29_IBUF_55, PC_28_IBUF_54, PC_27_IBUF_53, PC_26_IBUF_52, PC_25_IBUF_51, PC_24_IBUF_50, PC_23_IBUF_49, 
PC_22_IBUF_48, PC_21_IBUF_47, PC_20_IBUF_46, PC_19_IBUF_44, PC_18_IBUF_43, PC_17_IBUF_42, PC_16_IBUF_41, PC_15_IBUF_40, PC_14_IBUF_39, PC_13_IBUF_38, 
PC_12_IBUF_37, PC_11_IBUF_36, PC_10_IBUF_35, PC_9_IBUF_65, PC_8_IBUF_64, PC_7_IBUF_63, PC_6_IBUF_62, PC_5_IBUF_61, PC_4_IBUF_60, PC_3_IBUF_59, 
PC_2_IBUF_56, PC_1_IBUF_45, PC_0_IBUF_34}),
    .addrb({N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0}),
    .douta({instruction_31_OBUF_188, instruction_30_OBUF_187, instruction_29_OBUF_185, instruction_28_OBUF_184, instruction_27_OBUF_183, 
instruction_26_OBUF_182, instruction_25_OBUF_181, instruction_24_OBUF_180, instruction_23_OBUF_179, instruction_22_OBUF_178, instruction_21_OBUF_177, 
instruction_20_OBUF_176, instruction_19_OBUF_174, instruction_18_OBUF_173, instruction_17_OBUF_172, instruction_16_OBUF_171, instruction_15_OBUF_170, 
instruction_14_OBUF_169, instruction_13_OBUF_168, instruction_12_OBUF_167, instruction_11_OBUF_166, instruction_10_OBUF_165, instruction_9_OBUF_195, 
instruction_8_OBUF_194, instruction_7_OBUF_193, instruction_6_OBUF_192, instruction_5_OBUF_191, instruction_4_OBUF_190, instruction_3_OBUF_189, 
instruction_2_OBUF_186, instruction_1_OBUF_175, instruction_0_OBUF_164}),
    .doutb({\NLW_inst_mem_doutb<31>_UNCONNECTED , \NLW_inst_mem_doutb<30>_UNCONNECTED , \NLW_inst_mem_doutb<29>_UNCONNECTED , 
\NLW_inst_mem_doutb<28>_UNCONNECTED , \NLW_inst_mem_doutb<27>_UNCONNECTED , \NLW_inst_mem_doutb<26>_UNCONNECTED , \NLW_inst_mem_doutb<25>_UNCONNECTED 
, \NLW_inst_mem_doutb<24>_UNCONNECTED , \NLW_inst_mem_doutb<23>_UNCONNECTED , \NLW_inst_mem_doutb<22>_UNCONNECTED , 
\NLW_inst_mem_doutb<21>_UNCONNECTED , \NLW_inst_mem_doutb<20>_UNCONNECTED , \NLW_inst_mem_doutb<19>_UNCONNECTED , \NLW_inst_mem_doutb<18>_UNCONNECTED 
, \NLW_inst_mem_doutb<17>_UNCONNECTED , \NLW_inst_mem_doutb<16>_UNCONNECTED , \NLW_inst_mem_doutb<15>_UNCONNECTED , 
\NLW_inst_mem_doutb<14>_UNCONNECTED , \NLW_inst_mem_doutb<13>_UNCONNECTED , \NLW_inst_mem_doutb<12>_UNCONNECTED , \NLW_inst_mem_doutb<11>_UNCONNECTED 
, \NLW_inst_mem_doutb<10>_UNCONNECTED , \NLW_inst_mem_doutb<9>_UNCONNECTED , \NLW_inst_mem_doutb<8>_UNCONNECTED , \NLW_inst_mem_doutb<7>_UNCONNECTED 
, \NLW_inst_mem_doutb<6>_UNCONNECTED , \NLW_inst_mem_doutb<5>_UNCONNECTED , \NLW_inst_mem_doutb<4>_UNCONNECTED , \NLW_inst_mem_doutb<3>_UNCONNECTED , 
\NLW_inst_mem_doutb<2>_UNCONNECTED , \NLW_inst_mem_doutb<1>_UNCONNECTED , \NLW_inst_mem_doutb<0>_UNCONNECTED })
  );

// synthesis translate_on

endmodule

// synthesis translate_off

`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

// synthesis translate_on
