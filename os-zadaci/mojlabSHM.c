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

int main(int argc, char* argv[])
{
    if(argc!=2)
    {
        printf("Losi argumenti!\n");
        return 1;
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
    int memid = shmget(MEM_KEY, N * sizeof(char), IPC_CREAT | 0666);

    if (fork()!=0)
    {
        //roditelj
        char *shmem = (char *)shmat(memid, NULL, 0);
        FILE*f=fopen(argv[1],"r");
        char linija[200];
        while(fgets(linija,200,f)!=NULL)
        {
            semop(sem1, &lock, 1);
            printf("Prvi proces salje liniju\n");
            strcpy(shmem,linija);
            semop(sem2, &unlock, 1);
        }
        fclose(f);
        semop(sem1, &lock, 1);
        strcpy(shmem,"\0");
        semop(sem2, &unlock, 1);
        shmdt(shmem);
        wait(NULL);
        shmctl(memid, IPC_RMID, 0);
        semctl(sem1, 0, IPC_RMID, 0);
        semctl(sem2, 0, IPC_RMID, 0);
    }
    else
    {
        //dete1
        char *shmem = (char *)shmat(memid, NULL, 0);
        while(1)
        {
            semop(sem2, &lock, 1);
            if(shmem[0]==0)
            {
                semop(sem1, &unlock, 1);
                break;
            }
            printf("Drugi proces procitao:\n%s\n",shmem);
            semop(sem1, &unlock, 1);
        }
        shmdt(shmem);
    }

}
