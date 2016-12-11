# Used For Spart Loading 
.WORD mem_addr 
.WORD last_byte 
.WORD spart_irq_happend
.WORD first_byte

# Controls Operations
.WORD operation
.WORD immediate 
.WORD data_ptr_a 
.WORD data_ptr_b

# General Data Holder
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
	
spart_load:
    li $s0 spart_irq_happend
    li $s1 last_byte
    li $s2 mem_addr
    li $s3 first_byte
wait:
    ld $t0 $s0 0 
    beqz $t0 wait 
    st $zero $s0 0 #clr flag
    lb $t1, $s1 0 # read the byte
    ld $t10 $s2 0 #read data ptr
    ld $t6 $s3 0 #read first byte flag
    addi $t6 $t6 -1
    beq $t6 wrimmed
    addi $t6 $t6 -1
    beq $t6 wrop
    addi $t3 $t1 -1
    beqz $t3 dataa
    addi $t3 $t1 -2
    beqz $t3 datab
    addi $t3, $t1 -4
    beqz $t3 done
    # must be data ... write data here 
    sb $t1 $t10 0 
    # increment data ptr 
    addi $t10 $t10 1 
    st $t10 $s2 0  # store new ptr
    j wait 
wrop:
    li $t4 operation 
    sb $t1 $t4 0 # store received byte in operation
    addi $t6 $zero 1 
    st $t6 $s3 0 # reset first byte
    j wait
wrimmed:
    li $t4 immediate 
    sb $t1 $t4 0 
    st $zero $s3 0 # reset first byte
    j wait
dataa:
    #store the current mem addr as a ptr 
    li $t2 data_ptr_a
    st $t10 $t2 0
    j wait 
datab:
    #store the current mem addr as b ptr 
    li $t2 data_ptr_b
    st $t10 $t2 0
    j wait
done:
    jr $ret

main:
    # Pointer to current mem address
    li $s0, mem_addr
    # Last byte read from the SPART 
    li $s1, last_byte
    # Store the initial address into mem_addr
    li $s2, data 
    st $s2 $s0 0 
    #reset the last byte read in the spart to something non 4  
    addi $t0 $zero 100
    sb $t0 $s1 0 
    #signal that this is going to be the first byte
    li $t1 first_byte
    addi $t0 $zero 2  
    st $t0 $t1 0
    # no byte yet 
    li $t3 spart_irq_happend
    st $zero $t3 0 
    #wait for spart data
    jal spart_load

    # do something with the data 
    # echo the data back 
    jal echo_mem
    
    li $t0 operation 
    lb $t0 $t0 0 
    
    # big ass case statement 
    # 0 - strlen no spu
    # 1 - strlen w/ spu 
    # 2 - strcmp no spu
    # 3 - strcmp w/ spu
   
    beqz $t0 _strlen_nospu
    j results
    addi $t1 $t0 -1 
    beqz $t0 _strlen_spu 
    j results
    addi $t1 $t0 -2 
    beqz $t0 _strcmp_nospu 
    j results
    addi $t1 $t0 -3 
    beqz $t0 _strcmp_spu 
    j results

results:
    #todo process results
    j main 
over:
	halt 

echo_mem:
    add $sp $ret $zero
    li $s0 operation
    li $s3 immediate
    li $s1 data_ptr_a
    ld $s1 $s1 0 
    li $s2 data_ptr_b
    ld $s2 $s2 0 
    
    # write the op 
    lb $a0 $s0 0 
    jal write 
    # write the op 
    lb $a0 $s3 0 
    jal write 
    
    # write data a 
a_loop:
    lb $a0 $s1 0
    jal write 
    addi $s1 $s1 1 
    bnez $a0 a_loop #check for null 
    
    # write data b 
b_loop:
    lb $a0 $s2 0
    jal write 
    addi $s2 $s2 1 
    bnez $a0 b_loop #check for null 
    
    #terminating character
    addi $a0 $zero 4 
    jal write 
    jr $sp 
   
SPART_IRQ:
    li $t0, last_byte
    li $t2 spart_irq_happend
    addi $t10 $zero 0x00A0
	slbi $t10 0xc
    lb $t4 $t10 0 #load byte from spart
    sb $t4 $t0 0 #store in last byte 
    addi $t3 $zero 1 
    st $t3 $t2 0
    rfe #return from irq
    
SPU_IRQ:



_strlen_nospu:
    li $r0, 0 # initialize the count to zero
_l0:
    lb $t1, $a0 0 # load the next character into t1
    beqz $t1, _lexit # check for the null character
    addi $a0, $a0, 1 # increment the string pointer
    addi $r0, $r0, 1 # increment the count
    j _l0 # return to the top of the loop
_lexit:
    jr $ret

_strlen_spu:


_strcmp_nospu:


_strcmp_spu:
