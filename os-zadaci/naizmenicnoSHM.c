//Prvi proces cita iz ulaz1.txt, drugi proces cita iz ulaz2.txt, treci proces upisuje iz deljive mem u izlaz.txt. Sinhronizuj da u izlazu budu naizmenicno
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
#define N 200
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
    opts.val = 0;
    semctl(sem1, 0, SETVAL, opts);
    opts.val = 1;
    semctl(sem2, 0, SETVAL, opts);
    opts.val = 0;
    semctl(sem3, 0, SETVAL, opts);
    int memid = shmget(MEM_KEY, N * sizeof(char), IPC_CREAT | 0666);

    if (fork()!=0)
    {
        //roditelj
        FILE*f=fopen("izlaz.txt","w");
        char *shmem = (char *)shmat(memid, NULL, 0);
        int red=0;
        while(1)
        {
            semop(sem1, &lock, 1);
            if(shmem[0]==0)
            {
                semop(sem2, &unlock, 1);
                semop(sem3, &unlock, 1);
                break;
            }
            printf("Roditelj procitao %s\n",shmem);
            fprintf(f,"%s",shmem);
            red++;
            if(red%2==0)
                semop(sem2, &unlock, 1);
            else
                semop(sem3, &unlock, 1);
        }
        fclose(f);
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
        FILE*f=fopen("ulaz1.txt","r");
        char buf[N];
        while(fgets(buf,N,f)!=NULL)
        {
            semop(sem2, &lock, 1);
            strcpy(shmem,buf);
            printf("Dete1 procitalo %s\n",shmem);
            semop(sem1, &unlock, 1);
        }
        semop(sem2, &lock, 1);
        shmem[0]=0;
        shmem[1]=0;
        shmem[2]=0;
        semop(sem1, &unlock, 1);
        fclose(f);
        shmdt(shmem);
        wait(NULL);
    }
    else
    {
        //dete2
        char *shmem = (char *)shmat(memid, NULL, 0);
        FILE*f=fopen("ulaz2.txt","r");
        char buf[N];
        while(fgets(buf,N,f)!=NULL)
        {
            semop(sem3, &lock, 1);
            strcpy(shmem,buf);
            printf("Dete2 procitalo %s\n",shmem);
            semop(sem1, &unlock, 1);
        }
        semop(sem3, &lock, 1);
        shmem[0]=0;
        shmem[1]=0;
        shmem[2]=0;
        semop(sem1, &unlock, 1);
        fclose(f);
        shmdt(shmem);
        wait(NULL);
    }
}
