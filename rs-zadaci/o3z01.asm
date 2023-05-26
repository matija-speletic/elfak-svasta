data segment
	b dw 12 dup(0)
	a db 1, 2, 3, 4
	  db 5, 6, 7, 8
	  db 9,10,11,10
	n db 3
	m db 4
data ends
program segment
    assume cs:program, ds:data
start:
	mov ax, data
	mov ds, ax

	xor si, si	;SI <- 0
	mov dl, m
	xor dh, dh
	xor di, di	;DI <- m
	petlja1:	;do ... while (SI < M)
		xor bx, bx	;BX <- 0
		mov cl, n
		xor ch, ch	;CX <- n
		
		petlja2: ;for(CX <- n; CX != 0; --CX)
			mov al, a[si][bx]
			cbw
			mov b[di], ax	;MAT2 <- el.
			add di, 2		;DI += 2
			add bx, dx		;BX += M
		loop petlja2
		
		inc si	;SI++
		
	cmp si, dx	;while (SI < M)
	jb petlja1
	
	
	mov ax,4c00h
    int 21h
program ends
end start


;Data je matrica označenih 8-bitnih elemenata u memoriji počev od adrese A, zapamćena po vrstama. Dimenzije matrice su zapamćene na 8-bitni lokacijama N i M. Napisati program na asemblerskom jeziku za kopiranje elemenata matrice A u matricu 16-binih elemenata B, koja u memoriji treba da bude smeštena po kolonama. Pri kopiranju izvršiti konverziju 8-bitnih u 16-bitne podatke.