
extrn func:far
data segment
	niz db 2, 5, 7, 38h, 24h, 7h, 86h, 9
	n dw 8
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

	
	;7.priprema ulaznih parametara
	mov ax, 0ah
	push ax
	mov ax, 2
	push ax
	lea ax, niz
	push ax
	lea ax, n
	push ax
	;8.
	call func
	;9.preuzimanje ulaznih parametara
	
	mov ax,4c00h
    int 21h
program ends
end start
