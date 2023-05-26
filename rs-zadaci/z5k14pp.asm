public vrsta
procedure segment
vrsta proc far
	push bp
	mov bp, sp
	pushf
	mov ah, 0
	cmp al, 'a'
	je jeste
	cmp al, 'e'
	je jeste
	cmp al, 'i'
	je jeste
	cmp al, 'o'
	je jeste
	cmp al, 'u'
	je jeste
	jmp dalje
	jeste:
	mov ah, 1
	dalje:
	popf
	pop bp
	ret
vrsta endp
procedure ends
end