.STRING stra "abcdefg"
.STRING strb "abcdefg"

main:
    li $t0 stra 
    li $t1 strb 
	scmp $t0 $t1 4 0
    halt

SPU_IRQ:
SPART_IRQ:


