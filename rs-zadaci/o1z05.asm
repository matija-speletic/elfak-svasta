;Napisati asemblerski program za izračunavanje izraza:

;( 1*3 + 2*4 + 3*5 + ... + (n-1)*(n+1) ) / n^2

;pri čemu je n 8-bitni broj zadat na lokaciji N, proizvodi su 16-bitni brojevi, a zbir proizvoda je 32-bitni broj. Rezultat deljenja smestiti na lokaciju REZ, a ostatak na lokaciju
;OST. NAPOMENA: Nije dozvoljeno korišćenje pomoćnih memorijskih lokacija.
name o3z05
data segment
	n   db 9
	rez dw ?
	ost dw ?
data ends
code segment
	assume cs:code, ds:data
start:
	mov ax, data
	mov ds, ax
	
	cmp n, 2
	jb krajprograma ;prekidanje programa ako je n<2
	
	mov bl, 2
	xor cx, cx
	xor dx, dx
	
	petlja:
		mov al, bl ;AL <- BL
		dec al	   ;AL <- n-1
		inc bl	   ;BL <- n+1
		mul bl	   ;AX <- (n-1)*(n+1)
		add cx, ax
		adc dx, 0  ;DX:CX <- DX:CX + (n-1)*(n+1)
	cmp bl, n
	jbe petlja
	
	mov al, n
	mul al
	mov bx, ax ;BX <- n*n
	mov ax, cx
	div bx
	
	mov rez, ax
	mov ost, dx
	
	krajprograma:
	mov ah, 4ch
	int 21h
code ends
end start