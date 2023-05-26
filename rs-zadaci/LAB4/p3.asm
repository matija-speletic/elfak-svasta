public func
procedure segment
func proc FAR
    assume cs:procedure
    ;1.cuvanje konteksta procesora
	;ovako ide praksa (prvo bp)
	push bp
	mov bp, sp
	pushf 
	push ax
	push bx
	push cx
	push si
	push di

    ;2. preuzimanje ulaznih parametara
	xor ax, ax
	xor bx, bx
	mov si, [bp+10]
	mov di, [bp+8]
	mov cx, [bp+6]
    ;3. telo procedure
	petlja:
		mov al, [si]
		mul byte ptr [di]
		add bx, ax
		inc si
		inc di
	loop petlja
    ;4.slanje izlaznih parametara
	mov [bp+10], bx
    ;5.obnavljanje konteksta rocesora
	
	pop di
	pop si
	pop cx
	pop bx
	pop ax
	popf
	pop bp
    ;6.povratak na mesto poziva
    ret 4
	
func endp
procedure ends
end
