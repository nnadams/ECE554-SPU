	int func(int i, int k, int j);
	int main()
	{
		int i=1,k=2,j=3;		
		int n = func(i,k,j);
		print_t(n);
	}

	int func(int i, int k, int j)
	{
		return (i+k)*j;
	}

