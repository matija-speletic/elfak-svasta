data segment
	niz2 db 10 dup(0Ah)
	niz1 db 12h, 34h, 0fh
data ends
code segment
	assume cs:code, ds:data, es:data
start:
	mov ax, data
	mov ds, ax
	mov es, ax
	
	lea si, niz1
	lea di, niz2
	cld
	petlja:
		lodsb
		cmp al, 0fh
		je kraj
		mov ah, al
		shr ah, 1
		shr ah, 1
		shr ah, 1
		shr ah, 1
		and al, 0fh
		stosb
		mov al, ah
		stosb
	jmp petlja
	kraj:
	
	mov ah, 4ch
	int 21h
code ends
end start