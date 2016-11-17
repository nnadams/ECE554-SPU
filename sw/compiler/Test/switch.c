int main()
{
  int a = 2, b=0;
  if(a)
  print_t(a);
  switch (a)
  {
  case 1: b=1; break;
  case 2: b=2; break;
  default: b=3;
  }
  print_t(b);
  return 0;
}
