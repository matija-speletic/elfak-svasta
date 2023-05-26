#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/shm.h>
#include <sys/ipc.h>
#include <sys/types.h>
#include <sys/wait.h>
FILE* f;

void citaj();
void pisi();


int pid;
int parentPID;
int i=1;
int main()
{
parentPID=getpid();
if((pid = fork()) != 0) //parent,prvi
{
signal(SIGUSR1,pisi);

while(i != 5)
pause();

wait(NULL);
}
else  //child,drugi
{
sleep(2);
signal(SIGUSR2,citaj);
kill(parentPID,SIGUSR1); //slanje signala SIGUSR1
while(i != 5)
pause();

}

}



void citaj()
{
int broj;
f = fopen("prenos.dat", "r");
for(int j=0;j<10;j++)
{
fscanf(f, "%d", &broj);
printf("%d ",broj);
}
printf("\n");
fflush(stdout);
fclose(f);
i++;
kill(parentPID,SIGUSR1); //slanje signala SIGUSR1



}



void pisi()
{
int broj;
f = fopen("prenos.dat", "w");
for(int j=0;j<10;j++)
{
broj = rand() % 1000;
fprintf(f,"%d\n",broj);
}
fclose(f);
i++;
kill(pid,SIGUSR2);
//pause();



}
