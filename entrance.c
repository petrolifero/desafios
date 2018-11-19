//Abandone os pids, mantenha os forks
//crie dois pipes nomeados explicitamente
//com mknod : system("mknod /home/$USER/.desafios/input")

//

#include <stdio.h>
#include <unistd.h> // for pipe and fork
#include <readline/readline.h>
#include <readline/history.h>

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
    FILE* in,*out;
    close(c2racket[WRITETO]);
    close(racket2c[READFROM]);
    
  }
  else //parent -- c
  {
    close(c2racket[READFROM]);
    close(racket2c[WRITETO]);
  }
  return 0;
}
