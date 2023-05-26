public func
procedure segment
func proc far
	assume cs:procedure
	push bp
	mov bp, sp
	pushf
	push ax
	push bx
	push cx
	push si
	push dx
	
	mov cx, [bp+8]
	mov si, [bp+6]
	add si, cx
	dec si
	mov ax, 0
	petlja:
		mov bx, 10
		mul bx
		cmp dx, 0
		jne preko
		cmp byte ptr [si], 9
		ja preko
		add al, [si]
		adc ah, 0
		dec si
	loop petlja
	jmp kraj
	preko:
	mov ax, -1
	kraj:
	mov [bp+8], ax
	
	pop dx
	pop si
	pop cx
	pop bx
	pop ax
	popf
	pop bp
	
	ret 2
	
func endp
procedure ends
end