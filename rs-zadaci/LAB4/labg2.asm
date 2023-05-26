extrn func:far
data segment
	x db 17
	y db 37
	z db 18
	rez db ? ;FF...FFDA
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

	

	mov al, x
	cbw
	push ax
	mov al, y
	cbw
	push ax
	call func
	push ax ;prvi medjurezultat je vec u AX
	mov al, z
	cbw
	push ax
	call func
	mov rez, al

	
	mov ax,4c00h
    int 21h
program ends
end start
