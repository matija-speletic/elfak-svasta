;Data su dva niza ASCII karaktera NIZ1 i NIZ2. Kraj nizova je određen karakterom "#". Svaki element određenog niza se pojavljuje samo po jednom u nizu. 
;Na asemblerskom jeziku napisati program koji od zadatih nizova formira novi niz (na lokaciji NIZ3) u koji treba da uđu svi elementi polaznih nizova, 
;pri čemu elemente treba uključiti samo jedanput.
name o2z17
data segment
	mat dw -1, 2, 3, 5, 6 ;0
		dw  4, 4, 6, 7, 8 ;10
		dw  7, 8, 5, 3, 2 ;20
		dw  7, 8, 5, 2, 2 ;30
		dw  7, 8, 5, 3, 3 ;40
		;   0  2  4  6  8
	n db 5
data ends
code segment
	assume cs:code, ds:data
start:
	mov ax, data
	mov ds, ax
		
	mov dl, n
	xor dh, dh
	
	;si,bx - pocetak
	mov si, 0
	mov bx, 0
	
	;di, bp - kraj
	mov ax, dx
	dec ax
	shl ax, 1
	mov di, ax ;di <- 2*(n-1)
	mul n
	mov bp, ax ;bp <- 2*n*(n-1)
	
	mov cx, dx
	shr cx, 1 
	shl dx, 1
	petlja:
		mov ax, mat[si][bx]
		cmp mat[di][bp], ax
		jae ispod
			xchg ax, mat[di][bp]
			mov mat[si][bx], ax
		ispod:
		add si, 2
		add bx, dx
		sub di, 2
		sub bp, dx
	loop petlja
	
	mov ah, 4ch
	int 21h
code ends
end start