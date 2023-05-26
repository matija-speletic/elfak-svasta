extrn func:far
data segment
	niz dw 0, 1, 2, 3, 4, 5, 6, 7
	n dw 8
	k dw 2
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
	push k
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
