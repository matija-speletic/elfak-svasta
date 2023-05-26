#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<unistd.h>
#include<sys/types.h>
#include<sys/ipc.h>
#include<sys/sem.h>
#include <sys/shm.h>
#define PRVI_KEY 10001
#define DRUGI_KEY 10002
#define TRECI_KEY 10003
#define MEM_KEY 10005
#define N 20
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
    int sem1 = semget(PRVI_KEY, 1, IPC_CREAT | 0666);
    int sem2 = semget(DRUGI_KEY, 1, IPC_CREAT | 0666);
    int sem3 = semget(TRECI_KEY, 1, IPC_CREAT | 0666);
    opts.val = 1;
    semctl(sem1, 0, SETVAL, opts);
    opts.val = 0;
    semctl(sem2, 0, SETVAL, opts);
    opts.val = 0;
    semctl(sem3, 0, SETVAL, opts);
    int memid = shmget(MEM_KEY, N * sizeof(char), IPC_CREAT | 0666);

    if (fork()!=0)
    {
        //roditelj
        char *shmem = (char *)shmat(memid, NULL, 0);
        for(int i=0;i<10;i++)
        {
            semop(sem1, &lock, 1);
            for(int j=0;j<N/2;j++)
            {
                shmem[j]='a'+rand()%26;
            }
            semop(sem2, &unlock, 1);
        }
        shmdt(shmem);
        wait(NULL);
        shmctl(memid, IPC_RMID, 0);
        semctl(sem1, 0, IPC_RMID, 0);
        semctl(sem2, 0, IPC_RMID, 0);
        semctl(sem3, 0, IPC_RMID, 0);
    }
    else if(fork()!=0)
    {
        //dete1
        char *shmem = (char *)shmat(memid, NULL, 0);
        for(int i=0;i<10;i++)
        {
            semop(sem2, &lock, 1);
            for(int j=N/2;j<N;j++)
            {
                shmem[j]=rand()%10+'0';
            }
            semop(sem3, &unlock, 1);
        }
        shmdt(shmem);
        wait(NULL);
    }
    else
    {
        //dete2
        char *shmem = (char *)shmat(memid, NULL, 0);
        for(int i=0;i<10;i++)
        {
            semop(sem3, &lock, 1);
            FILE*f=fopen("primer.txt","a");
            for(int j=0;j<N;j++)
            {
                fprintf(f,"%c ",shmem[j]);
            }
            fprintf(f,"\n");
            fclose(f);
            semop(sem1, &unlock, 1);
        }
        shmdt(shmem);
    }
}
