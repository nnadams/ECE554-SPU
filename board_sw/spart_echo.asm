
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
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    j main

SPART_IRQ:
    addi $t10 $zero 0x00A0
	slbi $t10 0xc
    lb $a0 $t10, 0 #load byte from spart
    jal write
    nop
    nop
    nop
    rfe #return from irq
    
SPU_IRQ: