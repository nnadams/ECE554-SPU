
main:
	 li $t0, 12
	 sub $sp, $sp, $t0
	 #move $t2, $sp
	 li $t1, 2
	 li $t3,4
	 sub $t2,$t2,$t3
	 sw $t1,0($t2)

	 lw $t1,0($t2)
	 # STORING ..
	 addi $t9,$sp,4
	 sw $t1, 0($t9)
	 addi $t2,$t2,4
	 li $t1, 3
	 li $t3,4
	 sub $t2,$t2,$t3
	 sw $t1,0($t2)

	 lw $t1,0($t2)
	 # STORING ..
	 addi $t9,$sp,8
	 sw $t1, 0($t9)
	 add $t2,$t2,4
	 li $t3,4
	 sub $t2,$t2,$t3
	 # LOADING ..
	 add $t9,$sp,4
	 lw $t4, 0($t9)
	 sw $t4,0($t2)

	 li $t3,4
	 sub $t2,$t2,$t3
	 # LOADING ..
	 add $t9,$sp,8
	 lw $t4, 0($t9)
	 sw $t4,0($t2)

	 # ADDING ..
	 lw $t1,0($t2)
	 lw $t0,4($t2)
	 li $t3,4
	 add $t2,$t2,$t3
	# +
	 add $t1,$t0,$t1
	 sw $t1,0($t2)

	 lw $t1,0($t2)
	 # STORING ..
	 add $t9,$sp,0
	 sw $t1, 0($t9)
	 add $t2,$t2,4
	 li $t0, 12
	 add $sp, $sp, $t0
	 move $t2, $sp
	 jr $ra
