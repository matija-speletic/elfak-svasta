;Dat je niz pakovanih BCD cifara na lokaciji NIZ. Kraj niza je označen binarnom četvorkom 1111. 
;Napisati program na asemblerskom jeziku koji zadati niz prevodi u 32-bitni binarni broj na lokaciji BR.
data segment
	niz db 12h,34h,56h,78h,91h,0fh
	br dw 0,0
data ends
code segment
	assume ds:data, cs:code
start:
	mov ax, data
	mov ds, ax
	
	lea si, niz
	mov di, 0 ;visi deo rezultata
	mov bx, 0 ;nizi deo rezultata
	petlja:
	cmp byte ptr [si], 0fh
	je kraj
		mov ax, 10
		mul di
		mov bp, ax;u bp smo smestili visi deo mnozenja
		mov ax, 10
		mul bx ;dx:ax <- nizi deo mnozenja
		add dx, bp ;dodavanje viseg dela na nizi
		mov di, dx
		mov bx, ax
		mov al, [si]
		shr al, 1
		shr al, 1
		shr al, 1
		shr al, 1
		add bl, al
		adc bh, 0
		adc di, 0
		
		mov ax, 10
		mul di
		mov bp, ax;u bp smo smestili visi deo mnozenja
		mov ax, 10
		mul bx ;dx:ax <- nizi deo mnozenja
		add dx, bp ;dodavanje viseg dela na nizi
		mov di, dx
		mov bx, ax
		mov al, [si]
		and al, 0fh
		add bl, al
		adc bh, 0
		adc di, 0
		inc si
	jmp petlja
	kraj:
	mov br, bx
	mov br+2, di
	
	mov ah,4ch
	int 21h
code ends
end start