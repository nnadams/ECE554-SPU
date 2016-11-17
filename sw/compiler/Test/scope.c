int func(int a);
int main()
{
  int a;
  a = 3;
  int b = func(a);
  print_t(b);
  print_t(a);
  return 0;
}

int func(int a)
{
  a = 2;
  print_t(a);
  return a;
}

