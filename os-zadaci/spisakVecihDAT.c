#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <dirent.h>
#include <sys/stat.h>
#define MAX_NAME 1024
#define MAX_FILES 100

void trazi(char* dirname, int*sizes,char paths[MAX_FILES][MAX_NAME],int*n)
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
			trazi(path,sizes,paths,n);
		}
        else if(S_ISREG(statbuf.st_mode)&&statbuf.st_size>16650)
        {
            //dodavanje tako da ostane sortiran
            printf("Ubacujem %s\n",path);
            int i=0;
            while(statbuf.st_size<sizes[i]&&i<(*n))
                i++;
            for(int j=*n;j>i;j--)
            {
                sizes[j]=sizes[j-1];
                strcpy(paths[j],paths[j-1]);
            }
            sizes[i]=statbuf.st_size;
            strcpy(paths[i],path);
            (*n)++;
        }
    }
    closedir(dp);
}

int main(int argc, char * argv[])
{
    int maxsizes[MAX_FILES];
    char maxpaths[MAX_FILES][MAX_NAME];
    int num=0;
    for(int i=0;i<MAX_FILES;maxsizes[i++]=-1);
	if (argc < 2)
	{
		printf("Nema dovoljno ulaznih argumenata\n");
		exit(-1);
	}
	trazi(argv[1],maxsizes,maxpaths,&num);
    for(int i=0;i<num;i++)
    {
        printf("%s(%d)\n",maxpaths[i],maxsizes[i]);
    }
}
