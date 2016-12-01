.STRING str1 "asfdsafhiuashvcaslkjvsafkjhsdsakjfhgascnbZlxasjhfdaslhfksZBXgfcsajhdgfsakbhmvcNZXcMgfhsaflsakjhfnbcZ"
.STRING str2 "asfdsafhiuashvcaslkjvsafkjhsdsakjfhgascnbZlxasjhfdaslhfksZBXgfcsajhdgfsakbhmvcNZXcMgfhsaflsakjhfnbca"

strcmp:
	add $t0,$zero,$zero
	add $t1,$zero,$a0
	add $t2,$zero,$a1
	
loop:
	lb $t3, $t1, 0 
	lb $t4, $t2, 0
	beqz $t3,checkt2 
	beqz $t4,missmatch
	slt $t5,$t3,$t4 
	bnez $t5,missmatch
	addi $t1,$t1,1  
	addi $t2,$t2,1
	j loop

missmatch:
	addi $r0,$zero,1
	j endfunction
	
checkt2:
	bnez $t4,missmatch
	add $r0,$zero,$zero
	
endfunction:
	jr $ret

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
	jal write
	lbi $a0, 0x0080  #pass address of str1
	slbi $a0, 0
	lbi $a1, 0x0080
	slbi $a1, 0x65
	#li $a1, str2  #pass address of str2
	jal strcmp  #call strcmp
	beqz $r0, succ
	addi $a0, $zero, 49
	jal write
	j over
	
succ:
	addi $a0, $zero, 48
	jal write 
	 
over:
	halt 


