#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/shm.h>
#include <sys/ipc.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <sys/msg.h>
#include <string.h>

#define MAXLEN 255

struct student{
    long tip;
    char ime[MAXLEN];
    char prezime[MAXLEN];
    int brInd;
};

void stampaj(struct student* st)
{
    printf("%d %s %s",st->brInd,st->ime,st->prezime);
}

int main()
{
    int redid=msgget(10101, IPC_CREAT | 0666);
    if(fork()!=0)
    {
        //roditelj
        struct student buf;
        buf.tip=1;
        char linija[MAXLEN];
        int br;
        do
        {
            printf("Unesite ime: ");
            scanf("%s",linija);
            strcpy(buf.ime,linija);
            printf("Unesite prezime: ");
            scanf("%s",linija);
            strcpy(buf.prezime,linija);
            printf("Unesite broj indeksa: ");
            scanf("%d",&br);
            buf.brInd=br;
            printf("Prvi proces salje: ");
            stampaj(&buf);
            printf("\n");
            msgsnd(redid, &buf, sizeof(buf), 0);
        }while(br!=0);
        wait(NULL);
        msgctl(redid, IPC_RMID, NULL);
    }
    else
    {
        //dete
        struct student buf;
        buf.tip=1;
        char linija[MAXLEN];
        int br=0;
        struct student studenti[10];
        do
        {
            msgrcv(redid, &buf, sizeof(buf), 0, 0);
            if(buf.brInd!=0)
                studenti[br++]=buf;
        }while(buf.brInd!=0);

        for(int i=0;i<br;i++)
        {
            for(int j=0;j<br-1;j++)
            {
                if(studenti[j].brInd>studenti[j+1].brInd)
                {
                    struct student temp=studenti[j];
                    studenti[j]=studenti[j+1];
                    studenti[j+1]=temp;
                }
            }
        }

        for(int j=0;j<br;j++)
        {
            stampaj(&studenti[j]);
            printf("\n");
        }
    }
}
