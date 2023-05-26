name zad6kol2004
extern skalar:far
data segment
	rez dw 16 dup(?)
	mat1 db 16, 4, 17, 11
		 db -2, 18, -19, -3
		 db 4, 10, -2, -11
		 db -16, -20, -14, -8
	mat2 db -14, -5, 19, 4
		 db 18, -6, -5, 9
		 db 10, 19, 9, 19
		 db 7, 18, 18, 13
	n db 4
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
	lea sp, dno
	
	mov bx, 0
	mov si, 0
	mov di, 0
	mov cl, n
	mov ch, 0
	mov bp, 0
	mov dx, cx
	petlja:
		mov si, 0
		mov di, 0
		push cx
		mov cx, dx
		petljica:
			lea ax, rez[bp][di]
			push ax
			lea ax, mat1[si]
			push ax
			lea ax, mat2[bx]
			push ax
			push dx
			call skalar
			add si, dx
			add di, 2
		loop petljica
		pop cx
		add bx, dx
		add bp, dx
		add bp, dx
	loop petlja
	
	mov ah, 4ch
	int 21h
code ends
end start
