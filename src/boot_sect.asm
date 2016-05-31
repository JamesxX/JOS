;
; JOS boot sector
;
[org 0x7c00]

%include "src/setup_stack.asm"
%include "src/print.asm"

mov bx , DATA_STRING_MYWELCOMEMESSAGE
call print_string

mov bx , DATA_STRING_NEWLINE
call print_string

mov dx, 0x1fb7		; Set the value we want to print to dx
call print_hex		; Print the hex value

jmp $


DATA_STRING_NEWLINE: db 10, 13, 0
DATA_STRING_MYWELCOMEMESSAGE: db "Anything can be put here", 0

times 510 -( $ - $$ ) db 0 ; Pad the boot sector out with zeros
dw 0xaa55 ; Last two bytes form the magic number ,