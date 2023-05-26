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
    struct poruka buf;
    buf.tip=1;
    char linija[MAX_PORUKA];
    do
    {
        msgrcv(redid, &buf, MAX_PORUKA, 0, 0);
        strcpy(linija,buf.txt);
        printf("Drugi proces cita %s\n",linija);
    }while(strcmp(linija,"KRAJ"));
}
