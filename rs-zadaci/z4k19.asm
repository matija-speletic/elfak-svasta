;4.) Dar je tekst sastavljen od ASCII karaktera počev od adrese ASC koji se završava makom $. U tekstu se nalaze redenice koje se završavaju tačkom 
;Napisati program na asemblerskom jeziku koji broj rečenice koje sadrze redi sa velikim početnim slovam (ne racunajuci res na podatko recenice). 
;Napisati i koristiti proceduru koja preko registara vrača ukupan broj redt u zadatoj rečenice koje počinju velikim slovom. 
;Ulazne parametre - adresu početka rečenice i broj karaktera - prenositi preko steka, Nije dozvoljeno karticenie pomoenih niza. 
;Prime: Ova nema nikoga. Ova fina Peru. Ova ima i Miku 1 Lazu 	Rezultat: 2

extrn func:far
data segment
	br dw ?
	asc db 'Ova nema nikoga. Ova fina Peru. Ova ima i Miku 1 Lazu.$'
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

	lea si, asc
	mov di, si
	mov bp, 0
	
	petlja1:
	cmp byte ptr [si], '$'
	je kraj1
		petlja2:
		cmp byte ptr [si], '.'
		je kraj2
			inc si
		jmp petlja2
		kraj2:
		mov ax, si
		sub ax, di
		push ax
		push di
		call func
		
		cmp ax, 1
		je dalje
			inc bp
		dalje:
		
		inc si
		mov di, si
	jmp petlja1
	kraj1:
	
	mov br, bp
	
	mov ax,4c00h
    int 21h
program ends
end start
