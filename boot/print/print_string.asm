;
;	Printing string on screen
;
print_string:
	pusha			; Save all registers on stack
	mov ah, 0x0e	; Initialize BIOS tele-type output

lp:					; While loop for print string
	mov al, [bx]	; Move character to al
	cmp al, 0		; Check for end of string
	je end 			; Jumpt if string ends
	int 0x10		; Call BIOS tele-type routine
	inc bx			; Go to next character
	jmp lp 			; Jump to next loop iteration

end:
	popa 			; Restore all saved registers
	ret 			; Return from routine
