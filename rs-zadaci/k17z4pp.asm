public tip
procedure segment
tip proc FAR
    assume cs:procedure
	;veliko - 0
	;malo - 1
	;blanko - 2
	;kraj - 4
	;blanko - 3
	pushf 

    cmp al, 'a'
	jb ne1
	cmp al, 'z'
	ja ne1
		mov al, 1
	jmp kraj
	
	ne1:
	cmp al, 'A'
	jb ne2
	cmp al, 'Z'
	ja ne2
		mov al, 0
	jmp kraj
	
	ne2:
	cmp al, ' '
	jne ne3
		mov al, 2
	jmp kraj
	
	ne3:
	cmp al, '@'
	jne ne4
		mov al, 4
	jmp kraj
	
	ne4:
	mov al, 3
	
	kraj:

	popf
	
	ret
    
tip endp
procedure ends
end