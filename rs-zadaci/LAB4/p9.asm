;proverava da li je podniz
public func
procedure segment
func proc FAR
    assume cs:procedure
    ;1.cuvanje konteksta procesora
	push bp
	mov bp, sp
	pushf 
	push ax
	push bx
	push cx
	push si
	push di
    ;2. preuzimanje ulaznih parametara

    ;3. telo procedure
	mov dx, 0ffffh
	mov si, [bp+8];niz1
	mov di, [bp+6];niz2
	xor bx, bx ;p
	xor cx, cx ;i
	petlja:
	mov ax, [bp+12]
	sub ax, [bp+10]
	inc ax
	cmp cx, ax
	jae kraj
		add si, cx
		mov al, [si+bx]
		cmp al, [di+bx]
		jne negr1
			inc bx
			jmp ispod1
		negr1:
			inc cx
			xor bx, bx
		ispod1:
		cmp bx, [bp+10]
		jne ispod2
			mov dx, cx
			jmp kraj
		ispod2:
		mov si,[bp+8]
	jmp petlja
	kraj:
    ;4.slanje izlaznih parametara

    ;5.obnavljanje konteksta rocesora
	
	pop di
	pop si
	pop cx
	pop bx
	pop ax
	popf
	pop bp
    ;6.povratak na mesto poziva
    ret 8
func endp
procedure ends
end


;int flag = 0; //flag-dx
;int i = 0, p = 0; //i-cx   p-bx
;int niz1[] = { 0,1,2,3,4,5,6,7 },   //niz1-si
;	niz2[] = { 3,4,5 };				 //niz2-di
;int n1 = 8, n2 = 3;
;while (i < n1 - n2 + 1)
;{
;	if (niz1[i + p] == niz2[p]) //posto ne moze [si+bx+cx] sabiramo cx sa si
;								//sabiramo si sa cx, pa na kraju vracamo u si
;		p++;
;	else
;		p = 0, i++;
;
;	if (p == n2)
;	{
;		flag = i;
;		break;
;	}
;}