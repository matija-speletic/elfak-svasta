;Definisati niz karaktera. Broj elemenata je zapamćen na posebnoj 8-bitnoj lokaciji. 
;Transformisati niz tako da svako slovo koje se nalazi neposredno iza blanko karaktera bude malo slovo.
;Sve pristupe elementima nizova u memoriji realizovati isključivo instrukcijama za rad s nizovima.

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
	
	cld;autoinkrementiranje
	
	;string instrukcije same dekrementiraju cx
	petlja:

		mov al, ' '
		repe scasb;inkrementiranje di sve dok se nije doslo do kraja ili do prvog znaka koji nije blanko
		dec di;jer ce di ukazivati na drugi karakter posle blanko
		mov si, di ;isti trenutni karakter izvora i odredista

		lodsb;ucitacanje u al

		cmp al, 'A'
		jb dalje1
		cmp al, 'Z'
		ja dalje1
			add al, 'a'-'A';ako je veliko slovo => konverzija u malo
		dalje1:

		stosb;cuvanje obradjenog karaktera

		mov al, ' '
		repne scasb;inkrementiranje do kraja ili do prvog blanko znaka
		dec di;jer ce di ukazivati na prvi sledeci karakter
		mov si, di;si i di trebaju ukazivati na isti karakter
		
	cmp cx, 0
	jle kraj;ako je cx manje ili jednako nuli (ako se doslo do kraja) - izlazak iz petlje
	jmp petlja
	kraj:
	
	mov ah, 4ch
	int 21h
code ends
end start