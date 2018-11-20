//Abandone os pids, mantenha os forks
//crie dois pipes nomeados explicitamente
//com mknod : mknod função a partir de 

//por hora crie os pipes na mão, depois se
//vira

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include <stdio.h>
#include <string.h>
#include <unistd.h> 
#include <readline/readline.h>
#include <readline/history.h>


int main(int argc, char* argv[])
{
  childPid=fork();
  if(childPid<0)
  {
    fprintf(stderr,"Internal Error, Please contact the admin(João Pedro Abreu de Souza<jp_abreu@id.uff.br>\n");
    fprintf(stderr,"Error : fork don't worked\n");
    return 1;
  }
  if(childPid == 0) //child -- racket
  {
    execl("desafios.rkt","desafios.rkt",(char*)NULL);
  }
  else //parent -- c
  {
	/*
		read prompt from racket
		print prompt
		read command input
		put command to racket
		read response
		print response to user
		repeat
	*/
	int size;
	FILE* fp=fopen(pathPipe,"rw");
	fscanf(fp,"%d", &size);
	char *prompt = (char*)calloc(sizeof(char)*(size+1));
	fget(prompt,size,fp);
	char* input = readline(prompt);
	
  }
  return 0;
}
