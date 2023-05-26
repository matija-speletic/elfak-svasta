data segment
	vek dw 3 dup(?)
	num dw ?
	mat dw 1, 2, 3
	    dw 5, 6, 7
	    dw 9,10,11
	dim db 3
data ends
program segment
    assume cs:program, ds:data
start:
	mov ax, data
	mov ds, ax
	
	xor si, si
	xor di, di
	xor bx, bx
	mov dl, dim
	xor dh, dh
	shl dx, 1
	
	petlja1:
		xor bx, bx
		mov cx, dx
		shr cx, 1
		xor ax, ax
		
		petlja2:
			add ax, mat[si][bx]
			
			shr dx, 1
			cmp mat[si][bx], dx
			jae ispod1
				inc di
			ispod1:
			shl dx, 1
			
			add bx, dx
		loop petlja2
		
		mov vek[si], ax
		
		add si, 2
	cmp si, dx
	jb petlja1
	
	clc
	test di, 0001h
	jnz ispod2
		stc
	ispod2:
	
	mov ax,4c00h
    int 21h
program ends
end start


;Napisati program za izračunavanje sume elemenata kvadratne matrice MAT po kolonama ako je matrica memorisana po vrstama. 
;Sume kolona smestiti u vektor VEK. Dimenzija matrice je osmobitni broj zapamćen na lokaciji DIM. Elementi matrice su 16-bitni neoznačeni brojevi. 
;Smatrati da su sume elemenata u jednoj koloni maksimalno 16-bitni brojevi. 
;Istovremeno prebrojati koliko elemenata matrice ima manju vrednost od dimenzije matrice. Ukoliko je taj broj paran, na kraju izvršenja programa treba da je vrednost CF (Carry flag) jednaka 1.