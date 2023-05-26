#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <dirent.h>
#include <sys/stat.h>
#define MAX_NAME 1024

void trazi(char* dirname, int*sizes,char paths[5][MAX_NAME])
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
			trazi(path,sizes,paths);
		}
        else if(S_ISREG(statbuf.st_mode))
        {
            int minpos=0;
            for(int i=0;i<5;i++)
                if(sizes[i]<sizes[minpos])
                    minpos=i;
            if(statbuf.st_size>sizes[minpos])
            {
                sizes[minpos]=statbuf.st_size;
                strcpy(paths[minpos],path);
            }
        }
    }
    closedir(dp);
}

int main(int argc, char * argv[])
{
    int max5sizes[5]={-1,-1,-1,-1,-1};
    char max5paths[5][MAX_NAME];
	if (argc < 2)
	{
		printf("Nema dovoljno ulaznih argumenata\n");
		exit(-1);
	}
	trazi(argv[1],max5sizes,max5paths);
    for(int i=0;i<5;i++)
    {
        printf("%s(%d)\n",max5paths[i],max5sizes[i]);
    }
}
