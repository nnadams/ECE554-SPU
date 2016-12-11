rm -f main_mem.v;
cp -f mmu/ipcore_dir/instruction_memory.v instruction_memory.v;
cp -f mmu/ipcore_dir/instruction_memory.mif instruction_memory.mif;
cp -f mmu/ipcore_dir/main_mem.v main_mem.v;
cp -f mmu/ipcore_dir/main_mem.mif main_mem.mif;
vlog -work work mmu-vga/*.v  ../src/*.v;
