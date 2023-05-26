;funkcija za odredjivanje broja faktora za broj n - rezultat u ax
public func
procedure segment
func proc FAR
    assume cs:procedure
    ;1.cuvanje konteksta procesora
	;ovako ide praksa (prvo bp)
	push bp
	mov bp, sp
	pushf 
	push bx
	push cx
    ;2. preuzimanje ulaznih parametara

    ;3. telo procedure
	xor bx, bx
	mov cl, 2
	mov ax, [bp+6]
	petlja:
	cmp al, 0
	je ispod1
		
		mov ax, [bp+6]
		div cl
		inc cl
		
		cmp ah, 0
		jne ispod2
			inc bx
		ispod2:
	jmp petlja
	ispod1:
	
	inc bx
    ;4.slanje izlaznih parametara
	mov ax, bx

    ;5.obnavljanje konteksta rocesora
	pop cx
	pop bx
	popf
	pop bp
    ;6.povratak na mesto poziva
    ret 2
func endp
procedure ends
end
