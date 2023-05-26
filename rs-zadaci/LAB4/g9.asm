extrn func:far
data segment
	niz1 db 0,1,2,3,4,5,6,7
	niz2 db 3,4,5
	niz3 db 2,2,2
	n1 dw 8
	n2 dw 3
	n3 dw 3
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

	push n1
	push n2
	lea ax, niz1
	push ax
	lea ax, niz2
	push ax
	call func
	mov cx, dx
	
	push n1
	push n3
	lea ax, niz1
	push ax
	lea ax, niz3
	push ax
	call func
	
	
	mov ax,4c00h
    int 21h
program ends
end start
