;
;   Hello, world!
;
[org 0x7c00]
	
	mov [BOOT_DRIVE], dl	; Save number of current boot drive

	mov bp, 0x8000			; Initialize stack base and 
	mov sp, bp				; stack pointer to 0x8000

	mov bx, 0x9000			; Load 5 sectors to 0x0000(ES):0x9000(BX)
	mov dh, 5				; from the boot disk.
	mov dl, [BOOT_DRIVE]
	call disk_load

	mov dx, [0x9000]		; Print first word 0xdada
	call print_hex

	mov dx, [0x9000 + 512]	; Print word from 2nd sector 0xface
	call print_hex

	jmp $	; Halt

%include "print_string.asm"
%include "print_hex.asm"
%include "disk_load.asm"

; Global vars
BOOT_DRIVE: db 0

; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55

times 256 dw 0xdada
times 256 dw 0xface