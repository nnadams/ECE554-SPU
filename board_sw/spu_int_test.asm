
write:
	addi $t9 $zero 0x00A0
	slbi $t9 0 
	addi $t10 $zero 0x00A0
	slbi $t10 4
	st $a0 $t9 0
	ld $t8 $t10 0
	bnez $t8 -8
	jr $ret
	
main:
	addi $a0, $zero, 65
    add $s0, $zero, $zero 
    addi $s1, $zero, 1000
    
loop:
    addi $s0, $s0, 1
    sub $t0, $s1, $s0
    bnez $t0 loop
	jal write
    nop
    nop
    nop
    j main
	 
over:
	halt 

SPU_IRQ:
    addi $a0, $zero, 66
	jal write
    rfe
SPART_IRQ: