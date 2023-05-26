extrn potisni : far
name Kol2-2010-z6
data segment
MAT dw 8, -9, 4, 5, 10
; bice -9, 4, 5, 8, 10
dw 5, 1, 1, 8, 2
; bice 1, 1, 5, 8, 2
dw 9, 9, 2, 1, 10
; bice 9, 2, 1, 9, 10
dw 5,6,2,1,1
; bice 5, 6, 2, 1, 1
M db 4
N db 5
data ends
stack segment
bos dw 100 dup(?)
tos label word
stack ends
code segment
assume cs:code, ds:data, es:data
start:
mov ax, data
mov ds, ax
mov es, ax ; koristicemo movsw u proceduri
mov ax, stack
mov ss, ax
lea sp, tos

lea di, N ; br. elemenata za prosledjivanje proceduri
lea bx, MAT
mov al, N
xor ah, ah
shl ax, 1 
mov cl, M
xor ch, ch ; CX=M, br. vrsta
petlja:
push BX ; adresa pocetka vrste
; u di je adresa broja elemenata
call far ptr potisni
add BX, ax ; prelazak na sledecu vrstu
loop petlja
mov ah, 4ch
int 21h
code ends
end start
