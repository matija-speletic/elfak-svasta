public zameni
procedure segment
zameni proc far
	push bp
	mov bp, sp
	pushf
	push ax
	push cx
	push dx
	push di
	push si
	
	mov cx, [bp+6]
	mov di, si
	mov ax, [si]
	mov dx, si
	petlja:
		cmp ax, [si]
		jae dalje
			mov di, si
			mov ax, [si]
		dalje:
		add si, 2
	loop petlja
	mov si, dx
	mov ax, [si]
	xchg ax, [di]
	mov [si], ax
	
	pop si
	pop di
	pop dx
	pop cx
	pop ax
	popf
	pop bp
	ret 2
zameni endp
procedure ends
end