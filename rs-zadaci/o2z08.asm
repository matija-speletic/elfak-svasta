;Tekst koji se sastoji od nekoliko rečenica je dat u obliku niza ASCII karaktera smeštenog na lokaciji TXT. 
;Kraj teksta je označen karakterom "#", a kraj svake rečenice tačkom ("."). U rečenici se nalaze reči razdvojene blanko karakterom (" "). 
;Između dve reči može da se nađe samo jedan blanko karakter ili tačka. 
;Napisati asemblerski program koji će na lokaciju REC prekopirati rečenicu iz datog teksta koja ima najviše reči.

data segment
	rec db 70 dup(?)
	txt db 'Ovo je neki tekst.Ovo je neki drugi tekst.Ovo je neki treci tekst sa vise reci.Ovo je nesto.#'
data ends
code segment
	assume cs:code, ds:data
start:
	mov ax, data
	mov ds, ax
	
	lea si, txt
	mov di, si ; di <- pocetak tr. recenice
	mov dx, si ;dx <- max br. indeks (pocetka recenice)
	mov bl, 0 ;bl <- max br. reci
	mov bh, 0 ; bh <- tr.br. reci
	
	;nalazimo indeks pocetka recenice koja ima najvise reci
	;reci brojimo tako sto brojimo blanko znake
	petlja1:
		mov al, [si]
		cmp al, ' '
		jne nijeblanko
			inc bh
		nijeblanko:
		cmp al, '.'
		jne nijetacka
			cmp bh, bl
			jbe nijevece
				mov bl, bh
				mov dx, di
			nijevece:
			mov di, si
			inc di
			mov bh, 0
		nijetacka:
		cmp al, '#'
		je kraj
		inc si
	jmp petlja1
	kraj:
	
	;kopiramo najduzu recenicu do tacke u novi niz
	mov di, dx
	lea si, rec
	petlja2:
		mov al, [di]
		mov [si], al
		inc si
		inc di
		cmp al, '.'
		je kraj2
	jmp petlja2
	kraj2:

	
	mov ah, 4ch
	int 21h
code ends
end start