public func
procedure segment
func proc FAR
    assume cs:procedure

	push bp
	mov bp, sp
	pushf 
	push cx
	push si

    mov ax, 0
	mov cx, [bp+8]
	mov si, [bp+6]
	
	cmp byte ptr [si], 'A'
	jb nije
	cmp byte ptr [si], 'Z'
	ja nije
		inc ax
	nije:
	
	petlja:
		cmp byte ptr [si], ' '
		jne dalje
		cmp byte ptr [si+1], 'A'
		jb dalje
		cmp byte ptr [si+1], 'Z'
		ja dalje
			inc ax
		dalje:
		inc si
	loop petlja

	pop si
	pop cx
	popf
	pop bp
	ret 4
    
func endp
procedure ends
end
