int main()
{
  int a = 5;
  int *b;
  b = &a;
  print_t(a);
  print_t(b);
  print_t(*b);
  return 0; 
}
