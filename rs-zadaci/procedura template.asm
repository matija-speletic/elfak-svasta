;extrn n:word ;byte | word | dword
;extrn niz:word
;extrn suma:word
public func
procedure segment
func proc FAR
    assume cs:procedure
    ;1.cuvanje konteksta procesora
	push bp
	mov bp, sp
	pushf 

    ;2. preuzimanje ulaznih parametara

    ;3. telo procedure

    ;4.slanje izlaznih parametara

    ;5.obnavljanje konteksta rocesora

	popf
	pop bp
    ;6.povratak na mesto poziva
    
func endp
procedure ends
end
