#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <dirent.h>
#include <sys/stat.h>
#include <unistd.h>
#define MAX_NAME 1024

int postojiU(char*dirname,char*name,int size)
{
    struct stat statbuf;
	DIR * dp;
	struct dirent * dirp;
    char path[MAX_NAME];
    stat(dirname,&statbuf);
    if(!S_ISDIR(statbuf.st_mode))
    {
        return 0;
    }
    dp=opendir(dirname);
    while ((dirp = readdir(dp)) != NULL)
    {
        strcpy(path,dirname);
        strcat(path,"/");
        strcat(path,dirp->d_name);
        stat(path,&statbuf);

        if(S_ISREG(statbuf.st_mode)&&
            !strcmp(name,dirp->d_name)&&
            statbuf.st_size==size)
        {
            closedir(dp);
            return 1;
        }
    }
    return 0;
    closedir(dp);
}

int main(int argc, char * argv[])
{

	if (argc < 3)
	{
		printf("Nema dovoljno ulaznih argumenata\n");
		exit(-1);
	}
	struct stat statbuf;
	DIR * dp;
	struct dirent * dirp;
    char path[MAX_NAME];
    char dirname[MAX_NAME];
    strcpy(dirname,argv[1]);
    stat(dirname,&statbuf);
    if(!S_ISDIR(statbuf.st_mode))
    {
        return -1;
    }
    dp=opendir(dirname);
    while ((dirp = readdir(dp)) != NULL)
    {
        strcpy(path,dirname);
        strcat(path,"/");
        strcat(path,dirp->d_name);
        stat(path,&statbuf);

        if(S_ISREG(statbuf.st_mode)&&
            !postojiU(argv[2],dirp->d_name,statbuf.st_size))
        {
            if(fork()==0)
            {
                char path2[MAX_NAME];
                strcpy(path2,argv[2]);
                strcat(path2,"/");
                strcat(path2,dirp->d_name);
                execlp("cp","cp",path,path2,NULL);
            }
            else
                wait(NULL);
        }
    }
    closedir(dp);
}
