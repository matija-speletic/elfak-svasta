#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <dirent.h>
#include <sys/stat.h>
#define MAX_NAME 1024

void trazi(char* dirname, int*count,int*size)
{
    //printf("Folder %s:\n",dirname);
    struct stat statbuf;
	DIR * dp;
	struct dirent * dirp;
    char path[MAX_NAME];
    stat(dirname,&statbuf);
    if(!S_ISDIR(statbuf.st_mode))
    {
        return;
    }
    dp=opendir(dirname);
    *count=0;
    *size=0;
    while((dirp=readdir(dp))!=NULL)
    {
        strcpy(path,dirname);
        strcat(path,"/");
        strcat(path,dirp->d_name);
        stat(path,&statbuf);
        if (S_ISREG(statbuf.st_mode))
		{
			*count=*count+1;
            *size=*size+statbuf.st_size;
        }
    }
    closedir(dp);
}

int main(int argc, char * argv[])
{

	if (argc < 2)
	{
		printf("Nema dovoljno ulaznih argumenata\n");
		exit(-1);
	}
	struct stat statbuf;
	DIR * dp;
	struct dirent * dirp;
    char dirname[MAX_NAME];
    strcpy(dirname,argv[1]);
    char path[MAX_NAME];
    stat(dirname,&statbuf);
    if(!S_ISDIR(statbuf.st_mode))
    {
        return 1;
    }
    dp=opendir(dirname);
    int count=0;
    int size=0;
    while((dirp=readdir(dp))!=NULL)
    {
        if (strcmp(dirp->d_name, ".") == 0 || strcmp(dirp->d_name, "..") == 0)
			continue;
        strcpy(path,dirname);
        strcat(path,"/");
        strcat(path,dirp->d_name);
        stat(path,&statbuf);
        if (S_ISDIR(statbuf.st_mode))
		{
			trazi(path,&count,&size);
            printf("%s\t\t%d\t\t%dB\n",dirp->d_name,count,size);
        }
    }
    closedir(dp);
}
