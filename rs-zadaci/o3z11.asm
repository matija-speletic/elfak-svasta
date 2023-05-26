data segment
	mat dw 526h ,895h ,501h ,631h ,780h
		dw 299h ,1792h ,145h ,1541h ,43h
		dw 878h ,799h ,1366h ,243h ,1823h
		dw 1686h ,626h ,1494h ,1871h ,503h
		dw 508h ,140h ,969h ,188h ,641h
	n   db 5
		dw 0ffffh
	min dw ?
	max dw ?
data ends
program segment
    assume cs:program, ds:data
start:
	mov ax, data
	mov ds, ax

	xor bp, bp
	xor si, si
	mov al, n
	xor ah, ah
	mov di, ax
	dec di
	shl di, 1
	mov cl, n
	xor ch, ch
	mov bx, mat
	mov dx, mat
	petlja:
		mov ax, mat[bp][si]
		xchg ax, mat[bp][di]
		mov mat[bp][si], ax
		
		cmp bx, mat[bp][si]
		jbe ispod1
			mov bx, mat[bp][si]
		ispod1:
		
		cmp bx, mat[bp][di]
		jbe ispod2
			mov bx, mat[bp][di]
		ispod2:
		
		cmp dx, mat[bp][si]
		jae ispod3
			mov dx, mat[bp][si]
		ispod3:
		
		cmp dx, mat[bp][di]
		jae ispod4
			mov dx, mat[bp][di]
		ispod4:
		
		mov al, n
		xor ah, ah
		shl ax, 1
		add bp, ax
		add si, 2
		sub di, 2
	loop petlja
	
	mov min, bx
	mov max, dx
	
	mov ax,4c00h
    int 21h
program ends
end start


;3.11  Na lokaciji MAT memorisana je kvadratna matrica dimenzija NxN po vrstama. Elementi matrice su 16-bitni brojevi, dok je dimenzija N memorisana kako 8-bitni broj. 
;Na asemblerskom jeziku napisati program kojim se vrši zamena elemenata glavne i sporedne dijagonale, kao i određivanje jedinstvenog minimalnog (smestiti ga na lokaciju MIN) 
;i maksimalnog (smestiti ga na lokaciju MAX) elementa za obe dijagonale.