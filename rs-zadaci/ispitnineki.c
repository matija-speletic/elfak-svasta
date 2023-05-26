#include <stdio.h>

/*Napisati funkciju na jeziku C koja prebrojava elemente niza šesnaestobitnih elemenata koji imaju
osobinu da im je n bitova najmanje težine u binarnom zapisu jednako jedinici. Adresa niza, broj
elemenata i n su parametri procedure. Celo telo funkcije realizovati jednim asemblerskim
isečkom. Napisati program na jeziku C koji učitava niz i n, a zatim prikazuje broj elemenata sa
datom osobinom. Poziv procedure i prikaz rezultata obaviti u okviru asemblerskog isečka.*/

//extern int func(char* ulniz, char br, int broj);

int count(short* niz, int brel, int n)
{
	char format[] = "%d, ";
	_asm
	{
		mov esi, niz
		mov ecx, brel
		mov edx, 0

		petlja:
			mov eax, [esi]
			clc
			mov ebx, 0

			petlja2:
				rcr eax, 1
				jc jedan
				jmp kraj
				jedan:
				inc ebx
			jmp petlja2
			kraj:

			add esi, 2
			cmp ebx, n
			jne nije
				inc edx

				//sve do nije labele nije potrebno, to je samo za stampanje elemenata
				push edx
				push esi
				push ecx

				xor eax, eax
				mov ax, [esi-2]
				push eax
				lea eax, format
				push eax
				call dword ptr printf
				pop eax
				pop eax

				pop ecx
				pop esi
				pop edx
			nije:
		loop petlja
		mov eax, edx
	}
}

int main()
{
	short niz[] = { 8,74,7,39,55,88,44,23,24,231,167,98 };
	int brel = 12;
	int n = 3;
	printf("%d", count(niz, brel, n));
}