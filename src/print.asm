jmp print_asm_eof


print_char:
	mov ah , 0x0e
	int 0x10
	ret
	
print_string:

	; [bx] = string
	
	;add bx , 0x7c00 ; Add offset
	
	print_string_sol:
	cmp byte [bx] , 0
	je print_string_return
	
	mov al , [bx]
	call print_char
	
	add bx , 1
	jmp print_string_sol
	
	
	print_string_return:
	ret
	
print_asm_eof: