extrn tip:far
data segment
	niz db 'Ovo je recenica. Ali je i ovo takodje.@'
data ends
stack segment
	dw 200 dup(?)
	dno label word
stack ends
program segment
    assume cs:program, ds:data, ss:stack
start:
	mov ax, data
	mov ds, ax
	mov ax, stack
	mov ss, ax
	lea sp, dno
	
	lea si, niz
	petlja:
		mov al, [si]
		call tip
		mov bx, ax
		inc si
		mov al, [si]
		call tip
		
		cmp bl, 'm' ;trenutni malo
		jne dalje1
		;ako je sledeci blanko ili kraj ili ostalo - zameni velikim
			cmp al, 'o'
			je da1
			cmp al, '@'
			je da1
			cmp al, 'b'
			je da1
			jmp dalje1
			da1:
				sub byte ptr [si-1], 'a'-'A'
		dalje1:
		
		cmp bl, 'b';ako je trenutni blanko
		jne dalje2
		;ako je sledeci malo slovo - veliko
			cmp al, 'm'
			jne dalje2
				sub byte ptr [si], 'a'-'A'
		dalje2:
		
		cmp bl, 'o';ako je trenutni znak
		jne dalje3
		;ako je sledeci malo slovo - veliko
			cmp al, 'm'
			jne dalje3
				sub byte ptr [si], 'a'-'A'
		dalje3:
		
		cmp al, 'k' ;ako je sledeci kraj
		jne dalje4
			jmp kraj
		dalje4:
		
	jmp petlja
	kraj:
	
	mov al, niz
	call tip
	cmp al, 'm'
	jne nije
		sub byte ptr niz, 'a'-'A'
	nije:
	
	mov ax,4c00h
    int 21h
program ends
end start
