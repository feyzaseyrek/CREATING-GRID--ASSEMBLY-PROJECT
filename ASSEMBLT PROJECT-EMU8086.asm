.stack 100h ;------------------------------------------ .data ;------------------------------------------ msj1 db 'Enter a row number: $'
msj4 db 'Enter a column number: $' msj2 db 13,10,'Number has been converted',13,10,13,10,'$' string db 3 ;MAX NUMBER OF CHARACTERS ALLOWED (2). db ? ;NUMBER OF CHARACTERS ENTERED BY USER. db 5 dup (?) ;CHARACTERS ENTERED BY USER. msj3 db 3 k dw 0000h t dw 0000h

.code

mov ax, @data mov ds, ax

mov ah, 9 mov dx, offset msj1 int 21h

mov ah, 0Ah mov dx, offset string int 21h

call string2number

proc string2number
mov si, offset string + 1 mov cl, [ si ]
mov ch, 0 add si, cx mov bx, 0 mov bp, 1 repeat:
mov al, [ si ] sub al, 48 mov ah, 0 mul bp add bx,ax ; mov ax, bp mov bp, 10 mul bp mov bp, ax
dec si loop repeat endp mov k,bx

mov ah, 9 mov dx, offset msj4 int 21h

mov ah, 0Ah mov dx, offset string int 21h

call string3number

proc string3number
mov si, offset string + 1 mov cl, [ si ]
mov ch, 0 add si, cx mov bx, 0 mov bp, 1 repeat2:
mov al, [ si ] sub al, 48 mov ah, 0 mul bp add bx,ax ; mov ax, bp mov bp, 10 mul bp mov bp, ax
dec si loop repeat2 endp

mov t,bx

;ekran olusturma ; clear the screen mov ax,0600h ;scroll the screen mov bh,17h ;normal attribute mov cx,0000 ;from row=00,column=00 mov dx,6f6fh ;to row=18h, column=4fh int 10h ;invoke the interrupt to clear screen mov ah,00h ;set mode mov al,12h ;mode=13(CGA High resolution) ;mov bl, 17h ; This is Blue & White. int 10h ;invoke the interrupt to change mode

mov dx,0 mov ax,240 div k mov bx,ax ;her çizgi arasinda ax piksel var mov cx,80 ;start line at column=80 and mov dx,80 ;row=0 add k,1

     ;yana dogru cizgiler        
    ;alt alta çcizmek icin dx artirarak devam edecegiz
hseT: mov ah,0ch ;ah=0ch to draw a line mov al,07h ;pixels=light grey int 10h ;invoke the interrupt to draw the line inc cx ;increment the horizontal position inc cx inc cx cmp cx,320 ;draw line until column=75 jnz hseT

loop1: mov cx,80 add dx,bx sub k,1 cmp k,0 jnz hseT

mov dx,0 mov ax,240 div t mov bx,ax ;her çizgi arasında ax piksel var mov cx,80 ;start line at column=80 and mov dx,80 ;row=80 add t,1

    ;asagi dogru cizgiler
    ;yan yana çcizmek icin cx artirarak devam edecegiz
hseL: mov ah,0ch mov al,07h int 10h inc dx inc dx inc dx cmp dx,320 jnz hseL

loop2: mov dx,80 add cx,bx sub t,1 cmp t,0 jnz hseL ret
