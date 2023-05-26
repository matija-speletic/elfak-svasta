;Dat je niz ASCII karaktera počev od adrese ASC. Broj elemenata niza dat je na
;osmobitnoj lokaciji N. Napisati program na asemblerskom jeziku koji pojavljivanja malih
;slova engleske abecede u abecednom redosledu, počev od ‘a’, zamenjuje odgovarajućim
;velikim slovom. Ostale karaktere ne treba transformisati. Na memorijsku lokaciju BR
;upisati broj zamenjenih karaktera a na lokaciju SL poslednji zamenjeni karakter.
;Primer: „Nikola Bi bas ceo dan Beogradom furao.“
;„NikolA Bi Bas Ceo Dan BEogradom Furao.“

data segment
	niz db 'Nikola Bi bas ceo dan Beogradom furao gradom himalaja Krhkih ledolomaca na morskoj pucini.'
	n   db 45
data ends
code segment
	assume cs:code, ds:data, es:data
start:
	mov ax, data
	mov ds, ax
	mov es, ax
	
	mov bl, 'a'
	lea si, niz
	mov di, si
	petlja:
		lodsb
		cmp al, bl
		jne dalje
			sub al, 'a'-'A'
			inc bl
		dalje:
		stosb
	cmp bl, 'z'+1
	je kraj
	cmp al, '.'
	je kraj
	jmp petlja
	kraj:
	
	mov ah, 4ch
	int 21h
code ends
end start