public func
procedure segment
func proc FAR
    assume cs:procedure
    ;1.cuvanje konteksta procesora
	push bp
	mov bp, sp
	pushf 
	;push ax ;ne stavljamo jer preko ax prenosimo rezultat

	mov al, [bp+8]   ;AL <- X
	sub al, [bp+6]   ;AL <- AL - Y
	cbw ;funkcija vraca podatak preko AX u vidu 16bit
		;samo da bi se jasno razlikovao oznaceni rezultat
		;ovo ne utice na funkcionalnost programa jer se 
		;visi bajt ignorise

	popf
	pop bp

	ret 4
    
func endp
procedure ends
end
