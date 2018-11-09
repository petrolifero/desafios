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
  if(childPid<0)
  {
    fprintf(stderr,"Internal Error, Please contact the admin(João Pedro Abreu de Souza<jp_abreu@id.uff.br>\n");
    fprintf(stderr,"Error : fork don't worked\n");
    return 1;
  }
  if(childPid == 0) //child -- racket
  {
    
  }
  else //c
  {
    
  }
  return 0;
}
