;
;   Hello, world!
;
[org 0x7c00]
	
	mov dx, 0x1fb6	; Pass hex value to print_hex function
	call print_hex	; Print hex value

	jmp $			; Halt

%include "funcs.asm"

string:
	db 'Hello, world!', 0

another_string:
	db ' This is OS0', 0

;
;   Padding and magic BIOS number
;

	times 510-($-$$) db 0
	dw 0xaa55