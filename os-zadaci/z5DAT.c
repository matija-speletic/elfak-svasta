#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <dirent.h>
#include <sys/stat.h>
#define MAX_NAME 1024

void brisanje(char* dirname, int gr,int dub)
{
    if(dub>=2)
        return;
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
			brisanje(path,gr,dub+1);
		}
        else if(S_ISREG(statbuf.st_mode)&&statbuf.st_size>gr)
        {
            printf("Brisem %s\n",path);
            if(fork()==0)
                execlp("rm","rm",path,NULL);
            else
                wait(NULL);
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
	brisanje(argv[1],16500,0);
}
