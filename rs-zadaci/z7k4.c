#include <stdio.h>
#include <string.h>

//extern int funkcija(char ulniz[], char podatak, int n);

/*Написати програм на C и асемблерком језику који исписује на екран k елемената Фибоначијевог
низа почев од n-тог елемента. Вредности k и n се учитавају са тастатуре. За рачунање 
елемената фибоначијевог низа користити inline асемблерски исечак који и исписује елементе 
позивањем библиотечке функције printf језика C. Фибоначијев низ је описан на следећи начин:
елементи 1 и 2 су једнаки јединици. Сваки следећи елеменат је једнак збиру претходна два 
елемента. */

void main()
{
	int n, k;
	char format[] = "%d, ";
	scanf("%d%d", &n, &k);
	_asm
	{
		mov eax, 1
		mov ebx, 1
		mov ecx, 0
		mov edx, 0
		mov esi, 0
		petlja:
		cmp esi, k
			jae kraj
			mov ecx, eax
			add ecx, ebx
			mov eax, ebx
			mov ebx, ecx
			inc edx
			cmp edx, n
			jb petlja
			push eax
			push ebx
			push ecx
			push edx
			push esi
			push eax
			lea edi, format
			push edi
			call dword ptr printf
			pop edi
			pop edi
			pop esi
			pop edx
			pop ecx
			pop ebx
			pop eax
			inc esi
			jmp petlja
			kraj:
	}
}