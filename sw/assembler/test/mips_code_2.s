.data
str:
.asciiz " : is answer \n"
.text
.globl main
	main:
	sw $ra, 0($sp)
	li $t0, 8
	sub $t9, $sp, $t0
	li $t0, 2
	sw $t0, -16($sp)
	lw $t0, -16($sp)
	sw $t0, 0($t9)
	li $t0, 12
	sub $t9, $sp, $t0
	li $t0, 3
	sw $t0, -20($sp)
	lw $t0, -20($sp)
	sw $t0, 0($t9)
	li $t0, 4
	sub $t9, $sp, $t0
	lw $t0, -8($sp)
	lw $t1, -12($sp)
	add $t2, $t0,$t1
	sw $t2, -24($sp)
	lw $t0, -24($sp)
	sw $t0, 0($t9)
	lw $ra, -00($sp)
	_L00:
	jr $ra
