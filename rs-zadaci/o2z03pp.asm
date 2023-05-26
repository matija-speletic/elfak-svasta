public func
procedure segment
func proc FAR
    assume cs:procedure
    ;1.cuvanje konteksta procesora
	push bp
	mov bp, sp
	pushf 
	push ax
	push si
	push cx

    mov si, [bp+8]
	mov cx, [bp+6]
	mov ax, 0
	petlja:
		add al, [si]
		adc ah, 0
		inc si
	loop petlja
	mov si, [bp+10]
	mov [si], ax

	pop cx
	pop si
	pop ax
	popf
	pop bp
    ;6.povratak na mesto poziva
    ret 6
func endp
procedure ends
end
