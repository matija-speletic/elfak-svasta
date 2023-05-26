;ZAD1 PROCEDURA
public func
procedure segment
func proc FAR
    assume cs:procedure
    ;1.cuvanje konteksta procesora
	push bp
	mov bp, sp
	pushf 
	;push ax ;ne stavljamo jer preko ax prenosimo rezultat

	mov al, [bp+8]   ;AL <- X
	sub al, [bp+6]   ;AL <- AL - Y
	cbw ;funkcija vraca podatak preko AX u vidu 16bit
		;samo da bi se jasno razlikovao oznaceni rezultat
		;ovo ne utice na funkcionalnost programa jer se 
		;visi bajt ignorise

	popf
	pop bp

	ret 4
    
func endp
procedure ends
end



;ZAD1 GLAVNI
extrn func:far
data segment
    ;PRIMER1 - program radi ispravno
	x db 17
	y db 37
	z db 18
	rez db ? ;FF...FFDA

    ;PRIMER2 - program ne radi ispravno,
    ;jer se izlazi iz opsega 8bit oznacenih
    ;x db -99
	;y db 120
	;z db 98
	;rez db ? 
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



;ZAD2 PROCEDURA
public func
procedure segment
func proc FAR
    assume cs:procedure
    ;1.cuvanje konteksta procesora
	push bp
	mov bp, sp
	pushf
	push ax
	push bx
	push cx
	push si
	push di

    ;2.preuzimanje ulaznih parametara
	mov cx, [bp+8]  ;CX <- n
	mov di, [bp+6]
	mov ax, [di]  ;AX <- k
	
    ;3.telo procedure
	xor bx, bx   ;BX - brojac ponavljanja
	
	petlja:
		cmp ax, [si] ;if(AX==niz[i])
		jne ispod
			inc bx		;BX++;
		ispod:
		add si, 2	 ;SI+=2 (i++)
	loop petlja
	
    ;4.slanje izlaznih parametara
	mov [bp+8], bx

    ;5.obnavljanje konteksta rocesora
	pop di
	pop si
	pop cx
	pop bx
	pop ax
	popf
	pop bp
	
    ;6.povratak na mesto poziva
	ret 2 ;sklanjamo adresu k (broj ponavljanja ostaje na mestu n)
    
func endp
procedure ends
end



;ZAD2 GLAVNI
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
