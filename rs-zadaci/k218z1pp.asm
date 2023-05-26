public tip
procedure segment
tip proc FAR
    assume cs:procedure
	
	pushf 

    cmp al, 'a'
	jb ne1
	cmp al, 'z'
	ja ne1
		mov ax, 'm'
	jmp kraj
	
	ne1:
	cmp al, 'A'
	jb ne2
	cmp al, 'Z'
	ja ne2
		mov ax, 'v'
	jmp kraj
	
	ne2:
	cmp al, ' '
	jne ne3
		mov al, 'b'
	jmp kraj
	
	ne3:
	cmp al, '@'
	jne ne4
		mov al, 'k'
	jmp kraj
	
	ne4:
	mov al, 'o'
	
	kraj:

	popf
	
	ret
    
tip endp
procedure ends
end