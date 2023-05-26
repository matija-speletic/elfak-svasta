//Korišćenjem programskog jezika C napisati Linux program koji omogućava da dva procesa komuniciraju i sinhronizuju svoje izvršavanje korišćenjem signala. Prvi proces po slučajnom principu kreira 1024 celobrojne vrednosti i smešta ih u binarnu datoteku prenos.dat. Kada izgeneriše brojeve, obaveštava o tome drugi proces, slanjem signala SIGUSR1 i pauzira svoje izvršavanje. Kada drugi proces primi signal on sadržaj datoteke prenos.dat prikazuje na standardni izlazu, šalje prvom procesu signal SIGUSR2 i nakon toga pauzira svoje izvršavanje. Po prijemu signala SIGUSR2, prvi proces ponovo startuje čitav postupak. Postupak se ponavlja 4096 puta. Nakon toga se oba procesa završavaju.

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/shm.h>
#include <sys/ipc.h>
#include <sys/types.h>
#include <sys/wait.h>

int childPID;
int parentPID;

void upisi();
void procitaj();

#define BR_PONAVLJANJA 10

int main()
{
    parentPID=getpid();
    if((childPID=fork())!=0)
    {
        //roditelj
        signal(SIGUSR1,upisi);
        for(int k=0;k<BR_PONAVLJANJA-1;k++)
            pause();
        wait(NULL);
    }
    else
    {
        //dete
        sleep(1);
        signal(SIGUSR2,procitaj);
        kill(parentPID,SIGUSR1);
        for(int k=0;k<BR_PONAVLJANJA-1;k++)
            pause();
    }
}

void procitaj()
{
    FILE*f=fopen("prenos.dat","r");
    int rnd;
    for(int j=0;j<20;j++)
    {
        fscanf(f,"%d\n",&rnd);
        printf("%d,",rnd);
    }
    printf("\n");
    fflush(stdout);
    fclose(f);
    kill(parentPID,SIGUSR1);
}

void upisi()
{
    FILE*f=fopen("prenos.dat","w");
    int rnd;
    for(int j=0;j<20;j++)
    {
        rnd=rand()%100;
        fprintf(f,"%d\n",rnd);
        //printf("%d ",rnd);
    }
    //printf("\n");
    //fflush(stdout);
    fclose(f);
    kill(childPID,SIGUSR2);
}

