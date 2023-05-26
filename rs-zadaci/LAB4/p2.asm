public func
procedure segment
func proc FAR
	assume cs:procedure
	
	push bp
	mov bp, sp
	pushf
	push cx
	push si
	push bx
	
	xor ax, ax
	mov cx, [bp+6]
	mov si, [bp+8]
	mov bx, [bp+10]
	
	petlja:
		cmp bl, byte ptr [si]
		jne neGrana
			inc ax
		neGrana:
		inc si
	loop petlja
	
	pop bx
	pop si
	pop cx
	popf
	pop bp
	
	ret 6
	
func endp
procedure ends
end