;Dat je nepakovani BCD broj a smešten u memoriji počev od adrese A, tako što je cifra najmanje težine smeštena na najnižoj adresi. Zapis broja se završava podatkom FFh.
; Napisati program na asemblerskom jeziku koji konvertuje broj a u binarni broj, i vrednost konverzije upisuje u 16-bitnu promenljivu B. 
;Za konverziju BCD broja koristiti proceduru koja preko steka dobija početnu adresu BCD broja i njegovu dužinu u bajtovima, a kao rezultat, takođe preko steka, vraća vrednost konverzije. 
;Ukoliko vrednost konverzije premašuje 16 bitova, vratiti -1 kao rezultat.

extern func:far
data segment
	br1 dw ?
	br2 dw ?
	niz1 db 1,9,3,4,0ffh
	niz2 db 9,9,9,9,9,9,9,9,0ffh
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
	
	mov si, 0
	petlja1:
		cmp niz1[si], 0ffh
		je kraj1
		inc si
	jmp petlja1
	kraj1:
	push si
	lea si, niz1
	push si
	call func
	pop ax
	mov br1, ax
	
	mov si, 0
	petlja2:
		cmp niz2[si], 0ffh
		je kraj2
		inc si
	jmp petlja2
	kraj2:
	push si
	lea si, niz2
	push si
	call func
	pop ax
	mov br2, ax
	
	mov ah, 4ch
	int 21h
code ends
end start