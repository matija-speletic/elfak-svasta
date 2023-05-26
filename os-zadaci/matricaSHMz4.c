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
#define ROWS 15
#define COLS 10

union semun
{
  int val;
  struct semid_ds *buf;
  ushort *array;
  struct seminfo * __buf;
  void * __pad;
};

//da bi se rezervisana memorija koristila kao matrica neophodno je kreirati indeks
void pretvoriUMatricu(int **m,int rows,int cols)
{
    m[0]=m+rows;
    for(int i=1;i<rows;i++)
    {
        m[i]=(m[i-1]+cols*sizeof(int));
    }
}

int main()
{
    struct sembuf lock = {0, -1, 0};
    struct sembuf unlock = {0, 1, 0};
    union semun opts;
    int sem2 = semget(DRUGI_KEY, 1, IPC_CREAT | 0666);
    opts.val = 0;
    semctl(sem2, 0, SETVAL, opts);
    int velicinaMem=ROWS*(sizeof(int*)+(COLS*sizeof(int)));
    int memid = shmget(MEM_KEY, velicinaMem, IPC_CREAT | 0666);

    if (fork()!=0)
    {
        //roditelj
        int **mat = shmat(memid, NULL, 0);
        pretvoriUMatricu(mat,ROWS,COLS);
        for(int i=0;i<ROWS;i++)
            for(int j=0;j<COLS;j++)
                mat[i][j]=rand()%100+100;

        printf("Generisana matrica:\n");
        for(int i=0;i<ROWS;i++)
        {
            for(int j=0;j<COLS;j++)
            {
                printf("%d ",mat[i][j]);
            }
            printf("\n");
        }


        semop(sem2, &unlock, 1);
        wait(NULL);
        shmdt(mat);
        shmctl(memid, IPC_RMID, 0);
        semctl(sem2, 0, IPC_RMID, 0);
    }
    else
    {
        //dete1
        semop(sem2, &lock, 1);
        //printf("p\n");
        int **mat = shmat(memid, NULL, 0);
        //printf("p\n");
        //pretvoriUMatricu(mat,ROWS,COLS);
        //printf("p\n");
        for(int i=0;i<ROWS;i++)
        {
            int currMax=0;
            for(int j=0;j<COLS;j++)
            {
                if(mat[i][j]>currMax)
                {
                    currMax=mat[i][j];
                }
            }
            printf("Maksimum u redu %d je %d\n",i,currMax);
        }
        shmdt(mat);
    }
}
