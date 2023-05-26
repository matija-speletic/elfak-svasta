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

struct membytes
{
    int nbytes;
    char data[N];
};

int main(int argc,char*argv[])
{
    if(argc!=3)
    {
        printf("Losi argumenti\n");
        exit(1);
    }
    struct sembuf lock = {0, -1, 0};
    struct sembuf unlock = {0, 1, 0};
    union semun opts;
    int sem1 = semget(PRVI_KEY, 1, IPC_CREAT | 0666);
    int sem2 = semget(DRUGI_KEY, 1, IPC_CREAT | 0666);
    opts.val = 1;
    semctl(sem1, 0, SETVAL, opts);
    opts.val = 0;
    semctl(sem2, 0, SETVAL, opts);
    int memid = shmget(MEM_KEY, N * sizeof(struct membytes), IPC_CREAT | 0666);

    if (fork()!=0)
    {
        //roditelj
        struct membytes *shmem = (struct membytes *)shmat(memid, NULL, 0);
        int fd=open(argv[1],O_RDONLY);
        int brProcitanih=N;
        while(brProcitanih==N)
        {
            semop(sem1, &lock, 1);
            brProcitanih=read(fd,shmem->data,N);
            shmem->nbytes=brProcitanih;
            printf("Procitao sam %d bajtova!\n",brProcitanih);
            semop(sem2, &unlock, 1);
        }
        close(fd);
        shmdt(shmem);
        wait(NULL);
        shmctl(memid, IPC_RMID, 0);
        semctl(sem1, 0, IPC_RMID, 0);
        semctl(sem2, 0, IPC_RMID, 0);
    }
    else
    {
        //dete1
        struct membytes *shmem = (struct membytes *)shmat(memid, NULL, 0);
        int fd=open(argv[2],O_CREAT | O_WRONLY | O_TRUNC, 00777);
        int brProcitanih=N;
        while(brProcitanih==N)
        {
            semop(sem2, &lock, 1);
            brProcitanih=shmem->nbytes;
            write(fd,shmem->data,brProcitanih);
            printf("Upisao sam %d bajtova!\n",brProcitanih);
            semop(sem1, &unlock, 1);
        }
        close(fd);
        shmdt(shmem);
        wait(NULL);
    }

}
