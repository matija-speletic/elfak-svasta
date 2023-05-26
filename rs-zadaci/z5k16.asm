;Data je kvadratna matrica 16-bitnih neoznačenih elemenata smeštena po vrstama počev od adrese
;MAT, dimenzije smeštene na 16-bitnoj lokaciji N. Napisati program na asemblerskom jeziku koji
;indeks kolone sa najvećim celim delom aritmetičke sredine odgovarajućih elemenata glavne i
;sporedne dijagonale zapisuje na adresu COL. Ako više kolona ima istu aritmetičku sredinu, zapamtiti
;kolonu sa najmanjim indeksom. Obilaziti matricu počev od kolone sa najvećim indeksom. Napisati i
;koristiti proceduru koja vraća ceo deo aritmetičke sredine dva 16-bitna parametra preneta po adresi preko steka.
extern srvr:far
data segment
	col dw ?
		  ;1   10  3   1    10   -1  -6   3   <- srednje vrednosti (za testiranje)
	mat dw 10, 0,  6,  -6,  8,   7,  -3,  6    
		dw 2,  10, -5, 10,  8,   9,  -6,  -4
		dw 7,  9,  6,  7,  -2,   -3, -2,  6   
		dw 7,  6,  5,  -8,  10,  -6, 8,   -3   
		dw -7, 5,  9,  10,  10,  6,  -1,  -3
		dw 8,  5,  1,  4,   7,   1,  8,   -6     
		dw 1,  10, -2, 6,   0,   -2, -6,  4
		dw -7, 5,  9,  -10, -10, -1, -9,  0
	n   dw 8
data ends
stack segment
	dw 50 dup(?)
	dno label word
stack ends
code segment
	assume cs:code, ds:data, ss:stack
start:
	mov ax, data
	mov ds, ax
	mov ax, stack
	mov ss, ax
	
	;ax <- 2n(n-1)
	mov ax, n
	dec ax
	shl ax, 1
	mul n
	
	mov bp, ax ;bp <- 2n(n-1)
	
	mov si, n  ;si <- 2(n-1)
	dec si
	shl si, 1
	
	mov bx, 0
	mov dx, 0 ;trenutni maximum
	mov di, 0 ;indeks trenutni
	mov cx, n
	petlja:
		;ax=srvr(mat[si][bx],mat[si][bp])
		lea ax, mat[si][bx]
		push ax
		lea ax, mat[si][bp]
		push ax
		call srvr
		
		;ako je srvr veca ili jednaka postavi novi maximum i indeks
		;vece ili jednako obezbedjuje da se upise minimalni indeks
		;sa maximalnom srvr (jer se krece otpozadi)
		cmp ax, dx
		jl dalje
			mov dx, ax
			mov di, si
			shr di, 1 ;trenutni indeks je si/2
		dalje:
		;si-=2
		sub si, 2
		;bp-=2n
		sub bp, n
		sub bp, n
		;bx+=2n
		add bx, n
		add bx, n
	loop petlja
	
	mov col, di ;upis

	mov ah, 4ch
	int 21h
code ends
end start
