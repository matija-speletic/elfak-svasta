#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/shm.h>
#include <sys/ipc.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <sys/msg.h>
#include <string.h>

#define MAX_PORUKA 255

int redid;
struct poruka
{
	long tip;
	char txt[MAX_PORUKA];
};

void alarmHandler()
{
    time_t t;
    struct poruka buf;
    buf.tip=1;
    time(&t);
    printf("Vreme je %s\n",ctime(&t));
    strcpy(buf.txt,ctime(&t));
    msgsnd(redid,&buf,sizeof(struct poruka),0);
}

void ctrlcHandler()
{
    struct poruka buf;
    buf.tip=1;
    msgrcv(redid, &buf, sizeof(buf), 0, 0);
    sleep(5);
    printf("alarm je istekao u %s",buf.txt);
    msgctl(redid, IPC_RMID, NULL);
    exit(0);
}

int main()
{
    signal(SIGALRM,alarmHandler);
    signal(SIGINT,ctrlcHandler);
    alarm(5);
    for(;;)
        pause();
}
