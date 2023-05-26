extern broj:far
data segment
	rez dw ?
	niz db '1234+5678-321+487-27='
data ends
stack segment
	dw 200 dup(?)
	dno label word
stack ends
code segment
	assume cs:code, ds:data, ss:stack
start:
	mov ax, data
	mov ds, ax
	mov ax, stack
	mov ss, ax
	lea sp, dno
	
	lea si, niz
	lea di, niz
	mov dx, 0
	mov bl, '+'
	
	petlja:
		cmp bl, '='
		je kraj
		
		petljica:
			cmp byte ptr [si], '0'
			jb dalje
			cmp byte ptr [si], '9'
			ja dalje
			inc si
		jmp petljica
		dalje:
		
		mov cx, si
		sub cx, di
		push di
		push cx
		call broj
		
		cmp bl, '+'
		jne dalje2
			add dx, ax
		dalje2:
		
		cmp bl, '-'
		jne dalje3
			sub dx, ax
		dalje3:
		
		mov bl, [si]
		inc si
		mov di, si
	jmp petlja
	kraj:
	
	mov rez, dx
	
	mov ah, 4ch
	int 21h
code ends
end start
	