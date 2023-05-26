;Napisati asemblerski program za izračunavanje proizvoda onih elemenata matrice koji ispunjavaju uslov da je zbir prvog i drugog indeksa jednak 8-bitnom broju zadatom na lokaciji BROJ. 
;Matrica je kvadratna i memorisana je po vrstama, elementi su 8-bitni, kao i dimenzija koja je memorisana na lokaciji N. 
;Traženi proizvod je maksimalno 16-bitni. Elementi matrice počinju od a11, a12, ...

data segment
	p   dw ?
	n   db 5
	br  db 4
	mat db 9, 3, 9, 3, 5
		db 9, 5, 8, 7, 1
		db 7, 5, 6, 6, 2
		db 4, 8, 4, 9, 5
		db 3, 2, 6, 8, 4
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
	
	mov p, 1
	mov cl, n
	mov ch, 0
	mov bx, 0
	mov bp, 1
	
	petlja1:
		mov si, 0
		mov di, 1
		
		push cx
		mov cl, n
		mov ch, 0
		petlja2:
			
			mov ax, di
			add ax, bp
			cmp al, br
			jne dalje
				mov al, mat[si][bx]
				mov ah, 0
				mul p
				mov p, ax
			dalje:
			
			inc si
			inc di
		loop petlja2
		pop cx
		add bl, n
		adc bh, 0
		inc bp
	loop petlja1
	
	mov ah, 4ch
	int 21h
code ends
end start