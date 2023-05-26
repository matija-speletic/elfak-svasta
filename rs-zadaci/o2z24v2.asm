data segment
	niz db 'ovo je  neki   tekst.    ima recenice. Ovo je    recenica. $'
data ends
code segment
	assume cs:code, ds:data, es:data
start:
	mov ax, data
	mov ds, ax
	mov es, ax
	
	lea si, niz
	mov di, si
	mov bl, 1
	cld
	petlja:
		lodsb
		cmp al, '$'
		je kraj
		cmp al, '.'
		jne dalje1
			mov bl, 1
		dalje1:
		cmp al, ' '
		jne krajcic
		petljica:
			cmp byte ptr [si], ' '
			jne krajcic
			inc si
		jmp petljica
		krajcic:
		cmp al, 'A'
		jb dalje2
		cmp al, 'Z'
		ja dalje2
			mov bl, 0
		dalje2:
		cmp al, 'a'
		jb dalje3
		cmp al, 'z'
		ja dalje3
		cmp bl, 1
		jne dalje3
			sub al, 'a'-'A'
			mov bl, 0
		dalje3:
		stosb
	jmp petlja
	kraj:
	mov al, '$'
	stosb
	
	mov ah, 4ch
	int 21h
code ends
end start