#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <string.h>

#define MAX_PORUKA 255

struct poruka
{
	long tip;
	char txt[255];
};

int main(int argc, char* argv[])
{
    int redid=msgget(atoi(argv[1]), IPC_CREAT | 0666);
    //roditelj
    struct poruka buf;
    buf.tip=1;
    char linija[MAX_PORUKA];
    do
    {
        gets(linija,MAX_PORUKA);
        strcpy(buf.txt,linija);
        printf("Prvi proces salje: %s\n",linija);
        msgsnd(redid, &buf, strlen(buf.txt)+1, 0);
    }while(strcmp(linija,"KRAJ"));
    wait(NULL);
}
