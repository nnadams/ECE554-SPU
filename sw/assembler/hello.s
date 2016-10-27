# str:
# .globl main
.STRING no "012345678"
main:
no
fib:
sw $ra 0($sp)
li $t0 0
sw $t0 -8($sp)
lw $t0 -4($sp)
lw $t1 -8($sp)
slt $t2 $t0 $t1
slt $t3 $t1 $t0
add $t1 $t2 $t3
li $t0 1
sub $t0 $t0 $t1
sw $t0 -12($sp)
lw $t0 -12($sp)
beq $t0 $0 _L07
li $t0 0
sw $t0 -16($sp)
lw $ra -00($sp)
lw $t0 -16($sp)
sw $t0 -00($sp)
j _L03
j _L8
_L07:
li $t0 1
sw $t0 -20($sp)
lw $t0 -4($sp)
lw $t1 -20($sp)
slt $t2 $t0 $t1
slt $t3 $t1 $t0
add $t1 $t2 $t3
li $t0 1
sub $t0 $t0 $t1
sw $t0 -24($sp)
lw $t0 -24($sp)
beq $t0 $0 _L06
li $t0 1
sw $t0 -28($sp)
lw $ra -00($sp)
lw $t0 -28($sp)
sw $t0 -00($sp)
j _L03
_L06:
li $t0 1
sw $t0 -32($sp)
lw $t0 -4($sp)
lw $t1 -32($sp)
sub $t2 $t0 $t1
sw $t2 -36($sp)
lw $t0 -36($sp)
sw $t0 496($sp)
addi $sp $sp 500
jal fib
lw $t0 -00($sp)
addi $sp $sp -500
sw $t0 -40($sp)
li $t0 2
sw $t0 -44($sp)
lw $t0 -4($sp)
lw $t1 -44($sp)
sub $t2 $t0 $t1
sw $t2 -48($sp)
lw $t0 -48($sp)
sw $t0 496($sp)
addi $sp $sp 500
jal fib
lw $t0 -00($sp)
addi $sp $sp -500
sw $t0 -52($sp)
lw $t0 -40($sp)
lw $t1 -52($sp)
add $t2 $t0 $t1
sw $t2 -56($sp)
lw $ra -00($sp)
lw $t0 -56($sp)
sw $t0 -00($sp)
j _L03
_L8:
lw $ra -00($sp)
_L03:
jr $ra
