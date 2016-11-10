# load some registers
addi $t0 $zero 100 
addi $t1 $zero 100
addi $t2 $zero 200
addi $t3 $zero 200

# load in SPART TX address
addi $t9 $zero 0x1000 
slbi $t9 0 
addi $t10 $zero 0x1000 
slbi $t10 4

# load in ascii data 
# a - d
addi $a0 $zero 97
addi $a1 $zero 98
addi $a2 $zero 99
addi $a3 $zero 100

# do some simple math 
#add $t4 $t0 $t1 
#seq $t5 $t4 $t2 
#beqz $t5 4

#write tx data 
st $a0 $t9 0
#wait for tx done 
ld $t8 $t10 0 
beqz $t8 -8

#write tx data 
st $a0 $t9 0
#wait for tx done 
ld $t8 $t10 0 
beqz $t8 -8

