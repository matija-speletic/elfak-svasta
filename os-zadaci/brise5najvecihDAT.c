#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <dirent.h>
#include <sys/stat.h>
#define MAX_NAME 1024

void brisiNajvecu(char*dirname)
{
	char path[MAX_NAME];
	char maxpath[MAX_NAME];
	int size=0;
	struct stat statbuf;
	DIR * dp;
	struct dirent * dirp;


    stat(dirname,&statbuf);
    if(!S_ISDIR(statbuf.st_mode))
    {
        printf("Nije direktorijum!\n");
        exit(1);
    }
    dp=opendir(dirname);
    while((dirp=readdir(dp))!=NULL)
    {
        strcpy(path, dirname);
		strcat(path, "/");
		strcat(path, dirp->d_name);

		stat(path, &statbuf);

        if (S_ISREG(statbuf.st_mode))
		{
			if (statbuf.st_size > size)
			{
				strcpy(maxpath, path);
				size = statbuf.st_size;
			}

		}
    }
    printf("Brisanje datoteke %s\n",maxpath);
    if(fork()==0)
    {
        execlp("rm","rm",maxpath,NULL);
    }
    else
        wait(NULL);
    closedir(dp);
}

int main(int argc, char * argv[])
{
	if (argc < 2)
	{
		printf("Nema dovoljno ulaznih argumenata\n");
		exit(-1);
	}
	if(!strcmp(argv[1],"."))
    {
        printf("Necu da brisem zadatke!\n");
        return 0;
    }
    for(int i=0;i<5;i++)
        brisiNajvecu(argv[1]);
}
