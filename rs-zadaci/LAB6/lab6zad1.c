#include <stdio.h>

/*На језику C написати програм који сабира два 32-битна позитивна
броја. Сваки од бројева се учитава са тастатуре као низ карактера који
представља децимални запис броја. За конверзију низа карактера у број
написати процедуру на асемблерском језику којој се преко стека
прослеђује адреса низа карактера, број карактера у низу и адреса
резултата. Процедура преко регистра EAX враћа статус свог рада: 0 ако
је успешно преведен број, 1 ако превођење није могуће зато што неки
карактер у низу не представља цифру. Сматрати да не долази до
прекорачења*/

extern int func(char* ulniz, char br, int* broj);

int main()
{
	char brniz[] = "4251";
	int num;
	if (func(brniz, 4, &num) == 0)
		printf("%d", num);
	else
		printf("Greška");
}



//asm fajl
.386
.model flat, c
public func
.code

 ;extern int func(char* ulniz, char br, int* broj);

	func proc
	push ebp
	mov ebp, esp
	pushf
	push ecx
	push ebx
	push esi

	mov ecx, [ebp+12]
	mov esi, [ebp+8]
	xor eax, eax
	xor ebx, ebx
	petlja:
		mov ebx, eax
		shl eax, 1
		shl eax, 1
		shl eax, 1
		add eax, ebx
		add eax, ebx

		xor ebx, ebx
		mov bl, [esi]
		cmp bl, '0'
		jb greska
		cmp bl, '9'
		ja greska
		sub bl, '0'

		add eax, ebx
		inc esi
	loop petlja
	mov esi, [ebp+16]
	mov [esi], eax
	mov eax, 0
	jmp kraj

	greska:
		mov eax, 1
	kraj:
	

	pop esi
	pop ebx
	pop ecx
	popf
	pop ebp
	ret
func endp
end
