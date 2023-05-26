;Napisati program na asemblerskom jeziku koji elemente niza karaktera kopira u drugi
;niz za koji u posebnom segmentu treba rezervisati isto prostora koliko zauzima i
;izvorni niz. Kopiranje vršiti prema sledećem pravilu: samoglasnici se čitaju redom i
;kopiraju redom od početka, suglasnici se čitaju redom i kopiraju unazad od kraja
;rezultujućeg niza. Broj elemenata niza je zapamćen na posebnoj 16-bitnoj lokaciji.
;Napisati i koristiti proceduru koja vraća 1 ukoliko je karakter prenet kao ulazni
;parametar samoglasnik, a 0 u suprotnom. Sve parametre preneti preko registara.
;Primer ulaznog i rezultujućeg niza: razredni -> aeindrzr.
extern vrsta:far
data1 segment
	str1 db 'razredni'
	n dw 8
data1 ends
data2 segment
	str2 db 8 dup(?)
data2 ends
stack segment
	dw 200 dup(?)
	dno label word
stack ends
code segment
	assume cs:code, ds:data1, es:data2, ss:stack
start:
	mov ax, data1
	mov ds, ax
	mov ax, data2
	mov es, ax
	mov ax, stack
	mov ss, ax
	mov sp, dno
	
	lea si, str1
	lea di, str2
	mov cx, n
	cld
	petlja1:
		lodsb
		call vrsta;procedura ne dira al
		cmp ah, 1
		jne dalje1
			stosb
		dalje1:
	loop petlja1
	
	lea si, str1;si<-poc prvog stringa
	lea di, str2
	add di, n
	dec di;di<-kraj drugog stringa
	mov cx, n
	petlja2:
		cld
		lodsb
		call vrsta
		cmp ah, 0
		jne dalje2
			std
			stosb
		dalje2:
	loop petlja2
	
	mov ah, 4ch
	int 21h
code ends
end start