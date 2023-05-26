data segment
	niz db 'Ovo Je   Neka recenica Sa 1EC1M4. NestO nESTo'
	n   db 45
data ends
code segment
	assume cs:code, ds:data, es:data
start:
	mov ax, data
	mov ds, ax
	mov es, ax
	
	;izvorisni i odredisni niz se poklapaju
	lea si, niz
	mov di, si
	;CX <- broj elemenata
	mov cl, n
	mov ch, 0
	;BP <- indikator: da li je prethodni znak bio blanko (jeste - 0ffffh; nije - 0)
	mov bp, 0
	;autoinrementiranje
	cld
	
	;n puta prolazimo (kroz svaki karakter)
	petlja:
		;AL <- [SI++]
		lodsb
		
		;ako je trenutni karakter blanko - postavi indikator
		cmp al, ' '
		jne dalje1
			mov bp, 0ffffh
		dalje1:
		
		;ako je trenutni karakter veliko slovo 
		cmp al, 'A'
		jb dalje2
		cmp al, 'Z'
		ja dalje2
		;i prethodni karakter je bio blanko (BP = 0ffffh)
		cmp bp, 0ffffh
		jne dalje2
			mov bp, 0 ;resetovanje indikatora
			add al, 'a'-'A' ;konverzija u malo slovo
		dalje2:
		
		;ako nije blanko znak
		cmp al, ' '
		je dalje3
			mov bp, 0 ;resetuj indikator
			;ovaj deo resenja obezbedjuje da se ' 1EC1M4'
			;ne pretvori u ' 1eC1M4'
			;generalno, obezbedjuje da indikator ne ostane greskom aktiviran
			;kada prvi karakter posle blanko znaka nije veliko slovo
		dalje3:
		
		stosb ;[DI++] <- trenutni karakter (procesiran)
		
	loop petlja
	
	mov ah, 4ch
	int 21h
code ends
end start

;Definisati niz karaktera. Broj elemenata je zapamćen na posebnoj 8-bitnoj lokaciji. 
;Transformisati niz tako da svako slovo koje se nalazi neposredno iza blanko karaktera bude malo slovo.
;Sve pristupe elementima nizova u memoriji realizovati isključivo instrukcijama za rad s nizovima.

