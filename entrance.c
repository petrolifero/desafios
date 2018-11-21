#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <signal.h>

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h> 
#include <readline/readline.h>
#include <readline/history.h>

char* readFrom(char* f)
{
	FILE* input = fopen(f,"r");
	if(!input)
	{
		fprintf(stderr,"Deu merda\n");
		exit(1);
	}
	int size;
	char* string;
	fscanf(input,"%d", &size);
	string=(char*)calloc(size+1,sizeof(char));
	fscanf(input,"%s", string);
	fclose(input);
	return string;
}

void printTo(char* f, char* content)
{
	FILE* output = fopen(f,"r");
	if(!output)
	{
		fprintf(stderr,"Deu merda2\n");
		exit(2);
	}
	fprintf(output,"%s\n", content);
	fclose(output);
}

int main(int argc, char* argv[])
{
  char* outPipe = (char*) calloc(1001,sizeof(char));
  char* inPipe = (char*) calloc(1001,sizeof(char));
  int childPid=0;
  strcat(outPipe, getenv("HOME"));
  strcat(outPipe, "/.desafios/outC");
  
  strcat(inPipe,getenv("HOME"));
  strcat(inPipe,"/.desafios/inC");
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
	char* prompt=readFrom(inPipe);
	char* command=readline(prompt);
	if(!strcmp(command,"exit"))
	{
		free(prompt);
		free(command);
		kill(childPid,SIGKILL);
		return 0;
	}
	printTo(outPipe,command);

	free(command);
	free(prompt);
	prompt=readFrom(inPipe);
	puts(prompt);
	free(prompt);
	}
	
  }
  return 0;
}
