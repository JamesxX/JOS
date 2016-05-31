; print a single character
print_char:
	mov ah , 0x0e
	int 0x10
	ret

; print a null terminated string
print_string:

	cmp byte [bx] , 0
	je print_string_return
	
	mov al , [bx]
	call print_char
	add bx , 1
	
	jmp print_string
	
	print_string_return:
	ret
	
print_error_string:
	call print_string
	jmp $

; print an integer as a hex
print_hex:
	pusha
	mov cx,4

	char_loop:		
	dec cx

	mov ax,dx
	shr dx,4
	and ax,0xf

	mov bx, print_hex_out
	add bx, 2
	add bx, cx

	cmp ax,0xa
	jl set_letter
	add byte [bx],7
	jl set_letter

	set_letter:
	add byte [bx],al
	
	cmp cx,0
	je print_hex_done
	jmp char_loop

	print_hex_done:
	mov bx, print_hex_out
	call print_string
	
	string_reset:
	mov bx , print_hex_out 
	add bx , 2                    ;start after 0x  
	
	start:
	cmp byte [bx],0
	jne set
	jmp finish



	set: 
	mov byte [bx] , 0x30  
	inc bx
	jmp start

	finish:                      ;function ends
	popa

	ret

; globals
print_hex_out: db '0x0000',0
