name labzad
data segment

    ;PRIMER 1: Program radi standardno
    ;p1 dd 12h ;iako je u zadatu ovaj podatak 8bit, neophodno je rezervisati duplu memorijsku rec kako bi se kasnije u p1 mogao smestiti rezultat p2+p3
    ;p2 dd 11fffeh ;za 24 bit potrebno je minimum dd
    ;p3 dw 2h ;16bit je jedna memorijska rec
    ;u ovom primeru će se posle prvog sabiranja postaviti cf i zf

    ;PRIMER 2: u ovom primeru se dobie tacan rezultat (gde je 25. bit cf), ali se on ne upisuje ispravno u memoriju, jer je sirina cl ogranicena (ovaj program smesta maksimalno 24bita podataka) - ovo se moze izmeniti koriscenjem cx registra umesto cl( a samim tim i word ptr umesto byte ptr u odgovarajucim linijama)
    ;aktivira se cf pri oba sabiranja
    p1 dd 0abh 
    p2 dd 0ffffffh 
    p3 dw 7890h

    ;PRIMER 3: program nece raditi jer su promenljive inicijalizovane sa pogresnim sirinama
    ;p1 db 12h 
    ;p2 dd 45abcdh 
    ;p3 db 7890h
data ends

code segment
    assume cs:code, ds:data

start:
    mov ax, data
    mov ds, ax

    mov ax, p3 ;u ovoj instruciji se ne smeju koristiti segmentni registri  
               ;pokusaj kopiranja memorijskog sadržaja u segmentni registar 
               ;će rezultovati greškom
               ;mogu se koristiti npr registri opšte namene
    mov p3, 0abcdh

    mov bx, word ptr p2
    mov cl, byte ptr p2+2
    mov word ptr p1, bx
    mov byte ptr p1+2, cl

    add bx, ax
    adc cl,0
    mov word ptr p1, bx
    mov byte ptr p1+2, cl

    mov ah,4ch
    int 21h
code ends
end start