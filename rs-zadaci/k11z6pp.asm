public vrsta
procedure segment
vrsta proc far
	push bp
	mov bp, sp
	pushf
	push ax
	push cx
	push dx
	push si
	
	mov si, [bp+8]
	mov cx, [bp+6]
	mov ax, 0
	mov dx, 0
	petlja:
		cmp word ptr [si], 0
		jle dalje
			add ax, [si]
			adc dx, 0
		dalje:
		add si, 2
	loop petlja
	mov [bp+8], ax
	mov [bp+6], dx
	
	pop si
	pop dx
	pop cx
	pop ax
	popf
	pop bp
	ret
vrsta endp
procedure ends
end