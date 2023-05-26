;Izbacivanje el iz niza
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
	push cx
	push si

    ;2. preuzimanje ulaznih parametara

    ;3. telo procedure
	mov si, [bp+6]
	mov cx, [si]
	sub cx, [bp+10]
	dec cx
	mov si, [bp+8]
	mov ax, [bp+10]
	shl ax, 1
	add si, ax
	petlja:
		mov ax, [si+2]
		mov [si], ax
		add si, 2
	loop petlja
	mov word ptr [si], 0
	mov si, [bp+6]
	dec word ptr [si]
    ;4.slanje izlaznih parametara

    ;5.obnavljanje konteksta rocesora

	pop si
	pop cx
	pop ax
	popf
	pop bp
    ;6.povratak na mesto poziva
    ret 6
func endp
procedure ends
end
