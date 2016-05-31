;
; JOS boot sector
;
[org 0x7c00]

	mov bp , 0x8000
	mov sp , bp

	mov bx , MSG_REAL_MODE
	call print_string

	call switch_to_pm
	jmp $


%include "src/real/print.asm"
%include "src/real/disk.asm"

%include "src/protected/gdt.asm"
%include "src/protected/print_string_pm.asm"
%include "src/protected/switch_to_pm.asm"

[bits 32]

BEGIN_PM:
	mov ebx , MSG_PROT_MODE
	call print_string_pm
	jmp $

; Global variables
MSG_REAL_MODE db "Started in 16 - bit Real Mode", 10, 13, 0
MSG_PROT_MODE db "Successfully landed in 32 - bit Protected Mode" , 0

; Pad the file so it works as a boot sector
times 510 -( $ - $$ ) db 0
dw 0xaa55