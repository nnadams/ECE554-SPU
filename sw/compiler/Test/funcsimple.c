// This test file is to check that  function with any number of parameters works properly! 
// We can edit the file to test that if function is not declared that compilers gives an error


	int func(int i);
	int main()
	{
		int n =3,i=1;
		int k;
		k = func(i);
		print_t(k);
	}

	int func(int i)
	{
		return i;
	}

