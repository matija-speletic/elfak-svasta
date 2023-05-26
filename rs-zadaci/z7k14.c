#include <stdio.h>

extern void funkcija(char ulniz[], short izniz[], int n, char skalar);

/*Napisati proceduru na asemblerskom jeziku za 32-bitne procesore koja ima
ekvivalentan C intefejs: void funkcija(char ulniz[], short izniz[], int n, char skalar).
Procedura treba da pomnoži svaki element prvog niza skalarom i proizvod smesti u
drugi niz. Napisati program na programskom jeziku C koji zahteva unos broja
elemenata i vrednosti elemenata niza brojeva tipa char. Zatim korišćenjem napisane
procedure odrediti proizvod niza i celobrojne srednje vrednosti elemenata niza.
Izračunavanje srednje vrednosti obaviti u jednom asemblerskom isečku.
NAPOMENA: Smatrati da je zbir elemenata niza najviše 16-bitni podatak. */

//z7k14
int main()
{
	int n, i;
	char ulniz[10], skalar=3;
	short izniz[10];
	//int* ptr = izniz;
	scanf("%d", &n);
	//scanf("%d", &skalar);
	for (i = 0; i < n; i++)
		scanf("%d", &ulniz[i]);
	_asm
	{
		lea esi, ulniz
		mov ecx, n
		mov eax, 0
	petlja1:
		xor edx, edx
		mov dl, [esi]
		inc esi
		add eax, edx
		loop petlja1
		mov edx, n
		div dl
		mov skalar, al
	}
	printf("%d\n", skalar);
	funkcija(ulniz, izniz, n, skalar);
	char format[] = "%hd, ";
	_asm
	{
		mov ecx, n
		lea esi, izniz
		petlja:
		push esi
		push ecx
		xor eax, eax
		mov ax, [esi]
		push eax
		lea eax, format
		push eax
		call dword ptr printf
		pop eax
		pop eax
		pop ecx
		pop esi
		add esi, 2
		loop petlja
	}
}


//asm
.386
.model flat, c
public funkcija
.code

funkcija proc
push ebp
mov ebp, esp
pushf
push eax
push ebx
push ecx
push esi
push edi

mov ecx, [ebp+16]
mov esi, [ebp+8]
mov edi, [ebp+12]
mov ebx, [ebp+20]
petlja:
xor eax, eax
mov al, [esi]
mul bl
mov [edi], ax
inc si
add edi, 2
loop petlja

pop edi
pop esi
pop ecx
pop ebx
pop eax
popf
pop ebp
ret
funkcija endp
end
