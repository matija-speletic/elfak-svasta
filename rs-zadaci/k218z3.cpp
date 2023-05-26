#include <stdio.h>

unsigned int bcdtoi(const char* niz, const unsigned	int n)
{
	int pom;
	_asm
	{
		mov esi, niz
		add esi, n
		dec esi
		xor eax, eax
		mov ecx, n
		petlja:
			mov bx, 10
			mul bx
			xor ebx, ebx
			mov bl, byte ptr [esi]
			add eax, ebx
			dec esi
		loop petlja
	}
}
int main()
{
	char niz[] = { 4,2,9,0,2 };
	int n = 5;
	printf("%d", bcdtoi(niz, n));
}