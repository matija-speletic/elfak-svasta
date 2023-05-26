#include <stdio.h>

extern void funkcija(int niz[], int n);

/*4.06 Napisati proceduru na asemblerskom jeziku za 32-bitne procesore koja transformiše
ulazni niz 32-bitnih elemenata tako što invertuje binarni zapis svakog elementa niza – 
prethodni binarni zapis čitan s leva u desno zameniti istim zapisom čitanim s desna u levo.
Ulazni parametri su broj elemenata niza i adresa niza. Napisati program na jeziku C koji 
učitava elemente kvadratne matrice MAT dimenzije N. Koristeći napisanu proceduru, invertovati
binarni zapis svih elementata matrice na i ispod glavne dijagonale. Prikazati transformisanu
matricu. */

void main()
{
    int MAT[10][10], N, i, j;

    scanf("%d", &N);
    for (i = 0; i < N; i++)
        for (j = 0; j < N; j++)
            scanf("%d", &MAT[i][j]);
    for (i = 0; i < N; i++)
        funkcija(MAT[i], i+1);

    for (i = 0; i < N; i++)
    {
        for (j = 0; j < N; j++)
            printf("%d ", MAT[i][j]);
        printf("\n");
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

mov esi, [ebp+8]
mov ecx, [ebp+12]
petlja:
mov eax, [esi]
clc
push ecx
mov ecx, 32
petljica:
rcr eax, 1
rcl edx, 1
loop petljica
pop ecx
mov [esi], edx
add esi, 4
loop petlja

popf
pop ebp
ret
funkcija endp
end