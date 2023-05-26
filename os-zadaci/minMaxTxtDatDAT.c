#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <dirent.h>
#include <sys/stat.h>
#include <unistd.h>
#define MAX_NAME 1024

int imaExtenziju(const char* name,const char*ext)
{
    int i=strlen(name);
    int j=strlen(ext);
    while(i>=0&&j>=0)
        if(name[i--]!=ext[j--])
            return 0;
    return 1;
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
    char path[MAX_NAME];
    char dirname[MAX_NAME];
    char mintxt[MAX_NAME],maxdat[MAX_NAME];
    int txtmin=100000000,datmax=-1;
    strcpy(dirname,argv[1]);
    stat(dirname,&statbuf);
    if(!S_ISDIR(statbuf.st_mode))
    {
        return 1;
    }
    dp=opendir(dirname);
    while ((dirp = readdir(dp)) != NULL)
    {
        strcpy(path,dirname);
        strcat(path,"/");
        strcat(path,dirp->d_name);
        stat(path,&statbuf);

        if(S_ISREG(statbuf.st_mode))
        {
            printf("Pregledavam %s\n",dirp->d_name);
            if(imaExtenziju(dirp->d_name,".txt")&&
                statbuf.st_size<txtmin)
            {
                txtmin=statbuf.st_size;
                strcpy(mintxt,dirp->d_name);
            }
            if(imaExtenziju(dirp->d_name,".dat")&&
                statbuf.st_size>datmax)
            {
                datmax=statbuf.st_size;
                strcpy(maxdat,dirp->d_name);
            }
        }
    }
    closedir(dp);
    printf("Najmanji txt je %s sa %d bajtova,\na najveci dat je %s sa %d bajtova\n",mintxt,txtmin,maxdat,datmax);
}
