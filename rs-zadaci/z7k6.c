#include <stdio.h>
#include <string.h>

extern unsigned short nzd(unsigned short* a, unsigned short* b);

/*Написати програм на C језику који налази и исписује све парове узајамно
простих бројева у низу бројева типа short. Број елемената низа и елементи низа
се уносе са екрана. Сматрати да се уносе само позитивни бројеви. За утврђивање
информације да ли су два елемента узајамно прости бројеви позивати процедуру
написану на асемблерском језику која одређује највећи заједнички делиоц
(НЗД) два шеснаестобитна броја Гаусовом методом. По Гаусовом методу, НЗД
се може одредити следећим итеративним поступком:  */

void main()
{
	int i, j, n = 10;
	unsigned short niz[] = { 6,8,9,10,12,14,15,16,18,20 };
	for (i = 0; i < n - 1; i++)
		for (j = i + 1; j < n; j++)
			//if (nzd(&niz[i], &niz[j]) == 1)
				printf("(%hd, %hd) = %hd\n", niz[i], niz[j], nzd(&niz[i], &niz[j]));
}

//asm
.386
.model flat, c
public nzd
.code
nzd proc
push ebp
mov ebp, esp
pushf
push ebx
push esi

mov eax, 0
mov ebx, 0
mov esi, [ebp+8]
mov ax, [esi]
mov esi, [ebp+12]
mov bx, [esi]
petlja:
cmp ax, bx
je kraj
cmp ax, bx
ja axvece
sub bx, ax
jmp petlja
axvece:
sub ax, bx
jmp petlja
kraj:

pop esi
pop ebx
popf
pop ebp
ret
nzd endp
end
