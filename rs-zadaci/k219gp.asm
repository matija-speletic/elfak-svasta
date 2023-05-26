extrn func:far
data segment
	niz db 1,4,2,5, 0ffh
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
	lea ax, niz
	push ax
	xor si, si
	petlja:
	cmp niz[si],0ffh
	je kraj
	inc si
	jmp petlja
	kraj:
	push si
	;8.
	call func
	;9.preuzimanje ulaznih parametara
	pop ax
	mov ax,4c00h
    int 21h
program ends
end start
