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
