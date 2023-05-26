;Data su dva niza ASCII karaktera NIZ1 i NIZ2. Kraj nizova je određen karakterom "#". Svaki element određenog niza se pojavljuje samo po jednom u nizu. 
;Na asemblerskom jeziku napisati program koji od zadatih nizova formira novi niz (na lokaciji NIZ3) u koji treba da uđu svi elementi polaznih nizova, 
;pri čemu elemente treba uključiti samo jedanput.
name o2z17
data segment
	niz3 db 25 dup(?)
	niz1 db 'Basme zivo', '#'
	niz2 db 'aBcdefgz', '#'
data ends
code segment
	assume cs:code, ds:data, es:data
start:
	mov ax, data
	mov ds, ax
	mov es, ax
	
	lea si, niz1
	lea di, niz3
	xor dx, dx
	
	;ucitavanje niz1 u niz3
	;i smestanje broja el niza1 u dx
	lodsb
	petlja1:
	cmp al, '#'
	je kraj1
		stosb
		inc dx
		lodsb
	jmp petlja1
	kraj1:
	;na kraju ovog dela, di ce ukazivati na prvo slobodno mesto u nizu3
	
	;obilazak niza2
	lea si, niz2
	lodsb
	petlja2:
	cmp al, '#'
	je kraj2
		mov bp, di;cuvanje vrednosti di zbog scas
		lea di, niz1 ;niz1 kao odredisni zbog scas
		mov cx, dx ;cx broj elemenata niza1
		repne scasb ;trazimo tekuci element niza2 u nizu1
		mov di, bp;vracanje vrednosti di
		;ako je element nadjen ne treba ga kopirati
		jz ispod
			stosb ;ako element nije nadjen - kopirati ga u niz3
		ispod:
		lodsb ;sledeci element niza2
	jmp petlja2
	kraj2:
	
	;stavljanje # na kraj novog niza
	mov byte ptr [di], '#'
	
	mov ah, 4ch
	int 21h
code ends
end start