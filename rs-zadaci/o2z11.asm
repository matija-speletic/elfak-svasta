;Napisati program na asemblerskom jeziku koji sabira dva BCD broja, BR1 i BR2. 
;Počev od adrese BR1 se nalazi niz pakovanih BCD cifara pri čemu se cifra najmanje težine nalazi na najvišoj adresi. 
;Počev od adrese BR2 se nalazi niz nepakovanih BCD cifara pri čemu se cifra najmanje težine nalazi na najnižoj adresi. 
;BR1 ima paran broj cifara i taj broj je zapamćen je na šesnaestobitnoj lokaciji N1. Kraj niza cifara BR2 označen je bajtom 0FFh. 
;Rezultat treba smestiti na mesto BR2 po istim pravilima po kojima je bio smešten BR2. 
;Smatrati da pri sabiranju ne dolazi do povećanja broja cifara broja BR2.

data segment
    br1 db 25h, 34h ; 5243
    br2 db 1h, 2h, 3h, 6h, 5h , 0ffh ; 56321, rezultat je 61564
    N1 db 4 ; br cifara u BR1
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

	mov al, N1
	mov ah, 0
	shr ax, 1
	dec ax
	mov si, ax
	mov di, 0
	clc
	pushf
	
	petlja:
	cmp si, 0
	jl kraj
		mov bl, br1[si]
		mov bh, bl
		shr bl, 1
		shr bl, 1
		shr bl, 1
		shr bl, 1
		and bh, 0fh
		mov al, br2[di]
		mov ah, br2[di+1]
		mov dh, ah
		popf
		adc al, bl
		aaa
		mov dl, al
		mov al, dh
		adc al, bh
		aaa
		pushf
		mov ah, al
		mov al, dl
		mov br2[di], al
		mov br2[di+1], ah
		add di, 2
		dec si
		
	jmp petlja
	kraj:
	
	petlja2:
	mov al, br2[di]
	cmp al, 0ffh
	je kraj2
		popf
		adc al, 0
		aaa
		pushf
		mov br2[di], al
		inc di
	jmp petlja2
	kraj2:
	
	mov ax,4c00h
    int 21h
program ends
end start
