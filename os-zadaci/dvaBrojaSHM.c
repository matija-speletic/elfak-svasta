//Korišćenjem programskog jezika C napisati Linux/UNIX program koji kreira jedan dodatni proces. Ova dva procesa komuniciraju korišćenjem deljive memorije veličine dva int broja. Proces roditelj sa tastature čita jedan broj, a u deljenu memoriju upisuje taj broj i njegovu trostruku vrednost. Zatim proces dete čita ove brojeve i na ekranu štampa njihov zbir. Ovaj ciklus se ponavlja sve dok se sa tastature ne unese ključna reč KRAJ.
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<unistd.h>
#include<sys/types.h>
#include<sys/ipc.h>
#include<sys/sem.h>
#include <sys/shm.h>
#include<fcntl.h>
#define PRVI_KEY 10001
#define DRUGI_KEY 10002
#define TRECI_KEY 10003
#define MEM_KEY 10005
#define N 80
union semun
{
  int val;
  struct semid_ds *buf;
  ushort *array;
  struct seminfo * __buf;
  void * __pad;
};

int main(int argc,char*argv[])
{

    struct sembuf lock = {0, -1, 0};
    struct sembuf unlock = {0, 1, 0};
    union semun opts;
    int sem1 = semget(PRVI_KEY, 1, IPC_CREAT | 0666);
    int sem2 = semget(DRUGI_KEY, 1, IPC_CREAT | 0666);
    opts.val = 1;
    semctl(sem1, 0, SETVAL, opts);
    opts.val = 0;
    semctl(sem2, 0, SETVAL, opts);
    int memid = shmget(MEM_KEY, 2 * sizeof(int), IPC_CREAT | 0666);

    if (fork()!=0)
    {
        //roditelj
        int *shmem = (int *)shmat(memid, NULL, 0);
        while(1)
        {
            semop(sem1, &lock, 1);
            char broj[10];
            scanf("%s",broj);
            if(!strcmp(broj,"KRAJ"))
            {
                shmem[0]=shmem[1]=-1;
                semop(sem2, &unlock, 1);
                break;
            }
            int num=atoi(broj);
            shmem[0]=num;
            shmem[1]=num*3;
            printf("Proces 1 upisao %d i %d\n",shmem[0],shmem[1]);
            semop(sem2, &unlock, 1);
        }
        shmdt(shmem);
        wait(NULL);
        shmctl(memid, IPC_RMID, 0);
        semctl(sem1, 0, IPC_RMID, 0);
        semctl(sem2, 0, IPC_RMID, 0);
    }
    else
    {
        //dete1
        int *shmem = (int *)shmat(memid, NULL, 0);
        while(1)
        {
            semop(sem2, &lock, 1);
            if(shmem[0]==-1&&shmem[1]==-1)
                break;
            printf("Proces 2 je izracunao zbir %d\n",shmem[0]+shmem[1]);
            semop(sem1, &unlock, 1);
        }
        shmdt(shmem);
        wait(NULL);
    }

}
