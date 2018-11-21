#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <signal.h>


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
	while(1)
	{
	char* prompt=readFrom();

	char* command=readline(prompt);
	if(!strcmp(command,"exit"))
	{
		free(prompt);
		free(command);
		kill(childPid,SIGKILL);
		return 0;
	}
	printTo(command);

	free(command);
	free(prompt);
	prompt=readFrom();
	puts(prompt);
	free(prompt);
	}
	
  }
  return 0;
}
