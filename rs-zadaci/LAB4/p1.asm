extrn n:word ;byte | word | dword
extrn niz:word
extrn suma:word
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
	push si
	push cx
	
    ;2. preuzimanje ulaznih parametara
	lea si, niz
	mov cx, n
	xor ax, ax
    ;3. telo procedure
	petlja:
		add ax, [si]
		add si, 2
	loop petlja
    ;4.slanje izlaznih parametara
	mov suma, ax
    ;5.obnavljanje konteksta rocesora
	pop cx
	pop si
	pop ax
	popf
	pop bp
    ;6.povratak na mesto poziva
    ret
func endp
procedure ends
end
