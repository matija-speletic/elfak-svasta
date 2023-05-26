;Dat je niz ASCII karaktera počev od adrese ASC koji se završava znakom '$'. Napisati program
;na asemblerskom jeziku koji transformiše niz karaktera tako što svaku reč koja je sa obe strane
;omeđena jednostrukim navodnicima ne menja, a svim ostalim rečima prvo slovo reči transformiše u
;veliko slovo. Ostali karakteri se ne menjaju.
;Primer: "Je l' i vi 'volite' 'racunarske sisteme' k'o i mi?!$"
; "Je L' I Vi 'volite' 'Racunarske Sisteme' K'o I Mi?!$"

data segment
	asc db "Je l' i vi 'volite' 'racunarske sisteme' k'o i mi?!$"
data ends
program segment
    assume cs:program, ds:data
start:
	mov ax, data
	mov ds, ax

	lea si, asc
	lea di, asc
	mov bl, 0ffh
	petlja1:
	cmp byte ptr [si], '$'
	je kraj1
		cmp byte ptr [si], '$'
		jne dalje0
			jmp kraj1 ;kraj ako se stigne do $
		dalje0:
		
		;ako je aktiviran indikator i malo je slovo - 
		;povecaj slovo i deaktiviraj indikator
		cmp bl, 0ffh
		jne dalje1
		cmp byte ptr [si], 'a'
		jb dalje1
		cmp byte ptr [si], 'z'
		ja dalje1
			sub byte ptr [si], 'a'-'A'
			mov bl, 0
		dalje1:
		
		;ako je indikator aktiviran i veliko je slovo
		;deaktiviraj indikator
		;stiti od situacija kada je prvo slovo posle razmaka veliko
		;da indikator ne ostane greskom aktiviran i poveca drugo slovo
		cmp bl, 0ffh
		jne dalje5
		cmp byte ptr [si], 'A'
		jb dalje5
		cmp byte ptr [si], 'Z'
		ja dalje5
			mov bl, 0
		dalje5:
		
		;ako je razmak aktiviraj indikator
		cmp byte ptr [si], ' '
		jne dalje2
			mov bl, 0ffh
		dalje2:
		
		;ako je apostrof
		cmp byte ptr [si], "'"
		jne dalje3
			mov di, si ; di ukazuje na trenutni el
			
			;povecavaj di do prvog karaktera koji nije malo slovo
			petlja2:
				inc di
			cmp byte ptr [di], 'a'
			jb kraj2
			cmp byte ptr [di], 'z'
			ja kraj2
			jmp petlja2
			kraj2:
			
			;ako je taj karakter apostrof - deaktiviraj indikator
			;jer to znaci da je rec izmedju apostrofa
			cmp byte ptr [di], "'"
			jne dalje4
				mov bl, 0
			dalje4:
		dalje3:
		
		inc si ;sledeci element
	jmp petlja1
	kraj1:
	
	mov ax,4c00h
    int 21h
program ends
end start
