;
; JOS boot sector
;
[org 0x7c00]

%include "src/print.asm"

mov bx , DATA_STRING_MYWELCOMEMESSAGE
call print_string

jmp $


DATA_STRING_MYWELCOMEMESSAGE: db "Anything can be put here", 0

times 510 -( $ - $$ ) db 0 ; Pad the boot sector out with zeros
dw 0xaa55 ; Last two bytes form the magic number ,