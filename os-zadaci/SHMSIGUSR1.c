#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<sys/types.h>
#include<sys/ipc.h>
#include<sys/sem.h>
#include<sys/shm.h>
#include <signal.h>
#include <sys/wait.h>
#include <string.h>

#define MEM_KEY 10005
#define N 20

int childPID;
int memid;

void stampaj();

int main()
{
    memid = shmget(MEM_KEY, 1024 * sizeof(char), IPC_CREAT | 0666);
    if((childPID=fork())!=0)
    {
        //roditelj
        char* shmem=shmat(memid,NULL,0);
        char poruka[1024];
        for(int i=0;i<10;i++)
        {
            gets(poruka);
            printf("Proces roditelj salje: %s\n",poruka);
            strcpy(shmem,poruka);
            kill(childPID,SIGUSR1);
        }
        sleep(1);
        shmctl(memid, IPC_RMID, 0);
    }
    else
    {
        //dete
        signal(SIGUSR1,stampaj);
        while(1)
            pause();
    }
}

void stampaj()
{

    char* shmem=shmat(memid,NULL,0);
    printf("Proces dete cita: %s\n",shmem);
    shmdt(shmem);
}


