//Korišćenjem programskog jezika C napisati UNIX/Linux program koji simulira problem proizvođač/potrošač korišćenjem redova poruka (message-queues). Glavni program se deli u dva procesa. Prvi proces (proizvođač) kreira N slučajnih pozitivnih celih brojeva i šalje ih drugom procesu. N se određuje tokom izvršenja, takođe kao slučajan pozitivan ceo broj. Po završetku slanja, prvi proces šalje -1 kao kod za kraj. Drugi proces (potrošač) preuzima poslate brojeve iz poruka i štampa ih na standardnom izlazu.

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>

#define RED_PORUKA 10301
#define MAX_PORUKA 255

struct poruka
{
	long tip;
	int broj;
};

int main(int argc, char* argv[])
{
    int redid=msgget(RED_PORUKA, IPC_CREAT | 0666);
    if(fork()!=0)
    {
        //roditelj
        struct poruka buf;
        buf.tip=1;
        int N=rand()%10+5;
        for(int i=0;i<N;i++)
        {
            int rnd=rand()%1000;
            printf("Prvi proces salje %d\n",rnd);
            buf.broj=rnd;
            msgsnd(redid,&buf,sizeof(struct poruka),0);
            sleep(1);
        }
        buf.broj=-1;
        msgsnd(redid,&buf,sizeof(struct poruka),0);
        printf("Prvi proces salje -1\n");
        wait(NULL);
        msgctl(redid, IPC_RMID, NULL);
    }
    else
    {
        //dete
        struct poruka buf;
        buf.tip=1;
        int broj=0;
        do
        {
            msgrcv(redid, &buf, sizeof(struct poruka), 0, 0);
            broj=buf.broj;
            printf("Drugi proces cita %d\n",broj);
        }while(broj!=-1);
    }
}












