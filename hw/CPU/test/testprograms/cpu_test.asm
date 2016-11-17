# load in SPART TX address
addi $t9 $zero 0x1000 
slbi $t9 0 
addi $t10 $zero 0x1000 
slbi $t10 4

# load in ascii data 
# a - d
addi $s0 $zero 97
addi $s1 $zero 98
addi $s2 $zero 99
addi $s3 $zero 100
addi $s4 $zero 10

addi $a0 $s0 0
jal write
addi $a0 $s1 0
jal write
addi $a0 $s2 0
jal write
addi $a0 $s3 0
jal write
addi $a0 $s4 0
jal write
 

write:
st $a0 $t9 0
ld $t8 $t10 0
beqz $t8 -8
jr $ret 0

