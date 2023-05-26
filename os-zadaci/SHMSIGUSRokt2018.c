#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<sys/types.h>
#include<sys/ipc.h>
#include<sys/sem.h>
#include<sys/shm.h>
#include <signal.h>
#include <sys/wait.h>

#define BR_PONAVLJANJA 10
#define MEM_KEY 10005
#define N 20

int childPID;
int parentPID;
int memid;

void upisi();
void procitaj();

int main()
{
    parentPID=getpid();
    memid = shmget(MEM_KEY, N * sizeof(int), IPC_CREAT | 0666);
    if((childPID=fork())!=0)
    {
        //roditelj
        signal(SIGUSR1,upisi);
        for(int k=0;k<BR_PONAVLJANJA+1;k++)
            pause();
        wait(NULL);
        shmctl(memid, IPC_RMID, 0);
    }
    else
    {
        //dete
        sleep(1);
        signal(SIGUSR2,procitaj);
        kill(parentPID,SIGUSR1);
        for(int k=0;k<BR_PONAVLJANJA;k++)
            pause();
    }
}

void procitaj()
{
    int rnd;
    int* shmem=shmat(memid,NULL,0);
    for(int j=0;j<N;j++)
    {
        rnd=shmem[j];
        printf("%d,",rnd);
    }
    printf("\n");
    fflush(stdout);
    shmdt(shmem);
    kill(parentPID,SIGUSR1);
}

void upisi()
{
    int rnd;
    int* shmem=shmat(memid,NULL,0);
    for(int j=0;j<N;j++)
    {
        rnd=rand()%100;
        shmem[j]=rnd;
    }
    shmdt(shmem);
    //printf("\n");
    //fflush(stdout);
    kill(childPID,SIGUSR2);
}

