;Dat je nepakovani BCD broj a smešten u memoriji počev od adrese A, tako što je cifra najmanje
;težine smeštena na najnižoj adresi. Zapis broja se završava podatkom FFh. Napisati program na
;asemblerskom jeziku koji konvertuje broj a u binarni broj, i vrednost konverzije upisuje u 16-
;bitnu promenljivu B. Za konverziju BCD broja koristiti proceduru koja preko steka dobija
;početnu adresu BCD broja i njegovu dužinu u bajtovima, a kao rezultat, takođe preko steka,
;vraća vrednost konverzije. Ukoliko vrednost konverzije premašuje 16 bitova, vratiti -1 kao
;rezultat.

public func
procedure segment
func proc FAR
    assume cs:procedure
    ;1.cuvanje konteksta procesora
	push bp
	mov bp, sp
	pushf 
	push ax
	push bx
	push cx
	push si

    ;2. preuzimanje ulaznih parametara
	mov si, [bp+8]
	mov cx, [bp+6]
    ;3. telo procedure
	xor ax, ax
	add si, cx
	dec si
	dec cx
	mov al, [si]
	dec si
	petlja:
		mov bx, 10
		mul bx
		cmp dx, 0
		jne prekoracenje
		mov bl, [si]
		dec si
		add al, bl
		adc ah, 0
		jc prekoracenje
	loop petlja
	jmp ispod
prekoracenje:
	mov ax, -1
ispod:
	mov [bp+8], ax
    ;4.slanje izlaznih parametara

    ;5.obnavljanje konteksta rocesora
	pop si
	pop cx
	pop bx
	pop ax
	popf
	pop bp
    ;6.povratak na mesto poziva
    ret 2
func endp
procedure ends
end
