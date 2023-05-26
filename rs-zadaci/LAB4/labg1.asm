extrn func:far
data segment
	;PRIMER1 - program radi
	niz dw 3,3,2,3,4,5,3,6,7,3
	n dw 10
	k dw 3
	br dw ?
	
	;PRIMER2 - program radi
	;niz dw 1,3,2,3,4,5,3,6,7
	;n dw 9
	;k dw 3
	;br dw ?
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
	;Adresu niza preneti preko registara.
	;Broj elemenata niza preneti po vrednosti preko steka.
	;Podatak koji se pretražuje preneti po adresi preko steka.
	;Izlazni parametar procedure preneti po vrednosti preko steka.
	
	
	;7.priprema ulaznih parametara
	lea si, niz ;preko si prenosimo adresu niza
	push n
	lea ax, k
	push ax ;k prenosimo preko steka po adresi

	;8.poziv procedure
	call func

	;9.preuzimanje ulaznih parametara
	pop br ;smestamo u br parametar prenet preko steka
	
	mov ax,4c00h
    int 21h
program ends
end start
