;Zadata su dva niza ASCII znakova, niz na lokaciji NIZ1 je dužine DUZ1, a niz na lokaciji NIZ2 je dužine DUZ2 (dužine su 8-bitni brojevi, DUZ1 > DUZ2). 
;Na asemblerskom jeziku napisati program za zamenu svih pojavljivanja zadatog podniza NIZ2 u nizu NIZ1, karakterom '*'. 
;Pored toga odrediti i podatak o ukupnom broju pojavljivanja niza NIZ2 u nizu NIZ1 i smestiti ga na 8-bitnu lokaciju BROJ.

data segment
	broj db ?
	niz1 db 'ovo je ovo hsorpovojzq'
	duz1 db 22
	niz2 db 'ovo'
	duz2 db 3
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
	
	mov cl, duz1
	sub cl, duz2
	inc cl
	mov ch, 0
	mov si, 0
	petlja1:
		mov bx, 0
		
		petlja2:
		mov al, niz1[si+bx]
		cmp al, niz2[bx]
		jne dalje
		cmp bl, duz2
		je dalje
		inc bx
		jmp petlja2
		dalje:
		
		cmp bl, duz2
		jne sledeci
			mov niz1[si], '*'
			
			;pomeranje niza
			push cx
			push si
			mov cl, duz1
			mov ch, 0
			sub cl, duz2
			sub cx, si
			
			mov di, si
			inc si
			mov al, duz2
			mov ah, 0
			add di, ax
			
			petlja3:
				mov al, niz1[di]
				mov niz1[si], al
				inc si
				inc di
			loop petlja3
			
			mov al, duz2
			dec al
			sub duz1, al
			
			pop si
			pop cx
		sledeci:
		inc si
		
	loop petlja1
	
	mov ah, 4ch
	int 21h
code ends
end start