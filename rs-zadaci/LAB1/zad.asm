name uvod ; ime programa
data segment
 podatak1 dw 1 ; definisanje prvog podatka
 podatak2 dw 2 ; definisanje drugog podatka
 rezultat dw 0 ; definisanje memorijske lokacije za rezultat
 ; i dodeljivanje po~etne vrednosti
data ends
code segment
 assume cs:code, ds:data
start:
mov ax, data
mov ds, ax
mov bx, podatak1 ; sme{tanje prvog podatka u registar bx
mov ax, podatak2 ; sme{tanje drugog podatka u registar ax
add ax, bx ; sabiranje prvog i drugog podatka i sme{tanje
 ; rezultata u registar ax
mov rezultat,ax ; sme{tanje rezultat na memorijsku lokaciju ; rezultat
mov ax, 4c00H
int 21h ; prekidna procedura za izlazak u DOS
 ; obja{njena u ~etvrtoj ve`bi
code ends
end start 

