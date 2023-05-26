//Prvi proces cita iz ulaz1.txt, drugi proces cita iz ulaz2.txt, treci proces upisuje iz deljive mem u izlaz.txt. Sinhronizuj da u izlazu budu naizmenicno
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<unistd.h>
#include<sys/types.h>
#include<sys/ipc.h>
#include<sys/sem.h>
#include <sys/shm.h>
#include <sys/time.h>
#include <sys/wait.h>
#define PRVI_KEY 10001
#define DRUGI_KEY 10002
#define TRECI_KEY 10003
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
    int sem1 = semget(PRVI_KEY, 1, IPC_CREAT | 0666);
    int sem2 = semget(DRUGI_KEY, 1, IPC_CREAT | 0666);
    int sem3 = semget(TRECI_KEY, 1, IPC_CREAT | 0666);
    struct timeval t;
    gettimeofday(&t,NULL);
    srand(t.tv_sec);
    opts.val = 1;
    semctl(sem1,0, SETVAL, opts);
    opts.val = 0;
    semctl(sem2, 0, SETVAL, opts);
    int memid = shmget(MEM_KEY, N * sizeof(int), IPC_CREAT | 0666);
    if (fork()!=0)
    {
        //roditelj
        int *shmem = (int *)shmat(memid, NULL, 0);
        for(int j=0;j<N;j++)
        {
            semop(sem1, &lock, 1);
            for(int i=0;i<N;i++)
            {
                int rnd=rand()%1000;
                shmem[i]=rnd;
            }
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
        for(int j=0;j<N;j++)
        {
            semop(sem2, &lock, 1);
            for(int i=0;i<N;i++)
            {
                printf("%d,",shmem[i]);
            }
            printf("\n");
            semop(sem1, &unlock, 1);
        }
        shmdt(shmem);
    }
}
