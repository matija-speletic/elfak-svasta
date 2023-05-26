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
        int broj;
        do
        {
            printf("Unesite broj: ");
            scanf("%d",&broj);
            printf("Prvi proces salje %d\n",broj);
            buf.broj=broj;
            buf.tip=1;
            msgsnd(redid,&buf,sizeof(struct poruka),0);
            buf.tip=2;
            msgrcv(redid, &buf, sizeof(struct poruka), 2, 0);
            broj=buf.broj;
            printf("Prvi proces primio %d\n",broj);
        }while(broj!=0);
        wait(NULL);
        msgctl(redid, IPC_RMID, NULL);
        printf("KRAJ PRVOG\n");
    }
    else
    {
        //dete
        struct poruka buf;
        int broj=0;
        do
        {
            buf.tip=1;
            msgrcv(redid, &buf, sizeof(struct poruka), 0, 0);
            broj=buf.broj;
            printf("Drugi proces primio %d\n",broj);
            broj*=2;
            buf.broj=broj;
            buf.tip=2;
            printf("Drugi proces salje %d\n",broj);
            msgsnd(redid,&buf,sizeof(struct poruka),0);
        }while(broj!=0);
        printf("KRAJ DRUGOG\n");
    }
}












