;
;   Hello, world!
;
[org 0x7c00]
	
	mov bx, string
	call print_string

	mov bx, another_string
	call print_string

	jmp $

%include "print_string.asm"

string:
	db 'Hello, world!', 0

another_string:
	db ' This is OS0', 0

;
;   Padding and magic BIOS number
;

	times 510-($-$$) db 0
	dw 0xaa55