//Korišćenjem programskog jezika C napisati UNIX/Linux program koji simulira problem proizvođač/potrošač korišćenjem redova poruka (message-queues). Glavni program se deli u dva procesa. Prvi proces (proizvođač) kreira N slučajnih pozitivnih celih brojeva i šalje ih drugom procesu. N se određuje tokom izvršenja, takođe kao slučajan pozitivan ceo broj. Po završetku slanja, prvi proces šalje -1 kao kod za kraj. Drugi proces (potrošač) preuzima poslate brojeve iz poruka i štampa ih na standardnom izlazu.

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <string.h>

#define RED_PORUKA 10301
#define MAX_PORUKA 255

struct poruka
{
	long tip;
	char txt[MAX_PORUKA];
};

int main(int argc, char* argv[])
{
    int redid=msgget(RED_PORUKA, IPC_CREAT | 0666);
    char broj[10];
    sprintf(broj,"%d",RED_PORUKA);
    if(fork()==0)
    {
        execl("sept2020_1","sept2020_1",broj,NULL);
    }
    else if(fork()==0)
    {
        execl("sept2020_2","sept2020_1",broj,NULL);
    }
    wait(NULL);
    msgctl(redid, IPC_RMID, NULL);
}












