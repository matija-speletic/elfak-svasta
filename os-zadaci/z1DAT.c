#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <dirent.h>
#include <sys/stat.h>
#define MAX_NAME 1024

int main(int argc, char * argv[])
{
	char dirname[MAX_NAME];
	char path[MAX_NAME];
	char maxpath[MAX_NAME];
	int size;
	struct stat statbuf;
	DIR * dp;
	struct dirent * dirp;

	if (argc < 3)
	{
		printf("Nema dovoljno ulaznih argumenata\n");
		exit(-1);
	}
	strcpy(dirname,argv[1]);
    stat(dirname,&statbuf);
    if(!S_ISDIR(statbuf.st_mode))
    {
        printf("Nije direktorijum!\n");
        exit(1);
    }
    dp=opendir(dirname);
    while((dirp=readdir(dp))!=NULL)
    {
        if(strstr(dirp->d_name,argv[2])!=NULL)
            printf("%s\n",dirp->d_name);
    }
    closedir(dp);
}
