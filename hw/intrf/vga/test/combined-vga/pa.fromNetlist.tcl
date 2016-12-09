
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name combined-vga -dir "I:/Documents/School/Classes/5th_year/Fall_2016/ece554/project/ECE554-SPU/hw/intrf/vga/test/combined-vga/planAhead_run_1" -part xc5vlx110tff1136-1
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "I:/Documents/School/Classes/5th_year/Fall_2016/ece554/project/ECE554-SPU/hw/intrf/vga/test/combined-vga/vgamult.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {I:/Documents/School/Classes/5th_year/Fall_2016/ece554/project/ECE554-SPU/hw/intrf/vga/test/combined-vga} }
set_property target_constrs_file "I:/Documents/School/Classes/5th_year/Fall_2016/ece554/project/ECE554-SPU/hw/intrf/vga/test/combined-vga/ece554_v5/vgamult.ucf" [current_fileset -constrset]
add_files [list {I:/Documents/School/Classes/5th_year/Fall_2016/ece554/project/ECE554-SPU/hw/intrf/vga/test/combined-vga/ece554_v5/vgamult.ucf}] -fileset [get_property constrset [current_run]]
link_design
