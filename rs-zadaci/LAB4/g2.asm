extrn func:FAR
data segment
	niz db 54h, 0abh, 77h, 0abh, 43h, 0aah, 0abh
	n dw 7
	num db 0abh
data ends
stack segment
	dw 200 dup (?)
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
	
	mov al, num
	xor ah, ah
	push ax
	lea bx, niz
	push bx
	push n
	
	call func

	mov ah,4ch
	int 21h
code ends
end start

;2. Napisati potprogram za odre|ivanje broja ponavljanja znaka 5BH u nizu od N bajtova.
;Prenos parametara izvr{iti preko steka, a broj ponavljanja vratiti preko registra.