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

//extern int func(char* ulniz, int br);

int func1(char* ulniz, int br)
{
	int i;
	_asm
	{
		mov ecx, br
		mov esi, ulniz
		mov edi, esi
		add edi, ecx
		dec edi
		shr ecx, 1
		petlja:
			mov bl, [esi]
			cmp bl, [edi]
			jne nije
			inc esi
			dec edi
			loop petlja
			mov i, 1
			jmp kraj

			nije :
			mov i, 0

				kraj :
			
	}
	return i;
}

int main()
{
	char string[] = "ana je palindrom, anavolimilovana, asm kod, pallap programargorp ovo nisu reci";
	char* token = strtok(string, " .,");
	while (token != NULL) 
	{
		if (func1(token, strlen(token)))
			printf("%s, ", token);
		token = strtok(NULL, " .,");
	}
}




/*
.386
.model flat, c
public func
.code

 ;extern int func(char* ulniz, int br);

	func proc
	push ebp
	mov ebp, esp
	pushf
	push ecx
	push ebx
	push esi
	push edi

	mov ecx, [ebp+12]
	mov esi, [ebp+8]
	mov edi, esi
	add edi, ecx
	dec edi
	shr ecx, 1
	petlja:
		mov bl, [esi]
		cmp bl, [edi]
		jne nije
		inc esi
		dec edi
	loop petlja
	mov eax, 1
	jmp kraj

	nije:
	mov eax, 0

	kraj:
	pop edi
	pop esi
	pop ebx
	pop ecx
	popf
	pop ebp
	ret
func endp
end

*/