int func(int b);

int main()
{
  int a, b;
  a = 3;
  b = 5;
  func(a);
  print_t(a);
  print_t(b);
  return 0;
}

int func(int b)
{
  int a;
  b = 2;
  a = 4;
  print_t(a);
  print_t(b);
  return b;
}
