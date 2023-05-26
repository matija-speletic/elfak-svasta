public n, niz, suma
extrn func:far
data segment
	niz dw 2, 5, 7, 38, 224
	n dw 5
	suma dw ?
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

	;8.
	call func
	;9.preuzimanje ulaznih parametara
	
	mov ah, 4ch
	int 21h
program ends
end start

;1. Napisati potprogram za sabiranje elemenata jednog niza od N elemenata i iz glavnog
;programa izvr{iti poziv prenosom parametara preko zajedni~ke memorijske oblasti. 