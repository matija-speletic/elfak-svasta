extrn func:far
data segment
	v1 db 2, 5, 7, 38, 17
	v2 db 5, 75, 3, 12, 7
	n dw 5
	rez dw ?
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
	lea bx, v1
	push bx
	lea bx, v2
	push bx
	push n
	;8.
	call func
	;9.preuzimanje ulaznih parametara
	pop ax
	
	mov ax,4c00h
    int 21h
program ends
end start

;3. Napisti potprogram za mno`enje (matrice) vektora i vektora, poznatih dimenzija i rezultat smestiti na novu lokaciju. Iz glavnog programa pozvati potprogram, a prenos parametara izvr{iti bilo kojom metodom. 