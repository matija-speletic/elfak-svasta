#include <stdio.h>

/*Написати програм на C и асемблерком језику који исписује на екран k
елемената Фибоначијевог низа почев од n-тог елемента. Вредности k и
n се учитавају са тастатуре. За рачунање елемената фибоначијевог низа
користити inline асемблерски исечак који и исписује елементе
позивањем библиотечке функције printf језика C.
Фибоначијев низ је описан на следећи начин: елементи 1 и 2 су једнаки
јединици. Сваки следећи елеменат је једнак збиру претходна два
елемента.*/

//extern int func(char* ulniz, char br, int* broj);

int main()
{
	int n = 15;
	//int f1, f2, f;
	//scanf("%d", &n);
	char format[] = "%d, ";
	_asm
	{
		mov ecx, n
		mov eax, 1
		mov ebx, 1
	petlja:
		push eax
		push ebx
		mov n, ecx
		push ebx
		lea edx, format
		push edx
		call dword ptr printf
		pop eax
		pop eax
		pop ebx
		pop eax
		mov ecx, n
		mov edx, eax
		add eax, ebx
		mov ebx, edx
		loop petlja

	}
}