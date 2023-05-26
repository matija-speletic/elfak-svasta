#include <stdio.h>

extern void func(short* niz, int n);

/*Napisati proceduru na asemblerskom jeziku za 32-bitne procesore koja računa 32-bitnu
sumu elemenata niza 16-bitnih neoznačenih brojeva i smešta sumu na mesto prva dva
elementa niza. Napisati strukturni program na programskom jeziku C koji traži od
korisnika dimenzije i elemente matrice brojeva tipa unsigned short. Zatim,
korišćenjem napisane procedure, izračunati sume vrsta matrice kao brojeve tipa
unsigned int i smestiti ih u poseban niz. Nakon obrade, matrica treba da sadrži
nepromenjene vrednosti elemenata. Prikazati matricu i niz suma nakon završene obrade. */


int main()
{
	unsigned short mat[3][3] = { 0xffff,2,3,4,5,6,7,8,9 };
	int i, j, n=3;
	unsigned int niz[3];
	for (i = 0; i < n; i++)
	{
		func(mat[i], n);
		niz[i] = mat[i][1];
		niz[i] = niz[i] << 16;
		niz[i] += mat[i][0];
	}
	printf("Rezultujuca matrica:\n");
	for (i = 0; i < n; i++)
	{
		for (j = 0; j < n; j++)
			printf("%d ", mat[i][j]);
		printf("\n");
	}
	printf("Zbirovi vrsta:\n");
	for (i = 0; i < n; i++)
	{
		printf("%d \n", niz[i]);
	}
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
push ecx
push esi
push edx
	
mov eax, 0
mov esi, [ebp+8]
mov ecx, [ebp+12]
petlja:
xor edx, edx
mov dx, [esi]
add eax, edx
add esi, 2
loop petlja
mov esi, [ebp+8]
mov [esi], eax

pop edx
pop esi
pop ecx
pop eax
popf
pop ebp
ret
func endp
end
