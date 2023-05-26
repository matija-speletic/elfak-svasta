public func
procedure segment
func proc FAR
    assume cs:procedure

	push bp
	mov bp, sp
	pushf 
	push bx
	push cx
	push dx
	push si

	mov cx, [bp+6]
	mov ax, 0
	mov si, [bp+8]
	petlja:
		mov bx, 10
		mul bx
		mov bl, [si]
		sub bl, '0'
		add al, bl
		adc ah, 0
		inc si
	loop petlja

	pop si
	pop dx
	pop cx
	pop bx
	popf
	pop bp

	ret 4
    
func endp
procedure ends
end
