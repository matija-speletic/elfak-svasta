extrn func:far
data segment
	niz db 1,1,1,2,2,2,2,2,3,3,4,5
	n dw 12
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
	push n
	;8.
	call func
	;9.preuzimanje ulaznih parametara
	mov dx, ax
	
	mov ax,4c00h
    int 21h
program ends
end start

;1. Napisati potprogram za sabiranje elemenata jednog niza od N elemenata i iz glavnog
;programa izvr{iti poziv prenosom parametara preko zajedni~ke memorijske oblasti. 