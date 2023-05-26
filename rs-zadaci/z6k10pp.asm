public potisni
procedure segment
potisni proc far
push bp
mov bp, sp
pushf
push ax
push bx
push cx
push si

	mov cx, [di]
	mov si, [bp+6]
	mov ax, [si]
	dec cx
	add si, 2
	petlja:
		cmp ax, [si]
		jle kraj
		mov bx, [si]
		mov [si-2], bx
		add si, 2
	loop petlja
	kraj:
	mov [si-2], ax

pop si
pop cx
pop bx
pop ax
popf
pop bp
ret 2
potisni endp
procedure ends
end