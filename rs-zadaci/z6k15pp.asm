public zameni
procedure segment
zameni proc far
	assume cs:procedure
	push bp
	mov bp, sp
	pushf
	push ax
	push si
	push di
	
	mov si, [bp+6]
	mov di, [bp+8]
	mov ax, [di]
	xchg ax, [si]
	xchg ax, [di]
	
	pop di
	pop si
	pop ax
	popf
	pop bp
	
	ret 4
	
zameni endp
procedure ends
end