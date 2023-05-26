#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<sys/types.h>
#include<sys/ipc.h>
#include<sys/sem.h>
#include<sys/shm.h>
#define FULL_KEY 100001
#define EMPTY_KEY 10002
#define MUTEX_KEY 10003
#define MEM_KEY 10005
#define N 10
union semun
{
  int val;
  struct semid_ds *buf;
  ushort *array;
  struct seminfo * __buf;
  void * __pad;
};

int main()
{
    struct sembuf lock = {0, -1, 0};
    struct sembuf unlock = {0, 1, 0};
    union semun opts;
    int fullid = semget(FULL_KEY, 1, IPC_CREAT | 0666);
    int emptyid = semget(EMPTY_KEY, 1, IPC_CREAT | 0666);
    opts.val = 0;
    semctl(fullid, 0, SETVAL, opts);
    opts.val = N;
    semctl(emptyid, 0, SETVAL, opts);
    int mutexid = semget(MUTEX_KEY, 1, IPC_CREAT | 0666);
    opts.val=1;
    semctl(mutexid,0,SETVAL,opts);
    int memid = shmget(MEM_KEY, N * sizeof(int), IPC_CREAT | 0666);
    if(fork()!=0)
    {
        //roditelj
        int ptr=0;
        int* shmem=shmat(memid,NULL,0);
        for (int i = 0; i < 20; i++)
        {
            semop(emptyid, &lock, 1);
            semop(mutexid, &lock, 1);
            int p = rand() % 100;
            shmem[ptr] = p;
            ptr = (ptr + 1) % N;
            printf("Generisana vrednost je %d\n", p);
            semop(mutexid, &unlock, 1);
            semop(fullid, &unlock, 1);
            sleep(rand()%3);
        }
        shmdt(shmem);
        wait(NULL);
        semctl(fullid, 0, IPC_RMID, 0);
        semctl(emptyid, 0, IPC_RMID, 0);
        semctl(mutexid, 0, IPC_RMID, 0);
        shmctl(memid, IPC_RMID, 0);
    }
    else
    {
        //dete
        int ptr=0;
        int* shmem=shmat(memid,NULL,0);
        for (int i = 0; i < 20; i++)
        {
            semop(fullid, &lock, 1);
            semop(mutexid, &lock, 1);
            int temp;
            temp=shmem[ptr];
            ptr = (ptr + 1) % N;
            printf("Procitana vrednost je %d\n", temp);
            semop(mutexid, &unlock, 1);
            semop(emptyid, &unlock, 1);
            sleep(rand()%3);
        }
        shmdt(shmem);
    }

}
