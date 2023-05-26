;Na lokaciji TEKST dat je niz karaktera koji predstavlja rečenice koje se sastoje od reči. Reči su razdvojene jednim ili sa više blanko karaktera. 
;Rečenice se završavaju tačkom. Kraj teksta označen je znakom '$'.
;Napisati asemblerski program koji će zadati tekst transformisati po sledećim pravilima: svaka rečenica počinje velikim slovom; između svake dve reči nalazi se tačno jedan blanko znak. 
;Transformisani tekst treba da se nalazi na istoj lokaciji gde i izvorni, i takođe treba da se završava znakom '$'.

data segment
	tekst db 'ovo   je neki.    mnogo   lep tekst. bla$'
data ends
code segment
	assume cs:code, ds:data
start:
	mov ax, data
	mov ds, ax
	
	lea si, tekst
	lea di, tekst
	mov bh, 0ffh
	
	petlja:
		mov al, [si]
		cmp al, '.'
		jne nijetacka
			mov bh, 0ffh
		nijetacka:
		cmp al, ' '
		je blanko
		cmp al, '$'
		je kraj
		
		cmp al, 'a'
		jb negr
		cmp al, 'z'
		ja negr
		cmp bh, 0ffh
		jne negr
			sub al, 'a'-'A'
			mov bh, 0
		negr:
		
		mov [di], al
		inc si
		inc di
		jmp petlja
		
		upis:
			mov al, [si]
			mov [di], al
	jmp petlja
	
	blanko:
		mov al, [si]
		mov [di], al
		petlja1:
			inc si
			mov al, [si]
			cmp al, ' '
		je petlja1
		inc di
	jmp upis
	
	kraj:
	mov al, '$'
	mov [di], al
	
	mov ah, 4ch
	int 21h
code ends
end start


;IDEJA:
;	u al si cuvamo trenutni karakter niza, a u di trenutni karakter ispravljenog niza
;	kada se dodje do tacke postavlja se indikator bh da sledece slovo treba da bude veliko (bh je na pocetku aktiviran jer prvo slovo treba biti veliko)
;	ako je u si blanko znak - ide se na deo za obradu blanko znaka
;		prvo se upisuje taj blanko znak u ispravljeni niz
;		zatim se si povecava sve dok su blanko znaci (do prvog slova)
;		na kraju se poveca i di (mesto na koje treba upisati karakter)
;		ide se na deo za upis - upisuje se u di_mem <- si_mem i ide se na sledeci obilazak
;	ako je karakter za kraj - izlazi se iz cele petlje - upisuje se znak za kraj i zavrsava se program
;	ako nije nista od navedenog - proverava se da li je malo slovo i da li je indikator aktiviran - ako je ispunjeno - ispravlja se na veliko
;	povecavaju se si i di - sledeci karakter