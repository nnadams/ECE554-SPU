	int fact(int n);
	
	int main()
	{
		int n=4;							
		int i = fact(n);
		print_t(n);
		print_t(i);
		return 0;
	}
	
	int fact(int n)
	{
		if(n==1)	return 1;
		else
		{
			return n*fact(n-1);
		}
		
	}


