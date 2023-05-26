extern zameni:far
data segment
	mat dw 3369h, 7162h, 7998h, 1665h
		dw 5299h, 7012h, 6139h, 9441h
		dw 5795h, 3866h, 8320h, 4034h
		dw 6235h, 2141h, 7353h, 3527h
	n   dw 4
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
	
	mov ax, n
	dec ax
	mul n
	shl ax, 1
	mov bp, ax
	mov bx, 0
	mov si, 0
	mov cx, n
	mov dx, n
	shl dx, 1
	petlja:
		lea ax, mat[bx][si]
		push ax
		lea ax, mat[bp][si]
		push ax
		call zameni
		add si, 2
		add bx, dx
		sub bp, dx
	loop petlja
	
	mov ah, 4ch
	int 21h
code ends
end start