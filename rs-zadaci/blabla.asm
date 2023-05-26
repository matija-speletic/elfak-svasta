data segment
	vek dw 3 dup(?)
	m label byte
	p db 4
	;word label n
	q dd 55555
data ends
program segment
    assume cs:program, ds:data
start:
	mov ax, data
	mov ds, ax
	
	
	add vek, ax
	add ax, 0003h
	mov bx, 3
	mov si, 3
	lea si, p
	mov al, [p]
	mov ax, word ptr p
	add al, [bx+si]
	mov vek[bx][si], bp
	xchg bh, bl
	
	mov ax,4c00h
    int 21h
program ends
end start


;Napisati program za izračunavanje sume elemenata kvadratne matrice MAT po kolonama ako je matrica memorisana po vrstama. 
;Sume kolona smestiti u vektor VEK. Dimenzija matrice je osmobitni broj zapamćen na lokaciji DIM. Elementi matrice su 16-bitni neoznačeni brojevi. 
;Smatrati da su sume elemenata u jednoj koloni maksimalno 16-bitni brojevi. 
;Istovremeno prebrojati koliko elemenata matrice ima manju vrednost od dimenzije matrice. Ukoliko je taj broj paran, na kraju izvršenja programa treba da je vrednost CF (Carry flag) jednaka 1.