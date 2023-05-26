;13. Uneti niz od N < 9 brojeva , a zatim izvršiti umetanje broja 0
;na k-tu poziciju u nizu ( 0 < k < N-1). Prikazati rezultantni niz.(Probaj: jfja za umetanje, primeni je u petlji)

public func
procedure segment
func proc FAR
    assume cs:procedure
    ;1.cuvanje konteksta procesora
	;ovako ide praksa (prvo bp)
	push bp
	mov bp, sp
	pushf 
	push si
	push ax
	push bx
	push cx

    ;2. preuzimanje ulaznih parametara
	mov si, [bp+6]
	mov bx, [si]
	mov si, [bp+8]
    ;3. telo procedure
	add si, bx      
	mov cx, bx
	sub cx, [bp+10]
	
	petlja:
		mov ax, [si-1]
		mov [si], ax
		dec si
	loop petlja
	
	mov si, [bp+8]
	add si, [bp+10]
	mov ax, [bp+12]
	mov [si], ax
	
	mov si, [bp+6]
	inc worr ptr [si]
    ;4.slanje izlaznih parametara

    ;5.obnavljanje konteksta rocesora
	pop cx
	pop bx
	pop ax
	pop si
	popf
	pop bp
	
    ;6.povratak na mesto poziva
    ret 8
func endp
procedure ends
end
