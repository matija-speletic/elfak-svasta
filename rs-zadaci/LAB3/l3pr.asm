;Odrediti razliku u zbiru elemenata dva niza 16-to bitnih elemenata zadatih na memorijskim
;adresama niz1 i niz2, pri ~emu je broj elemenata niza (isti je za oba niza) zadat na
;memorijskoj adresi brojel . Razliku smestiti na memorijsku adresu razlika. Zbirove elemenata
;nizova smestiti na memorijske adrese zbir1 i zbir2. 

data segment
    NIZ1 DW 0FFFFh, 83FFh, 9765h, 7777h, 3547h, 0FEFEh, 7FE8h
    NIZ2 DW 0ABCDh, 1234h, 9876h, 0DCBAh, 71AAh, 1111h, 7FE8h
    K DB 7
    ZBIR1 DD ?
    ZBIR2 DD ?
    RAZLIKA DD ?
data ends
code segment
    assume ds:data, cs:code
start:
    mov ax, data
    mov ds, ax

    ;sabiranje el prvog niza
    MOV CL, K
    XOR CH, CH
    XOR SI, SI
    XOR AX, AX
    XOR DX, DX
    petlja1:
        ADD AX, NIZ1[SI]
        ADC DX, 0
        ADD SI, 2
    LOOP petlja1

    MOV WORD PTR ZBIR1, AX
    MOV WORD PTR ZBIR1+2, DX

    ;sabiranje el drugog niza
    MOV CL, K
    XOR CH, CH
    XOR SI, SI
    XOR AX, AX
    XOR DX, DX
    petlja2:
        ADD AX, NIZ2[SI]
        ADC DX, 0
        ADD SI, 2
    LOOP petlja2

    MOV WORD PTR ZBIR2, AX
    MOV WORD PTR ZBIR2+2, DX

    MOV BX, WORD PTR ZBIR1+2
    CMP BX, WORD PTR ZBIR2+2
    JG oduzmiOd1;ako je visi bajt prvog veci od viseg bajta drugog - oduzmi od prvog 
    JL oduzmiOd2;ako je visi bajt prvog manji od viseg bajta drugog - oduzmi od drugog
    
    ;ako su jednaki - poredi nizi bajt (ista kogika)
    MOV BX, WORD PTR ZBIR1
    CMP BX, WORD PTR ZBIR2
    JG oduzmiOd1
    JL oduzmiOd2

    ;ako su oba bajta jednaka razlika je: DX:AX <- 0
    XOR AX, AX
    XOR DX, DX
    JMP kraj

    oduzmiOd1:
        MOV AX, WORD PTR ZBIR1
        MOV DX, WORD PTR ZBIR1+2
        SUB AX, WORD PTR ZBIR2
        SBB DX, WORD PTR ZBIR2+2  
        JMP kraj
    
    oduzmiOd2:
        MOV AX, WORD PTR ZBIR2
        MOV DX, WORD PTR ZBIR2+2
        SUB AX, WORD PTR ZBIR1
        SBB DX, WORD PTR ZBIR1+2  
        ;JMP kraj
    
    kraj:
    ;mem <- DX:AX
    MOV WORD PTR RAZLIKA, AX
    MOV WORD PTR RAZLIKA+2, DX

    mov ah, 4ch
    int 21h
code ends
end start