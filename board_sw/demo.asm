# Used For Spart Loading 
.WORD mem_addr 
.WORD last_byte 
.WORD spart_irq_happend
.WORD spu_irq_happend
.WORD first_byte
.WORD spu_result
# Controls Operations
.WORD operation
.WORD immediate 
.WORD data_ptr_a 
.WORD data_ptr_b

# Alignment Bytes 40 bytes so far. Need 128 bytes
# that is 22 empty vals
.WORD _fill0
.WORD _fill1
.WORD _fill2
.WORD _fill3
.WORD _fill4
.WORD _fill5
.WORD _fill6
.WORD _fill7
.WORD _fill8
.WORD _fill9
.WORD _fill10
.WORD _fill11
.WORD _fill12
.WORD _fill13
.WORD _fill14
.WORD _fill15
.WORD _fill16
.WORD _fill17
.WORD _fill18
.WORD _fill19
.WORD _fill20
.WORD _fill21

# This is at Address 128 !!!!@!
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
    beqz $t6 wrimmed
    addi $t6 $t6 -1
    beqz $t6 wrop
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
    li $t3 spu_irq_happend
    st $zero $t3 0 
    #wait for spart data
    jal spart_load

    #enable SPU Ints here
    nop
    nop
    nop
    nop
    imod 7
    
    # do something with the data 
    # echo the data back 
    #jal echo_mem
    
    li $t0 operation 
    lb $t0 $t0 0 
    
    # Params for string functions
    li $t1 data_ptr_a
    ld $a0 $t1 0 
    li $t1 immediate
    lb $a1 $t1 0 
   
    #reset clk count
    st $t0 $clk 0 
    
    bnez $t0 _L20
    jal _strlen_nospu
    j results
_L20:
    addi $t1 $t0 -1 
    bnez $t1 _L21
    jal _strlen_spu
    j results
_L21:
    addi $t1 $t0 -2 
    bnez $t1 _L22
    li $t1 data_ptr_b
    ld $a1 $t1 0 
    jal _strcmp_nospu 
    j results
_L22:
    addi $t1 $t0 -3 
    bnez $t1 _L23
    li $t1 data_ptr_b
    ld $a1 $t1 0 
    jal _strcmp_spu 
    j results
_L23:
    addi $t1 $t0 -4
    bnez $t1 _L24
    jal _strchr_nospu 
    j results
_L24:
    addi $t1 $t0 -5 
    bnez $t1 _L25
    jal _strchr_spu 
    j results
_L25:
    addi $t1 $t0 -6
    bnez $t1 _L26
    jal _strrchr_nospu 
    j results
_L26:
    addi $t1 $t0 -7
    bnez $t1 _L27
    jal _strrchr_spu 
    j results
_L27:
    addi $t1 $t0 -8 
    bnez $t1 _L28
    jal _strcchr_nospu 
    j results
_L28:
    addi $t1 $t0 -9 
    bnez $t1 _L29
    jal _strcchr_spu 
    j results
_L29:
    addi $t1 $t0 -10 
    bnez $t1 _L30
    li $t1 data_ptr_b
    ld $a1 $t1 0 
    jal _strstr_nospu 
    j results
_L30:
    addi $t1 $t0 -11 
    bnez $t1 _L31
    li $t1 data_ptr_b
    ld $a1 $t1 0 
    jal _strstr_spu 
    j results
_L31:
    halt
    
results:
    # load the clk count 
    ld $s7 $clk 0 
    
    # write result
    add $a0 $r0 $zero 
    jal write 
    srli $a0 $r0 8 
    jal write 
    srli $a0 $r0 16 
    jal write 
    srli $a0 $r0 24 
    jal write 
    
    # write clock count LSB first
    add $a0 $s7 $zero 
    jal write 
    srli $a0 $s7 8 
    jal write 
    srli $a0 $s7 16 
    jal write 
    srli $a0 $s7 24 
    jal write 
	
    # write terminating character 
    addi $a0 $zero 4 
    jal write 
    
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
    # write the immed 
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
    li $t0 spu_result
    slli $dp $dp 2 #mult by 4
    add $t1 $dp $strp
    ld $t2 $t1 0 #load the result from spu reg
    st $t2 $t0 0 #store in global
    li $t3 spu_irq_happend
    addi $t1 $zero 1 
    st $t1 $t3 0 #set flag
    rfe 


################################################
###### NON SPU ROUTINES#########################
################################################
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

_strcmp_nospu:
	add $t0,$zero,$zero
	add $t1,$zero,$a0
	add $t2,$zero,$a1
	
_S0:
	lb $t3, $t1, 0 
	lb $t4, $t2, 0
	beqz $t3,_S2 
	beqz $t4,_S1
	slt $t5,$t3,$t4 
	bnez $t5,_S1
	addi $t1,$t1,1  
	addi $t2,$t2,1
	j _S0
_S1:
	addi $r0,$zero,1
	j _S3
_S2:
	bnez $t4,_S1
	add $r0,$zero,$zero	
_S3:
	jr $ret

_strchr_nospu:
    add $r0 $zero $zero
_J0:
    lb $t1, $a0 0 # load the next character into t1
    beqz $t1, _J2 # check for the null character
    sub $t2 $t1 $a1 #check if its the character
    beqz $t2, _J2 
    addi $a0, $a0, 1 # increment the string pointer
    addi $r0 $r0 1 #increment index 
    j _J0 # return to the top of the loop
_J2:
    jr $ret

_strrchr_nospu:
    add $r0 $zero $zero 
    add $t0 $zero $zero
_P0:
    lb $t1, $a0 0 # load the next character into t1
    beqz $t1, _P2 # check for the null character
    sub $t2 $t1 $a1 #check if its the character
    bnez $t2, _P1
    add $r0 $zero $t0
_P1:
    addi $a0, $a0, 1 # increment the string pointer
    addi $t0 $t0 1
    j _P0 # return to the top of the loop
_P2:
    jr $ret
 
_strcchr_nospu:
    add $r0 $zero $zero 
_M0:
    lb $t1, $a0 0 # load the next character into t1
    beqz $t1, _M2 # check for the null character
    sub $t2 $t1 $a1 #check if its the character
    bnez $t2, _M1
    addi $r0 $r0 1
_M1:
    addi $a0, $a0, 1 # increment the string pointer
    j _M0 # return to the top of the loop
_M2:
    jr $ret
    
_strstr_nospu:
    addi $r0 $zero -1 
    add $s0 $a0 $zero 
    add $s1 $a1 $zero 
    add $t0 $zero $zero 
    add $t1 $zero $zero 
    
_outer_loop:
    add $t2 $t0 $s0 
    lb $t2 $t2 0 
    beqz $t2 _endstrstr
    add $t1 $zero $zero 
inner_loop:
    add $t3 $t1 $s1 
    lb $t3 $t3 0 
    add $t4 $t0 $t1 
    add $t4 $t4 $s0 
    lb $t4 $t4 0
    beqz $t3 end_outer_loop
    sub $t5 $t3 $t4 
    bnez $t5 end_outer_loop
    addi $t1 $t1 1 
    j inner_loop
    
end_outer_loop:
    beqz $t3 found 
    addi $t0 $t0 1 
    j _outer_loop 

found:
    add $r0 $t0 $zero 
_endstrstr:
    jr $ret 
    
################################################
######SPU ROUTINES##############################
################################################ 
_strlen_spu:
    nop
    nop
    nop
    slen $a0 0 0
    li $t0 spu_irq_happend
_slen_wait:
    ld $t1 $t0 0 
    beqz $t1 _slen_wait
    st $zero $t0 0 
    li $t4 spu_result
    ld $r0 $t4 0 # load result into r0
    nop
    nop
    nop
    jr $ret
    
_strcmp_spu:
    nop
    nop
    nop
    scmp $a0 $a1 0 0
    li $t0 spu_irq_happend
_scmp_wait:
    ld $t1 $t0 0 
    beqz $t1 _scmp_wait
    st $zero $t0 0 
    li $t4 spu_result
    ld $r0 $t4 0 # load result into r0
    nop
    nop
    nop
    jr $ret
    
_strchr_spu:
    addi $t0 $zero 35 #op code 
    slli $t0 $t0 26 #shift
    addi $t1 $zero 4 #src reg always a0
    slli $t1 $t1 21
    or $t0 $t0 $t1 
    addi $t1 $zero 0 #dest reg always 0 for now
    slli $t1 $t1 12
    or $t0 $t0 $t1 
    addi $t1 $zero 2 #scmp op
    slli $t1 $t1 8
    or $t0 $t0 $t1 
    or $t0 $t0 $a1 # char delim
    li $t2 _istr_chr_inst
    st $t0 $t2 0 #store the instruction
    nop
    nop
    nop
    nop
    nop
_istr_chr_inst:
    nop 
    li $t0 spu_irq_happend
_strchr_wait:
    ld $t1 $t0 0 
    beqz $t1 _strchr_wait
    st $zero $t0 0 
    li $t4 spu_result
    ld $r0 $t4 0 # load result into r0
    nop
    nop
    nop
    jr $ret
    
_strrchr_spu:
    addi $t0 $zero 35 #op code 
    slli $t0 $t0 26 #shift
    addi $t1 $zero 4 #src reg always a0
    slli $t1 $t1 21
    or $t0 $t0 $t1 
    addi $t1 $zero 0 #dest reg always 0 for now
    slli $t1 $t1 12
    or $t0 $t0 $t1 
    addi $t1 $zero 3 #strrchr op
    slli $t1 $t1 8
    or $t0 $t0 $t1 
    or $t0 $t0 $a1 # char delim
    li $t2 _istr_rchr_inst
    st $t0 $t2 0 #store the instruction
    nop
    nop
    nop
    nop
    nop
_istr_rchr_inst:
    nop 
    li $t0 spu_irq_happend
_strrchr_wait:
    ld $t1 $t0 0 
    beqz $t1 _strrchr_wait
    st $zero $t0 0 
    li $t4 spu_result
    ld $r0 $t4 0 # load result into r0
    nop
    nop
    nop
    jr $ret
    
    
_strcchr_spu:
    addi $t0 $zero 35 #op code 
    slli $t0 $t0 26 #shift
    addi $t1 $zero 4 #src reg always a0
    slli $t1 $t1 21
    or $t0 $t0 $t1 
    addi $t1 $zero 0 #dest reg always 0 for now
    slli $t1 $t1 12
    or $t0 $t0 $t1 
    addi $t1 $zero 4 #_strcchr op
    slli $t1 $t1 8
    or $t0 $t0 $t1 
    or $t0 $t0 $a1 # char delim
    li $t2 _istr_cchr_inst
    st $t0 $t2 0 #store the instruction
    nop
    nop
    nop
    nop
    nop
_istr_cchr_inst:
    nop 
    li $t0 spu_irq_happend
_strcchr_wait:
    ld $t1 $t0 0 
    beqz $t1 _strcchr_wait
    st $zero $t0 0 
    li $t4 spu_result
    ld $r0 $t4 0 # load result into r0
    nop
    nop
    nop
    jr $ret

_strstr_spu:
    nop
    nop
    nop
    strstr $a0 $a1 0 0
    li $t0 spu_irq_happend
_strstr_wait:
    ld $t1 $t0 0 
    beqz $t1 _strstr_wait
    st $zero $t0 0 
    li $t4 spu_result
    ld $r0 $t4 0 # load result into r0
    nop
    nop
    nop
    jr $ret