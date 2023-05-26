data segment
	rec db 20 dup(?)
	txt db 'Ovo je neka Recenica koja ima reccnica puno #'
data ends
code segment
	assume cs:code, ds:data, es:data
start:
	mov ax, data
	mov ds, ax
	mov es, ax
	
	lea si, txt
	lea di, rec
	mov dx, 0
	mov bp, si
	petlja:
		mov bx, si
		lodsb
		cmp al, '#'
		je kraj
		petljica:
			cmp al, ' '
			je krajcic
			lodsb
		jmp petljica
		krajcic:
		mov cx, si
		sub cx, bx
		cmp cx, dx
		dec cx
		jb petlja
			mov bp, bx
			mov dx, cx
	jmp petlja
	kraj:
	mov cx, dx
	mov si, bp
	rep movsb
	mov al, '#'
	stosb
	
	mov ah, 4ch
	int 21h
code ends
end start	
