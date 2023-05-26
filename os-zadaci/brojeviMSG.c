//Korišćenjem programskog jezika C napisati UNIX/Linux program koji svom procesu detetu korišćenjem redova poruka identifikovan brojem 12001 prosleđuje celobrojne vrednosti različite od nule koje čita sa tastature. Poruke su tipa 22. Proces dobijene vrednosti sumira dok ne dobije vrednost 0. Tada na ekranu štampa sumu i izlazi.

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
	int broj;
};

int main(int argc, char* argv[])
{
    int redid=msgget(12001, IPC_CREAT | 0666);
    if(fork()!=0)
    {
        //roditelj
        struct poruka buf;
        buf.tip=3;
        int broj=0;
        do
        {
            scanf("%d",&broj);
            printf("Prvi proces salje %d\n",broj);
            buf.broj=broj;
            msgsnd(redid,&buf,sizeof(struct poruka),0);
            sleep(1);
        }while(broj!=787);
        wait(NULL);
        msgctl(redid, IPC_RMID, NULL);
    }
    else
    {
        //dete
        struct poruka buf;
        buf.tip=3;
        FILE* f=fopen("izlaz.txt","w");
        int broj=0;
        do
        {
            msgrcv(redid, &buf, sizeof(struct poruka), 3, 0);
            broj=buf.broj;
            printf("Drugi proces cita %d\n",broj);
            fprintf(f,"%d\n",broj);
        }while(broj!=787);
        fclose(f);
    }
}
