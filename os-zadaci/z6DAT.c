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
	int size=0;
	struct stat statbuf;
	DIR * dp;
	struct dirent * dirp;

	if (argc < 2)
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
    printf("Datoteka koj je najveca je: \n%s\nI njena velicina je %d\n",maxpath,size);
    closedir(dp);
}
