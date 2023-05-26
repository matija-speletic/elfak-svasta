;Napisati asemblerski program za izračunavanje izraza:

;( 1! / 1 ) + ( 2! / 2 ) + ( 3! / 4 ) + . . . + ( n! / 2^(n-1) )

;pri čemu je n 8-bitni broj zadat na lokaciji N, ogovarajuće faktorijele tretirati kao 32-bitne, odnosno 16-bitne brojeve, a stepene broja 2 kao 16-bitne brojeve. 
;Dobijeni rezultat (32-bitni broj) smestiti na lokaciju REZ.
name o3z13
data segment
	n   db 9
	rez dw 0, 0
data ends
code segment
	assume cs:code, ds:data
start:
	mov ax, data
	mov ds, ax
	
	mov si, 1
	mov di, 0
	mov bx, 1	;BX - stepeni 2
	mov cx, 1	;i = 1, n
	mov ax, 1
	xor dx, dx
	
	petlja:
		mov ax, si
		mul cx
		mov si, ax
		div bx
		add rez, ax
		adc rez+2, 0
		shl bx, 1
		inc cx
	cmp cl, n
	jbe petlja
	
	mov ah, 4ch
	int 21h
code ends
end start