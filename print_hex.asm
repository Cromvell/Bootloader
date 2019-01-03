;
;	Printing hex on screen
;
print_hex:
	pusha				; Save all registers

	mov bx, 4			; Init counter
l:
	mov ax, dx			; Copy hex value
	and ax, 0x000F		; Masking least meaning tetrade
	call hex_to_char 	; Convert character in al to char
	mov [HEX_OUT+1+bx], al ; Store character in pattern
	shr dx, 4			; Go to the next tetrade
	dec bx				; Decrement counter
	cmp bx, 0			; Check if number over
	jne l 				; If not continue converting

	mov bx, HEX_OUT 	; Pass pointer to resulting string to print_string function
	call print_string 	; Print resulting hex string
	popa 				; Restore all saved registers
	ret 				; Return from routine

HEX_OUT:
	db '0x0000', 0		; Pattern for output

;
;	Convert hex tetrade to character
;
hex_to_char:
	cmp al, 10		; Check if number less than 10
	jl d 			; If so convert to decimal symbol
	add al, 0x37	; If not convert to hex symbol using 0x37 offset
	jmp eif 		; Jumpt to end of if
d:	
	add al, 0x30	; Convert to decimal symbol using 0x30 offset
eif:
	ret 			; Return from routine