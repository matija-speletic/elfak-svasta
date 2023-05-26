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
    int subdir=0,links=0,regdats=0;
    while((dirp=readdir(dp))!=NULL)
    {
        strcpy(path,dirname);
        strcat(path,"/");
        strcat(path,dirp->d_name);
        stat(path,&statbuf);
        printf("Test: %s\n",path);
        if (S_ISDIR(statbuf.st_mode))
		{
			printf("Objekat: %s je direktorijum\n", dirp->d_name);
			subdir++;
		}

		if(S_ISREG(statbuf.st_mode))
		{
			printf("Objekat: %s je regularna datoteka\n", dirp->d_name);
			regdats++;
		}

		if(S_ISLNK(statbuf.st_mode))
		{
			printf("Objekat: %s je link\n", dirp->d_name);
			links++;
		}
    }
    printf("Statistika za folder: %s\nPodfoldera: %d\nReg. datoteka: %d\nLinkova: %d\n", argv[1], subdir, regdats, links);
    closedir(dp);
}
