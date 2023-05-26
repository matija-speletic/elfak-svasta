extern vrsta:far
data segment
	mat dw 1, 2, 3, 1
		dw -4, 5, 6, 2
		dw -7, 8, 9, -3
	n	dw 4
	m	dw 3
	zbir dd ?
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
	
	mov bx, 0
	mov cx, m
	mov bp, n
	shl bp, 1
	petlja:
		cmp mat[bx], 0
		jge dalje
			lea si, mat[bx]
			push si
			mov si, n
			push si
			call vrsta
			pop dx
			pop ax
		dalje:
		add bx, bp
	loop petlja
	mov word ptr zbir+2, dx
	mov word ptr zbir, ax
	
	mov ah, 4ch
	int 21h
code ends
end start