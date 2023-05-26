#include <stdio.h>

/*На језику C написати програм који попуњава задату матрицу
целобројним елементима (типа int) који су једнаки остатку при дељењу
првог индекса другим индексом. Матрица је величине 5x5 и није
иницијализована на почетку. За сваку врсту формиране матрице
позвати асемблерску процедуру која рачуна збир елемената низа.
Улазни параметри процедуре су адреса низа и број елемената низа, а
излазни параметар је сума која се враћа преко регистра EAX. Збирове
елемената врста матрице главни програм треба да приказује на екрану.
*/

extern int func(int* ulniz, int br);

int main()
{
	int mat[5][5];
	int i, j;
	for (i = 0; i < 5; i++)
		for (j = 0; j < 5; j++)
			mat[i][j] = (i + 1) % (j + 1);
	for (i = 0; i < 5; i++)
	{
		for (j = 0; j < 5; j++)
			printf("%d ", mat[i][j]);
		printf("\n");
	}
	for (i = 0; i < 5; i++)
	{
		int sum = func(mat[i], 5);
		printf("%d, ", sum);
	}
}

/*
.386
.model flat, c
public func
.code

 ;extern int func(int* ulniz, int br);

	func proc
	push ebp
	mov ebp, esp
	pushf
	push ecx
	;push ebx
	push esi
	;push edi

	xor eax, eax
	mov ecx, [ebp+12]
	mov esi, [ebp+8]
	petlja:
	add eax, [esi]
	add esi, 4
	loop petlja
	
	;pop edi
	pop esi
	;pop ebx
	pop ecx
	popf
	pop ebp
	ret
func endp
end

*/