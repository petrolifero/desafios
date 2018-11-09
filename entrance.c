#include <stdio.h>
#include <unistd.h> // for pipe and fork

#define WRITETO 1
#define READFROM 0

int main(int argc, char* argv[])
{
  int c2racket[2];
  int racket2c[2];
  int childPid;
  pipe(c2racket);
  pipe(racket2c);
  childPid=fork();
  return 0;
}
