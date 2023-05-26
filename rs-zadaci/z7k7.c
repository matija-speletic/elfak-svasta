#include <stdio.h>
#include <string.h>

extern int funkcija(int n, int mat[4][4]);

/*Na jeziku C napisati program koji popunjava zadatu matricu celobrojnim
elementima (tipa int) koji su jednaki zbiru prvog i drugog indeksa. Matrica je veličine
4x4 i nije inicijalizovana na početku. Za zadatu matricu pozvati asemblersku
proceduru koja računa razliku zbira elemenata na glavnoj dijagonali i zbira elemenata
na sporednoj dijagonali. Ulazni parametri procedure su adresa matrice i dimenzija
matrice, a izlazni parametar je suma koja se vraća preko registra EAX. Glavni
program treba da prikaže izračunati zbir na ekranu. */

void main()
{
	int i, j, n = 4;
	int mat[4][4];
	for (i = 0; i < n; i++)
		for (j = 0; j < n; j++)
			mat[i][j] = i + j;
	printf("%d", funkcija(n, mat));

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
push ebx
push ecx
push edx
push edi
push esi

mov ebx, [ebp+12]
mov ecx, [ebp+8]
mov edi, ecx
shl edi, 1
shl edi, 1
mov esi, 0
mov edx, 0
mov eax, 0
mov ebp, edi
sub edi, 4
petlja:
add eax, [ebx][esi]
add edx, [ebx][edi]
add ebx, ebp
add esi, 4
sub edi, 4
loop petlja
sub ax, dx

pop esi
pop edi
pop edx
pop ecx
pop ebx
popf
pop ebp
ret
funkcija endp
end
