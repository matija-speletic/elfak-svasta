data segment
dw ?
db ?
m dw 405h
db 3
n dw 119h
p db ?
dd (5670-9-1)/4 DUP(?) ; ukoliko se vodi računa i o fizičkim adresama iz
;uslova zadatka, nije neophodno
db ?
data ends
extra segment
A dd 16080602h
B db 13h
extra ends
code segment
assume cs:code, ds:data, es:extra
start:
mov ax, data
mov ds, ax
mov ax, extra
mov es, ax

mov di, 2
mov m[di], 12h

mov ah, 4ch
int 21h
code ends
end start
