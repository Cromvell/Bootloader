[bits 16]
;
;	Switch to protected mode
;
switch_to_pm:
	
	cli 	; Disable interrupts
	lgdt [gdt_descriptor] ; Load global descriptor table

	mov eax, cr0	; Change CR0 first bit to 1
	or eax, 0x1		; in order to actually switch
	mov cr0, eax	; to protected mode.

	jmp CODE_SEG:init_pm ; Make far jump to 32-bit code. This also
						 ; forces the CPU to flush its cache of
						 ; pre-fetched and real-mode decoded instructions,
						 ; which can cause problems.

[bits 32]
;	Initialize register and the stack once in PM
init_pm:
	mov ax, DATA_SEG	; Old segments are meaningless,
	mov ds, ax			; so make them point to the data
	mov ss, ax			; sector from GDT.
	mov es, ax
	mov fs, ax
	mov fs, ax
	mov gs, ax

	mov ebp, 0x90000
	mov esp, ebp

	call BEGIN_PM
