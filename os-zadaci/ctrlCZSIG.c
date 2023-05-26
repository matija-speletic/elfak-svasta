//Korišćenjem programskog jezika C napisati UNIX/Linux program koji može da se prekine samo ako se kombinacija tastera Ctrl-C pritisne pet puta za redom. Ukoliko korisnik pritisne kombinaciju tastera Ctrl-Z dva puta zaredom program na ekranu ispisuje koliko puta do sada je pritisnuto Ctrl-C.

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/shm.h>
#include <sys/ipc.h>
#include <sys/types.h>
#include <sys/wait.h>

#define LIMIT 5

int brPritisnutih=0;

void ctrlcHandler()
{
    brPritisnutih++;
    if(brPritisnutih==LIMIT)
        exit(0);
}

void ctrlzHandler()
{
    printf("\nCtrl+C ste pritisnuli %d puta\n",brPritisnutih);
}

int main()
{
    signal(SIGTSTP,ctrlzHandler);
    signal(SIGINT,ctrlcHandler);
    for(;;)pause();
}
