extrn tip:far
data segment
	niz db 'ovo je recenica. Ali je i ovo takodje.@'
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
	mov al, [si]
	call tip ; za prvi karakter
	cmp al, 1
	jne dalje0 ; ako je prvi karakter malo slovo - konverzija
		sub byte ptr [si], 'a'-'A'
		mov al, 0 ;trenutni karakter je sada veliko slovo
	dalje0:
	mov ah, al ;u al cuvamo tip trenutnog, a u ah prethodnog karaktera
	inc si ;sledeci karakter
	petlja:
		mov al, [si] ;trenutni karakter
		call tip     ;u al smestamo tip trenutnog
		;podsetnik: u ah je smesten tip prethodnoh
		
		;konvrezija trenutnog karaktera u veliko slovo
		;ako je on malo slovo i prethodni karakter nije slovo
		cmp al, 1
		jne dalje1
		cmp ah, 2
		jb dalje1
			sub byte ptr [si], 'a'-'A'
			mov al, 0 ;trenutni karakter je sada veliko slovo
		dalje1:
		
		;konverzija prethodnog karaktera u veliko slovo 
		;ako trenutni karakter nije slovo i prethodni je malo slovo
		cmp al, 2
		jb dalje2
		cmp ah, 1
		jne dalje2
			sub byte ptr [si-1], 'a'-'A'
			mov ah, 0 ;prethodni karakter je sada veliko slovo
		dalje2:
		
		cmp al, 4 ;skok na kraj ako je stiglo do kraja
		je kraj ;stavljeno na kraj petlje kako bi se poslednji
				;karakter takodje konvertovao
		
		inc si;prelazak na sledeci char
		mov ah, al ;trenutni postaje prethodni
	jmp petlja
	kraj:
	mov ax,4c00h
    int 21h
program ends
end start
