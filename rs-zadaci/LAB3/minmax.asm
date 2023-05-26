;37. Naci minimalni element
;prvog niza I maksimalni
;element drugog niza I zameni
;im mesta.

data segment
    NIZ DB 120,11,45,104,77,5,210,32,47
    N DB 9
data ends
code segment
    assume ds:data, cs:code
start:
    mov ax, data
    mov ds, ax

    MOV CL, N
    XOR CH, CH
    XOR SI, SI
    ;AL - INDEX MIN
    ;AH - INDEX MAX
    ;BL - MIN
    ;BH - MAX
    ;polazna pretpostavka:
    ;prvi el je i min i max
    XOR AX, AX;indekse postavljamo na nulu
    MOV BL, NIZ[SI]
    MOV BH, BL
    INC SI

    petlja:
        ;cuvanje indeksa u dl
        MOV DX, SI
        ;cuvanje trenutnog elementa u dh
        MOV DH, NIZ[SI] ;jedini pristup memoriji

        ;poredi trenutni el sa minimalnim
        CMP DH, BL
        JAE neGrana1
            ;ako je manji upisuje novi minimalni i indeks
            MOV BL, DH
            MOV AL, DL
        neGrana1:

        ;poredi trenutni el sa maksimalnim
        CMP DH, BH
        JBE neGrana2
            ;ako je veci upisuje novi maksimalni i indeks
            MOV BH, DH
            MOV AH, DL
        neGrana2:

        INC SI;povecanje si
    LOOP petlja

    ;komplikovaniji deo: (jer SI,AL nije legalno)
    ;u ah je indeks max
    ;hocemo indeks max da prebacimo u dx
    MOV DL, AH;prebacimo u dl
    XOR DH, DH;u dh stavimo 0
    MOV SI, DX;prebacimo indeks iz dx u si
    MOV NIZ[SI],BL;na mesto max upisemo min
    
    ;u al se vec nalazi index min
    XOR AH, AH;ubacimo u ah 0 da u ax bude index min
    MOV SI, AX;index min
    MOV NIZ[SI], BH;na lokaciju min ubacimo max

        
    mov ah, 4ch
    int 21h
code ends
end start