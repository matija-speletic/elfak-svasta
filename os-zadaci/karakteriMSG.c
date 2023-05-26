//Korišćenjem programskog jezika C napisati UNIX/Linux program koji svom procesu detetu korišćenjem redova poruka identifikovan brojem 12001 prosleđuje celobrojne vrednosti različite od nule koje čita sa tastature. Poruke su tipa 22. Proces dobijene vrednosti sumira dok ne dobije vrednost 0. Tada na ekranu štampa sumu i izlazi.

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <string.h>

#define RED_PORUKA 12010
#define MAX_PORUKA 255

struct poruka
{
	long tip;
	char slovo;
};

int main(int argc, char* argv[])
{
    int redid=msgget(12010, IPC_CREAT | 0666);
    if(fork()!=0)
    {
        //roditelj
        struct poruka buf;
        buf.tip=4;
        char slovo=0;
        do
        {
            scanf("%c",&slovo);
            if(slovo=='\n')
                continue;
            printf("Prvi proces salje %c\n",slovo);
            buf.slovo=slovo;
            msgsnd(redid,&buf,sizeof(struct poruka),0);
        }while(!(slovo>='0'&&slovo<='9'));
        wait(NULL);
        msgctl(redid, IPC_RMID, NULL);
    }
    else
    {
        //dete
        struct poruka buf;
        buf.tip=4;
        FILE* f=fopen("izlaz.txt","w");
        char slovo=0;
        do
        {
            msgrcv(redid, &buf, sizeof(struct poruka), 4, 0);
            slovo=buf.slovo;
            printf("Drugi proces cita %c\n",slovo);
            fprintf(f,"%c",slovo);
        }while(!(slovo>='0'&&slovo<='9'));
        fclose(f);
    }
}
