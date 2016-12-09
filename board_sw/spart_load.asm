
.WORD mem_addr 
.WORD last_byte 

.STRING data "will be overwritten"

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
    # Pointer to current mem address
    li $s0, mem_addr
    # Last byte read from the SPART 
    li $s1, last_byte
    # Store the initial address into mem_addr
    li $s2, data 
    st $s2 $s0 0 
    #reset the last byte read in the spart 
    addi $t0 $zero 100
    sb $t0 $s1 0 

wait:
    lb $t0, $s1 0
    addi $t1, $t0, -4
	bnez $t1, wait
    
    # we have all the data... send it back 
    #disable the spart interrupt
    nop
    nop
    nop
    nop
    imod 0b010
    
    st $s2 $s0 0 # reset the data pointer 
    ld $s4 $s0 0 #load the pointer 
    
loop:
    lb $s5 $s4 0 #load the byte pointed to 
    add $a0 $s5 $zero
    jal write    #anndddd write it 
    addi $t0 $s5 -4 # was it EOT
    beqz $t0 over 
    addi $s4 $s4 1
    j loop
    
over:
	halt 


SPART_IRQ:
    li $s1, last_byte
    li $s0 mem_addr # load memory address of where the current data mem is located (this doesnt change)
    addi $t10 $zero 0x00A0
	slbi $t10 0xc
    lb $t4 $t10 0 #load byte from spart
    ld $t9 $s0 0   # load current data memory address (changes)
    sb $t4 $t9 0 #store the byte 
    addi $t9 $t9 1  #increment to next address
    st $t9 $s0 0 #store the new address
    sb $t4 $s1 0 #store in last byte 
    rfe #return from irq
    
SPU_IRQ: