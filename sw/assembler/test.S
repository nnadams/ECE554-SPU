.STRING test "slvjghsfk123jhqbaldkfjhgvaojfhbvkabefjcjkadsnckjdnvkqafjbjriwtjvhliu"
.STRING comp "123"
.DEFINE TEST_IMMEDIATE 0xadf0

main:

	srl  $t1, $t9, TEST_IMMEDIATE
	scmp $t1, $t9, $t8
	stok $t6, $t9, $t2
	scat $t6, $t9, $t2
	slen $t6, $t3, $t1

test:






