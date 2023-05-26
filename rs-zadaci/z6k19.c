#include <stdio.h>

extern void func(int vec1[], int vec2[], int* mul);

int main()
{
	int niz1[] = { 1,2,3,4,5 };
	int niz2[] = { 5,4,3,2,1 };
	int vrednost = 5;
	func(niz1, niz2, &vrednost);
	printf("%d", vrednost);
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
