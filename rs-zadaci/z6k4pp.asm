public skalar
procedure segment
skalar proc far
	push bp
	mov bp, sp
	pushf
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	
	mov cx, [bp+6]
	mov bx, 0
	mov si, [bp+10]
	mov di, [bp+8]
	petlja:
		mov al, [si]
		imul byte ptr [di]
		add bx, ax
		inc si
		inc di
	loop petlja
	mov si, [bp+12]
	mov [si], bx
	
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	popf
	pop bp
	ret 8
skalar endp
procedure ends
end
