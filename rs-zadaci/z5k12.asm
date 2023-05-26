data segment
	niz1 db 1,2,3,4,5,0fh
	niz2 db 5 dup(0aah)
data ends
code segment
	assume cs:code, ds:data
start:
	mov ax, data
	mov ds, ax
	
	lea si, niz1
	lea di, niz2
	petlja:
		mov ah, [si]
		inc si
		mov al, [si]
		inc si
		cmp ah, 0fh
		jne dalje1
			mov al, 0
		dalje1:
		mov bl, ah
		shl bl, 1
		shl bl, 1
		shl bl, 1
		shl bl, 1
		or bl, al
		mov [di], bl
		inc di
		cmp ah, 0fh
		je kraj
		cmp al, 0fh
		je kraj
	jmp petlja
	kraj:
	
	mov ah, 4ch
	int 21h
code ends
end start