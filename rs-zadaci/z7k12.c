#include <stdio.h>
#include <string.h>

extern void funkcija(char ulniz[], char izniz[], int n);

/*Napisati proceduru na asemblerskom jeziku koja kopira tekst, čije adresu i broj
karaktera dobija preko parametara, u drugi tekst (adresu drugog teksta takođe dobija kao
parametar) uz izbacivanje svih višestrukih ponavljanja blanko karaktera. Na kraj
rezultujućeg teksta upisuje ASCII vrednost 0. Napisati program na jeziku C koji učitava
sa tastature jednu liniju teksta, a zatim korišćenjem napisane procedure menja učitanu
liniju tako da sva višestruka ponavljanja blanko karaktera zamenjuje jednim blanko
karakterom. Prikazati na ekranu rezultat obrade. Nije dozvoljeno korišćenje pomoćnih
promenljivih za tekst. */

void main()
{
	char str[100], str2[100];
	gets(str);
	int n = strlen(str);
	funkcija(str, str2, n);
	printf("%s", str2);
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
push eax
push ecx
push esi
push edi

mov ecx, [ebp+16]
mov esi, [ebp+8]
mov edi, [ebp+12]
petlja:
mov al, [esi]
inc esi
mov [edi], al
inc edi

cmp al, ' '
jne dalje
petljica:
cmp byte ptr [esi], ' '
jne dalje
inc esi
dec ecx
jmp petljica
dalje:

loop petlja
mov byte ptr [edi], 0

pop edi
pop esi
pop ecx
pop eax
popf
pop ebp
ret
funkcija endp
end

