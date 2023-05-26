#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <dirent.h>
#include <sys/stat.h>
#define MAX_NAME 1024

void trazi(char* dirname, char*param)
{
    printf("Folder %s:\n",dirname);
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
    while((dirp=readdir(dp))!=NULL)
    {
        strcpy(path,dirname);
        strcat(path,"/");
        strcat(path,dirp->d_name);
        stat(path,&statbuf);
        if (S_ISDIR(statbuf.st_mode)
            && strcmp(dirp->d_name, ".") != 0
            && strcmp(dirp->d_name, "..") != 0)
		{
			trazi(path,param);
		}
        else if(strstr(dirp->d_name,param)!=NULL)
            printf("%s\n",path);
    }
    closedir(dp);
}

int main(int argc, char * argv[])
{

	if (argc < 3)
	{
		printf("Nema dovoljno ulaznih argumenata\n");
		exit(-1);
	}
	trazi(argv[1],argv[2]);
}
