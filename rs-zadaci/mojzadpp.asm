public broj
procedure segment
broj proc far

	push bp
	mov bp, sp
	pushf
	push bx
	push cx
	push dx
	push si
	
	mov si, [bp+8]
	mov cx, [bp+6]
	mov bx, 0
	mov ax, 0
	petlja:
		mov bx, 10
		mul bx
		xor bh, bh
		mov bl, [si]
		sub bl, '0'
		add ax, bx
		inc si
	loop petlja
	
	pop si
	pop dx
	pop cx
	pop bx
	popf
	pop bp
	ret 4

broj endp
procedure ends
end