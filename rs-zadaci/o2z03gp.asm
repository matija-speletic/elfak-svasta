;Napisati proceduru za izračunavanje 16-bitne sume 8-bitnih elemenata. Parametri procedure su adresa niza, adresa na koju treba smestiti zbir i broj elemenata niza. 
;Koristeći realizovanu proceduru u glavnom programu izračunati sumu niza 16-bitnih elemenata. Kraj niza je određen vrednošću FFFFh. Prenos parametara izvršiti preko steka.

extrn func:far
data segment
	sum db 4 dup(0) ;ispada : 319b7h
	niz dw 2775h , 9290h , 7307h , 2701h , 6452h , 9717h , 7455h , 4174h , 1478h, 0ffffh
	pom db 9 dup(?)
	zbr dw ?
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

	mov si, 0
	mov di, 0
	petlja1:
		mov ax, niz[si]
		cmp ax, 0ffffh
		je kraj1
		mov pom[di], al
		inc di
		add si, 2
	jmp petlja1
	kraj1:
	lea ax, zbr
	push ax
	lea ax, pom
	push ax
	push di
	call func
	mov bx, zbr
	
	mov si, 0
	mov di, 0
	petlja2:
		mov ax, niz[si]
		cmp ax, 0ffffh
		je kraj2
		mov pom[di], ah
		inc di
		add si, 2
	jmp petlja2
	kraj2:
	lea ax, zbr
	push ax
	lea ax, pom
	push ax
	push di
	call func
	mov dx, zbr
	
	mov sum, bl
	mov sum+1, bh
	add sum+1, dl
	adc sum+2, dh
	adc sum+3, 0
	
	mov ax,4c00h
    int 21h
program ends
end start
