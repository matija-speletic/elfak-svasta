public func
procedure segment
func proc FAR
    assume cs:procedure
	;funkcija koja u ah smesta karakter kojise ponavlja max broj puta
	;a u al smesta broj ponavljanja tog karaktera
	
    ;1.cuvanje konteksta procesora
	;ovako ide praksa (prvo bp)
	push bp
	mov bp, sp
	pushf 
	push si
	push cx
	push bx
	push dx

    ;2. preuzimanje ulaznih parametara
	mov si, [bp+8]
	mov cx, [bp+6]
	dec cx
	mov ax, 1
	mov bx, 0
	mov dl, [si]
    ;3. telo procedure
	;dijagram za ovo u barcelona svesci pred kraj
	petlja:
		mov dh, [si]
		cmp dh, [si+1]
		je neGrana1
			cmp ax, bx
			jbe neGrana2
				mov bx, ax
				mov dl, [si]
			neGrana2:
				mov ax, 1
			jmp ispod
		neGrana1:
			inc ax
		ispod:
		inc si
	loop petlja
			
    ;4.slanje izlaznih parametara
	mov ax, bx
	mov ah, dl
    ;5.obnavljanje konteksta rocesora
	
	pop dx
	pop bx
	pop cx
	pop si
	popf
	pop bp
    ;6.povratak na mesto poziva
    ret 4
func endp
procedure ends
end


;	int tr = 1, max = 0;
;	int c = 1;
;	int a[12] = { 1,1,1,2,2,2,2,2,3,3,4,5, };
;	for (int i = 0; i < 11; i++)
;	{
;		if (a[i] != a[i + 1])
;		{
;			cout << tr << endl;
;			if (tr > max)
;			{
;				max = tr;
;				c = a[i];
;			}
;			tr = 1;
;		}
;		else
;			tr++;
;	}
;	cout << c;
