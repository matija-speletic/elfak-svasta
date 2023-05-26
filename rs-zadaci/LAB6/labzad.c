#include <stdio.h>

/*Napisati program na jeziku C u kome se deklarišu celobrojne promenljive A, B, C, D, E i F. Učitati vrednost promenljivih A, B i C sa tastature. Napisati proceduru na asemblerskom jeziku koja računa zbir tri broja preneta kao parametri i vraća rezultat preko EAX. Koristeći napisanu proceduru u glavnom programu izračunati D=A+B+C. U glavnom programu takođe izračunati pomoću naredbe dodele E=A*D - 4*B, a pomoću asemblerskog isečka F= A*D - 4*B.
Inicijalne vrednosti izabrati tako da se dobijaju netrivijalni* međurezultati i krajnji rezultat.

(*: netrivijalni - svi bajtovi sadrže značajne cifre, bajtovi međusobno različiti)

U dibageru posmatrati preveden program u obliku asemblerskog koda. 
Uporediti delove programa u kome se izračunava vrednost E i vrednost F. Da li postoje razlike u disasembliranom kodu ova dva dela programa?

Uočiti na koji način prevodilac realizuje pristup promenljivoj A**. 
(**:disasembliranu instrukciju u kojoj se pristupa toj promenljivoj iskopirati u komentar u izvorni program iza odgovarajuće naredbe.)

Izvršavati program u dibageru korak po korak. Pratiti promene vrednosti registara u toku izvršavanja programa. Pratiti promene u promenljivama u toku izvršavanja programa.
*/

extern int func(int a, int b, int c);
void funkcija(short* niz, int n, int c, int b);
/*
Primer1: (program radi ispravno)
	1 2 3 5 1 2 3 4 5
	37 89 549 11 1 2 3 4 5 6 7 8 9 10 11

Primer2: (program radi, ali ne radi kako treba jer nije namenjen za rad sa neoznacenim brojevima)
	(U RESENJU KOJE SAM PREDAO SAM GRESKOM NAPISAO OZNACENIM UMESTO NEOZNACENIM)
	-59 -78 -71 10 -7 -9 -8 1 4 8 9 7 9 77

Primer3: (prekoracenje - dobijeni rezultati nemaju smisla, jer granice prevazilae opseg int i short)
	2147483647 2147483647 2147483647 2 65536 65536

Primer4: (greska - citanje sa nedozvoljene lokacije)
	1 2 3 -2147483643 1 2 3 4 5
	(objasnjenje: broj elemenata je prenet kao negativan broj -> cuva se u potpunom komplementu
		-> asemblerski isecak ga posmatra kao pozitivan broj -> dolazi do pristupa nedefinisanim adresama
		, slicno se desi kada za br el unesemo npr 25)
*/

int main()
{
	char format[] = "%d, ";
	int A, B, C, D, E, F;

	scanf("%d%d%d", &A, &B, &C);
	D = func(A, B, C);
	printf(format, D);
	printf("\n");

	E = A * D - 4 * B;
	printf(format, E);
	printf("\n");

	/*
	mov eax,dword ptr [A]  //pristup promenljivoj A
	imul eax,dword ptr [D]  
	mov ecx,dword ptr [B]  
	shl ecx,2  
	sub eax,ecx  
	mov dword ptr [E],eax
	*/

	_asm
	{
		mov eax, A
		mul D
		mov ebx, B
		shl ebx, 1
		shl ebx, 1
		sub eax, ebx
		mov F, eax

		push eax
		lea ecx, format
		push ecx
		call dword ptr printf //printf(format, eax)
		pop eax
		pop eax
	}
	printf("\n");


	/*
	Ukoliko program funkcioniše ispravno, dodati u njega sledeće (funkcionalnosti treba da se realizuju nakon obrade koja je opisana iznad):
Deklarisati niz celobrojnih elemenata tipa short.

Uneti sa tastature broj elemenata niza u promenljivu A i elemente niza u deklarisani niz.

Izvršiti množenje svih elemenata niza koji su manji od C promenljivom B. Ovo postići C funkcijom čije je celo telo realizovano asemblerskim isečkom.

Napisati asemblerski isečak koji prikazuje rezultujući niz obilaskom niza i pozivanjem funkcije printf.
	*/
	//DRUGI DEO
	short niz[20];
	short* ptrniz = niz;
	scanf("%d", &A);//broj elemenata
	int i = 0;
	for (i = 0; i < A; i++)
		scanf("%d", &niz[i]); //niz+i

	funkcija(niz, A, C, B);
	
	_asm
	{
		mov ecx, A
		mov esi, ptrniz
		petlja:
		push ecx
		push esi
			mov eax, 0
			mov ax, [esi]
			push eax
			lea eax, format
			push eax
			call dword ptr printf
			pop eax
			pop eax
		pop esi
		add esi, 2
		pop ecx
		loop petlja
	}
	printf("\n");

}

void funkcija(short* niz, int n, int c, int b)
{
	_asm
	{
		push eax
		push ebx
		push ecx
		push edx
		push esi
		pushf

		mov ebx, c
		mov ecx, n
		mov esi, niz
		petlja:
			mov dx, [esi]
			cmp [esi], bx
			jae veci
				mov eax, 0
				mov ax, [esi]
				mul b
				mov [esi], ax
			veci:
			add esi, 2
		loop petlja

		popf
		pop esi
		pop edx
		pop ecx
		pop ebx
		pop eax
	}
}


//asm fajl
.386
.model flat, c
public func
.code


	func proc
	push ebp
	mov ebp, esp
	pushf
	
	mov eax, [ebp+8]
	add eax, [ebp+12]
	add eax, [ebp+16]

	popf
	pop ebp
	ret
func endp
end
