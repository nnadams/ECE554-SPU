vlog -work work instruction_memory.v main_mem.v ../verilog/test.v ../verilog/mmu_hier.v
vsim test -batch do dofile -L CORESIMS -L UNISIMS -L GLBL -L SIMPRIMS
