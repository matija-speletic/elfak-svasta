//Korišćenjem programskog jezika C napisati Linux/UNIX program koji kreira dodatni process sa kojim komunicira dvosmerno korišćenjem jednog reda poruka. Proces roditelj iz datoteke čije je ime prosleđeno kao argument komandne linije čita liniju po liniju teksta i svaku liniju šalje procesu detetu u posebnoj poruci. Proces dete u svakoj primljenoj liniji prebrojava broj pojavljivanja velikih slova abecede i procesu roditelju vraća kroz isti red poruka za svaku analiziranu liniju teksta kroz posebnu poruku redni broj linije i broj pojavljivanja velikih slova. Glavni program te podatke štampa na ekranu (redni broj linije i broj pojavljivanja velikih slova). Kada se analiziraju sve linije teksta iz datoteke glavni program na ekranu treba da odštampa “KRAJ”.

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <string.h>

#define RED_PORUKA 10301
#define MAX_PORUKA 255

struct msgNum
{
	long tip;
	int broj;
};

struct msgTxt
{
	long tip;
	char txt[MAX_PORUKA];
};

int main(int argc,char* argv[])
{
    int redid=msgget(RED_PORUKA, IPC_CREAT | 0666);
    if(fork()!=0)
    {
        //roditelj
        struct msgTxt bufTxt;
        bufTxt.tip=1;
        FILE* f=fopen(argv[1],"r");
        while(!feof(f))
        {
            char linija[MAX_PORUKA];
            fgets(linija,MAX_PORUKA,f);
            strcpy(bufTxt.txt,linija);
            msgsnd(redid,&bufTxt,sizeof(bufTxt),0);
            printf("Saljem %s\n",bufTxt.txt);
            //sleep(1);
        }
        fclose(f);
        strcpy(bufTxt.txt,"");
        msgsnd(redid,&bufTxt,sizeof(bufTxt),0);
        printf("Saljem %s\n",bufTxt.txt);
        printf("Prvi proces zavrsio upisivanje\n");
        wait(NULL);
        int broj;
        struct msgNum bufNum;
        bufNum.tip=2;
        while(1)
        {
            msgrcv(redid, &bufNum, sizeof(bufNum), 2, 0);
            broj=bufNum.broj;
            if(broj==-1)break;
            printf("Linija %d ",broj);
            msgrcv(redid,&bufNum,sizeof(bufNum),2,0);
            broj=bufNum.broj;
            if(broj==-1)break;
            printf("ima %d velikih slova\n",broj);
        }
        msgctl(redid, IPC_RMID, NULL);
        printf("KRAJ\n");
    }
    else
    {
        //dete

        struct msgTxt bufTxt;
        struct msgNum bufNum;
        bufTxt.tip=1;
        bufNum.tip=2;
        char linija[MAX_PORUKA];
        int brLinije=1;
        while(1)
        {
            msgrcv(redid, &bufTxt, sizeof(bufTxt), 1, 0);
            if(bufTxt.txt[0]=='\0')break;
            strcpy(linija,bufTxt.txt);
            printf("Dete procitalo %s\n",linija);
            bufNum.broj=brLinije++;
            msgsnd(redid,&bufNum,sizeof(bufNum),0);
            int brVelikih=0;
            for(int i=0;linija[i];i++)
                if(linija[i]>='A'&&linija[i]<='Z')
                    brVelikih++;
            bufNum.broj=brVelikih;
            msgsnd(redid,&bufNum,sizeof(bufNum),0);
        }
        bufNum.broj=-1;
            msgsnd(redid,&bufNum,sizeof(bufNum),0);
    }
}











