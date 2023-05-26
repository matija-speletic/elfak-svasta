data segment
;PRIMER1 - program radi ispravno
NIZ3 DB 0A7h,0B4h,3Ch,0FFh,7h
    NIZ1 DB 1Ah,42h,041h,0Bh,1Dh,75h,34h
    N DB 7
    NIZ2 DB 1Fh,17h,23h,15h,014h,56h,10h
    M DW 5
    
;PRIMER2 - ne void se racuna o prenosu kod 77h+0BBh
;         - program radi ispravno
    ;NIZ1 DB 12h,0ABh,0A1h,0B4h,77h,5h,21h
    ;N DB 7
    ;NIZ2 DB 41h,16h,23h,35h,0BBh,0DAh,17h
    ;M DW 5
    ;NIZ3 DB 57h,14h,32h,14h,3h
data ends
code segment
    assume ds:data, cs:code
start:
    mov ax, data
    mov ds, ax

    ;u si se cuvaju indeksi prvog i drugog niza
    ;polaze oba od 0
    XOR SI, SI
    ;u cx je broj elemenata
    MOV CL, N
    XOR CH, CH

    ;NIZ1 <- NIZ1 + NIZ2
    petlja1:
        MOV AL, NIZ2[SI]
        ADD NIZ1[SI], AL
        INC SI
    LOOP petlja1

    ;cx je broj elemenata niza2
    MOV CL, N
    XOR CH, CH
    ;inicijalizacija si
    XOR SI, SI
    ;inicijalizacija di
    XOR DI, DI
    ;pretpostavka: prvi element je minimalni
    XOR DL, DL
    MOV DL, NIZ2[SI]
    INC SI
    DEC CX ;cx se dekrementira jer preskacemo prvi el

    ;DI <- indexOdMIN(NIZ2)
    ;DL <- MIN(NIZ2)
    petlja2:
        CMP DL, NIZ2[SI]
        JBE ispod1
            MOV DI, SI
            MOV DL, NIZ2[SI]
        ispod1:
        INC SI
    LOOP petlja2

    ;cx je br el niza3
    MOV CX, M
    ;bx je index min u niz2
    MOV BX, DI
    ;si pocinje od m jer upisujemo na kraj niza
    MOV SI, CX
    ;di pocinje od 0 jer uporedjujemo od pocetka drugog niza
    MOV DI, 0
    ;cx uzima vrednost broja el drugog niza
    ;ujedno i br prolaza kroz petlju
    MOV CL, N
    XOR CH, CH

    ;nadovezivanje NIZ2 na NIZ3
    ;uz preskakanje NIZ2[BX]
    petlja3:
    ;if(trenutni el == min el) preskoci taj el
        CMP BX, DI
        JE ispod2
            MOV DH, NIZ2[DI]
            MOV NIZ3[SI], DH
            INC SI;si se samo povecava kad upisujemo na kraj niza3
        ispod2:
        INC DI;di se svakako povecava
              ;jer se ovim omogucava preskakanje min el
    LOOP petlja3
        
    mov ah, 4ch
    int 21h
code ends
end start
