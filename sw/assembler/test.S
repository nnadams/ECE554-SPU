.STRING test "slvjghsfk123jhqbaldkfjhgvaojfhbvkabefjcjkadsnckjdnvkqafjbjriwtjvhliu"
.STRING comp "123"
.DEFINE TEST_IMMEDIATE 0xfff0

main:
	scmp $t1, $t9, $t8
	stok $t6, $t9, $t2
	scat $t6, $t9, $t2
	slen $t6, $t3, $t1






