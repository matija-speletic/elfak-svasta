data segment
	niz dw 10 dup(?)
	mat dw 11h, 12h, 13h, 14h, 15h
		dw 21h, 22h, 23h, 24h, 25h
		dw 31h, 32h, 33h, 34h, 35h
		dw 41h, 42h, 43h, 44h, 45h
		dw 51h, 52h, 53h, 54h, 55h
	n db 5
	broj db 2
	pom dw 0
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

	xor bx, bx
	mov bp, 1
	mov cl, n
	xor ch, ch
	petlja1:
		push cx
		mov cl, n
		xor ch, ch
		xor si, si
		mov di, 1
		petlja2:
			cmp di, bp
			jbe bpvece
				mov dx, di
				sub dx, bp
				jmp ispod1
			bpvece:
				mov dx, bp
				sub dx, di
			ispod1:
			cmp dl, broj
			jne ispod2
				push di
				mov di, pom
				mov ax, mat[si][bx]
				mov niz[di], ax
				add pom, 2
				pop di
			ispod2:
			add si, 2
			inc di
		loop petlja2
		pop cx
		add bl, n
		adc bh, 0
		add bl, n
		adc bh, 0
		inc bp
	loop petlja1
	
	mov ax,4c00h
    int 21h
program ends
end start
