#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
	char base[255] = "furnace ";
	size_t arglen=strlen(argv[1]);
	char* filename=malloc(arglen+5);
	strcpy(filename,argv[1]);
	strcat(base,filename);
	setuid( 0 );
	int ret = system( base );
	
	exit(WEXITSTATUS(ret));
 }