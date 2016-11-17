	int fib(int n);
	
	int main()
	{
		int n=6;							
		int i = fib(n);
		print_t(i);
		return 0;
	}
	
	int fib(int n)
	{
		if(n==0)	return 0;	
		else
		{
			if (n==1) return 1;
			return fib(n-1)+fib(n-2);
		}
		
	}


