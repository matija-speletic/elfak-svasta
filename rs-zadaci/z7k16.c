#include <stdio.h>

//extern void func(int vec1[], int vec2[], int* mul);

/*Napisati proceduru na programskom jeziku C čije telo je realizovano jednim asemblerskim
isečkom za 32-bitne procesore koja ima interfejs: int funkcija(short ulniz[], int n, short scalar).
Procedura treba da izračuna tridesetdvobitni zbir svih pozitivnih elemenata niza koji su veći od
zadate vrednosti skalara. Napisati program na programskom jeziku C koji zahteva unos matrice
brojeva, a zatim formira niz sastavljen od suma onih pozitivnih elemenata svake vrste matrice koji su
veći od prvog elementa odgovarajuće vrste. */

int funkcija(short ulniz[], int n, short scalar)
{
	_asm
	{
		mov eax, 0
		mov esi, ulniz
		mov ecx, n
		mov bx, scalar
		petlja:
		cmp word ptr [esi], 0
			jle dalje
			cmp word ptr [esi], bx
			jle dalje
			mov edx, 0
			mov dx, [esi]
			add eax, edx
			dalje:
		add esi, 2
			loop petlja
			//ret
	}
}

int main()
{
	short mat[8][8];
	int i, j, n = 8, niz[8];
	for (i = 0; i < n; i++)
		for (j = 0; j < n; j++)
			scanf("%hd", &mat[i][j]);
	for (i = 0; i < n; i++)
		niz[i] = funkcija(&mat[i][0], n, mat[i][0]);
	for (i = 0; i < n; i++)
		printf("%d, ", niz[i]);
}


//asm
.386
.model flat, c
public func
.code

	func proc
	push ebp
	mov ebp, esp
	pushf
	push eax
	push ebx
	push ecx
	push edx
	push edi
	push esi
	
	mov edi, [ebp+16]
	mov ecx, [edi]
	mov edi, [ebp+8]
	mov esi, [ebp+12]
	mov ebx, 0
petlja:
	mov eax, [esi]
	add esi, 4
	mul dword ptr [edi]
	add edi, 4
	add ebx, eax
	loop petlja
	mov esi, [ebp+16]
	mov [esi], ebx

	pop esi
	pop edi
	pop edx
	pop ecx
	pop ebx
	pop eax
	popf
	pop ebp
	ret
func endp
end
