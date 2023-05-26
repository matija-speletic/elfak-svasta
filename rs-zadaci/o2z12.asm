;Napisati proceduru na asemblerskom jeziku za prevođenje niza ASCII karaktera određene dužine koji se sastoji samo od dekadnih cifara u neoznačeni 16-bitni broj. 
;Parametri procedure su adresa niza i broj elemenata, dok se rezultat vraća preko registra AX. 
;U glavnom programu korišćenjem ove procedure odrediti vrednost izraza zadatog kao niz ASCII karaktera počevši od adrese EXPR. 
;Ovaj niz karaktera može da sadrži dekadne cifre i karaktere '+' i '-'. Kraj niza određen je karakterom '='. 
;Između karaktera '+' i/ili '-' mora se nalaziti bar jedna cifra. Izračunatu 16-bitnu vrednost izraza smestiti na lokaciju VAL.

extrn func:far
data segment
	izr db '1234+5678-910='
	vel dw 0
data ends
stack segment
	dw 200 dup(?)
	dno label word
stack ends
program segment
    assume cs:program, ds:data, ss:stack
start:
	mov ax, data
	mov ds, ax
	mov ax, stack
	mov ss, ax
	lea sp, dno

	lea si, izr
	lea di, izr
	mov bx, 0 ; bh=0 - add, bh=1 - sub, bl=offh - =
	petlja:
		cmp byte ptr [si], '+'
		jne nijeplus
			mov bh, bl
			mov bl, 0
			jmp broj
		nijeplus:
		cmp byte ptr [si], '-'
		jne nijeminus
			mov bh, bl
			mov bl, 1
			jmp broj
		nijeminus:
		cmp byte ptr [si],'='
		jne nijejed
			mov bh, bl
			mov bl,0ffh
			jmp broj
		nijejed:
		inc si
		jmp petlja
		
		broj:
		push di
		mov dx, si
		sub dx, di
		push dx
		call func
		cmp bh, 0
		jne nije1
			add vel, ax
		nije1:
		cmp bh, 1
		jne nije2
			sub vel, ax
		nije2:
		cmp bl, 0ffh
		je kraj
		inc si
		mov di, si
	jmp petlja
	kraj:
		
	
	mov ax,4c00h
    int 21h
program ends
end start
