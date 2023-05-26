public srvr
procedure segment
srvr proc far
	assume cs:procedure
	
	push bp
	mov bp, sp
	pushf
	push si
	
	;ax <- (el1 + el2) / 2
	mov si, [bp+6]
	mov ax, [si]
	mov si, [bp+8]
	add ax, [si]
	sar ax, 1 ;sar jer matrica ima oznacene elemente
	
	pop si
	popf
	pop bp
	
	ret 4
	
srvr endp
procedure ends
end