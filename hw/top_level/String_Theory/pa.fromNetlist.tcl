
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name String_Theory -dir "I:/554/project/ECE554-SPU/hw/top_level/String_Theory/planAhead_run_1" -part xc5vlx110tff1136-1
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "I:/554/project/ECE554-SPU/hw/top_level/String_Theory/top_level.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {I:/554/project/ECE554-SPU/hw/top_level/String_Theory} {ipcore_dir} }
add_files [list {ipcore_dir/main_mem.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/inst_mem.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/spart_fifo.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/data_mem.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/instr_fifo.ncf}] -fileset [get_property constrset [current_run]]
set_property target_constrs_file "I:/554/project/ECE554-SPU/hw/top_level/top_level_constraints.ucf" [current_fileset -constrset]
add_files [list {I:/554/project/ECE554-SPU/hw/top_level/top_level_constraints.ucf}] -fileset [get_property constrset [current_run]]
link_design
