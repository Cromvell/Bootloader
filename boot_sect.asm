;
;   Hello!
;

mov ah, 0x0e ; ah = 0x0e scrolling teletype BIOS routine

mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
mov al, 'l'
int 0x10
mov al, 'o'
int 0x10
mov al, '!'
int 0x10

jmp $

;
;   Padding and magic BIOS number
;

times 510-($-$$) db 0
dw 0xaa55