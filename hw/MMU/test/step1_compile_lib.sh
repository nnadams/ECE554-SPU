 vlib SIMPRIMS
 vmap SIMPRIMS SIMPRIMS
 vlog -work SIMPRIMS lib/simprims/*.v

 vlib UNISIMS
 vmap UNISIMS UNISIMS
 vlog -work UNISIMS lib/unisims/*.v
 
 vlib CORESIMS
 vmap CORESIMS CORESIMS
 vlog -work CORESIMS lib/XilinxCoreLib/*.v 

 vlib GLBL
 vmap GLBL GLBL
 vlog -work GLBL lib/glbl.v
