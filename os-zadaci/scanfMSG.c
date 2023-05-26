//Korišćenjem programskog jezika C napisati UNIX/Linux program koji simulira problem proizvođač/potrošač korišćenjem redova poruka (message-queues). Glavni program se deli u dva procesa. Prvi proces (proizvođač) kreira N slučajnih pozitivnih celih brojeva i šalje ih drugom procesu. N se određuje tokom izvršenja, takođe kao slučajan pozitivan ceo broj. Po završetku slanja, prvi proces šalje -1 kao kod za kraj. Drugi proces (potrošač) preuzima poslate brojeve iz poruka i štampa ih na standardnom izlazu.

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <string.h>

#define RED_PORUKA 10301
#define MAX_PORUKA 255

struct poruka
{
	long tip;
	char txt[MAX_PORUKA];
};

int main(int argc, char* argv[])
{
    int redid=msgget(RED_PORUKA, IPC_CREAT | 0666);
    if(fork()!=0)
    {
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
        msgctl(redid, IPC_RMID, NULL);
    }
    else
    {
        //dete
        struct poruka buf;
        buf.tip=1;
        char linija[MAX_PORUKA];
        FILE*f=fopen("izlaz.txt","w");
        do
        {
            msgrcv(redid, &buf, MAX_PORUKA, 0, 0);
            strcpy(linija,buf.txt);
            printf("Drugi proces cita %s\n",linija);
            fprintf(f,"%s\n",linija);
        }while(strcmp(linija,"KRAJ"));
        fclose(f);
    }
}












