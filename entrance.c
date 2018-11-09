#include <stdio.h>
#include <unistd.h> // for pipe

int main(int argc, char* argv[])
{
  int c2racket[2];
  int racket2c[2];
  pipe(c2racket);
  pipe(racket2c);
  return 0;
}
