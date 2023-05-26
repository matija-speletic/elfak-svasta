//Korišćenjem programskog jezika C napisati UNIX/Linux program koji od korisnika očekuje da sa tastature unese korisničko ime i lozinku. Ukoliko korisnik nakon unosa korisnickog imena ne unese lozinku u roku od 60 sekundi proces obaveštava korisnika da je vreme za unos lozinke isteklo i izlazi.

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/shm.h>
#include <sys/ipc.h>
#include <sys/types.h>
#include <sys/wait.h>

char user[40],pass[40];

void alarmHanler()
{
    printf("Vreme je isteklo!");
    exit(0);
}

int main()
{
    signal(SIGALRM,alarmHanler);
    printf("Username:");
    gets(user);
    printf("Password:");
    alarm(10);
    gets(pass);
    alarm(0);
    printf("Username: %s; Password: %s\n",user,pass);
    return 0;
}
