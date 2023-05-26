//Korišćenjem programskog jezika C napisati Linux program koji omogućava da dva procesa komuniciraju i sinhronizuju svoje izvršavanje korišćenjem signala. Prvi proces po slučajnom principu kreira 1024 celobrojne vrednosti i smešta ih u binarnu datoteku prenos.dat. Kada izgeneriše brojeve, obaveštava o tome drugi proces, slanjem signala SIGUSR1 i pauzira svoje izvršavanje. Kada drugi proces primi signal on sadržaj datoteke prenos.dat prikazuje na standardni izlazu, šalje prvom procesu signal SIGUSR2 i nakon toga pauzira svoje izvršavanje. Po prijemu signala SIGUSR2, prvi proces ponovo startuje čitav postupak. Postupak se ponavlja 4096 puta. Nakon toga se oba procesa završavaju.

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/shm.h>
#include <sys/ipc.h>
#include <sys/types.h>
#include <sys/wait.h>

int child1PID;
int child2PID;
int parentPID;

int signum=0;

void prvi();
void drugi();
void citaj();

#define BR_PONAVLJANJA 10

int main()
{
    parentPID=getpid();
    if((child1PID=fork())!=0)
    {
        //roditelj
        signal(SIGUSR2,citaj);
        signal(SIGUSR1,SIG_IGN);
        sleep(1);
        kill(child1PID,SIGUSR1);
        kill(child2PID,SIGUSR1);
        for(int k=0;k<2*BR_PONAVLJANJA;k++)
            pause();
        exit(0);
    }
    else
    {
        if((child2PID=fork())!=0)
        {
            //dete 1
            signal(SIGUSR1,prvi);
            for(;;)
                pause();
        }
        else
        {
            //dete 2
            signal(SIGUSR1,drugi);
            for(;;)
                pause();
        }
    }
}

void prvi()
{
    printf("poz1");
    FILE*f=fopen("prvi.txt","w");
    int rnd;
    for(int j=0;j<20;j++)
    {
        rnd=rand()%100;
        fprintf(f,"%d, ",rnd);
    }
    fclose(f);
    kill(parentPID,SIGUSR2);
}

void drugi()
{
    printf("poz2");
    FILE*f=fopen("drugi.txt","w");
    int rnd;
    for(int j=0;j<20;j++)
    {
        rnd=rand()%26+'a';
        fprintf(f,"%c, ",rnd);
    }
    fclose(f);
    kill(parentPID,SIGUSR2);
}

void citaj()
{
    if((++signum)%2!=0)
        return;
    printf("Prvi fajl:\n");
    FILE*f=fopen("prvi.txt","r");
    while(!feof(f))
    {
        char linija[100];
        fgets(linija,100,f);
        printf("%s\n",linija);
    }
    printf("Drugi fajl:\n");
    f=fopen("drugi.txt","r");
    while(!feof(f))
    {
        char linija[100];
        fgets(linija,100,f);
        printf("%s\n",linija);
    }
    kill(child1PID,SIGUSR1);
    kill(child2PID,SIGUSR1);
}
