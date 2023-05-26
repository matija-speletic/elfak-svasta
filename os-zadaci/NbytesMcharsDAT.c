#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <dirent.h>
#include <sys/stat.h>
#include <unistd.h>
#define MAX_NAME 1024

void trazi(char* dirname, int dub,int N,int M)
{
    //if(dub>=2)
      //  return;
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
    while ((dirp = readdir(dp)) != NULL)
    {
        strcpy(path,dirname);
        strcat(path,"/");
        strcat(path,dirp->d_name);
        stat(path,&statbuf);
        if (S_ISDIR(statbuf.st_mode)
            && strcmp(dirp->d_name, ".") != 0
            && strcmp(dirp->d_name, "..") != 0)
		{
			trazi(path,dub+1,N,M);
		}
        else if(S_ISREG(statbuf.st_mode)&&
            strlen(path)>M&&
            statbuf.st_size>N)
        {
            printf("\n\nDatoteka %s, velicina %d",path,statbuf.st_size);

        }
    }
    closedir(dp);
}

int main(int argc, char * argv[])
{

	if (argc < 4)
	{
		printf("Nema dovoljno ulaznih argumenata\n");
		exit(-1);
	}
	trazi(argv[1],0,atoi(argv[2]),atoi(argv[3]));
}
