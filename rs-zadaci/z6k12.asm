extern zameni:far
data segment
	mat dw 3369h, 7162h, 7998h, 1665h
		dw 5299h, 7012h, 6139h, 9441h
		dw 5795h, 3866h, 8320h, 4034h
		dw 6235h, 2141h, 7353h, 3527h
	n   db 4
data ends
stack segment
		dw 200 dup(?)
	dno label word
stack ends
code segment
	assume cs:code, ds:data, ss:stack
start:
	mov ax, data
	mov ds, ax
	mov ax, stack
	mov ss, ax
	
	mov cl, n
	mov ch, 0
	lea si, mat
	mov dl, n
	mov dh, 0
	petlja:
		push dx
		call zameni
		add si, dx
		add si, dx
	loop petlja
	
	mov ah, 4ch
	int 21h
code ends
end start