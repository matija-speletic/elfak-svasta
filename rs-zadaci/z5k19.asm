;podmatrica

data segment
	mat dw 10, 0, 6, -6, 8, 7, -3, 6    
		dw 2, 10, -5, 10, 8, 9, -6, -4
		dw 7, 9, 6, 7, -2, -3, -2, 6   
		dw 7, 6, 5, -8, 3, -6, 8, -3   
		dw -7, 5, 9, 10, 2, 6, -1, -3
		dw 8, 5, 1, 4, 7, 1, 8, -6     
		dw 1, 10, -2, 6, 0, -2, -6, 4
		dw -7, 5, 9, -10, -10, -1, -9, 0
	n   dw 8
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

	xor dx, dx;dh-max, dl-br
	xor bx, 0
	mov cx, n
	shr cx, 1
	mov bp, 1 ;tr indeks
	mov di, 1 ; max index
	petlja1:
		mov si, 0
		mov dl, 0
		push cx
		mov cx, n
		petlja2:
			cmp mat[si][bx], 0
			jl dalje1
				inc dl
			dalje1:
			add si, 2
		loop petlja2
		mov cx, n
		mov si, 0
		add bx, n
		add bx, n
		petlja3:
			cmp mat[si][bx], 0
			jl dalje2
				inc dl
			dalje2:
			add si, 2
		loop petlja3
		pop cx
		add bx, n
		add bx, n
		cmp dl, dh
		jbe dalje3
			mov dh, dl
			mov di, bp
		dalje3:
		inc bp
		
	loop petlja1
	
	mov ax,4c00h
    int 21h
program ends
end start
