;1.01 
data segment
	n dw 7
	kol dw ?
data ends
program segment
    assume cs:program, ds:data
start:
	mov ax, data
	mov ds, ax

	mov si, 3
	xor ax, ax
	xor bx, bx
	xor cx, cx
	xor dx, dx
	petlja:
		mov ax, si
		mul si
		add ax, si
		adc dx, 0
		sub si, 2
		div si
		add si, 3
		add bx, ax
		adc cx, 0
	cmp si, n
	jbe petlja
	
	mov ax, bx
	mov dx, cx
	div word ptr n
	mov kol, ax
	
	mov ax,4c00h
    int 21h
program ends
end start
