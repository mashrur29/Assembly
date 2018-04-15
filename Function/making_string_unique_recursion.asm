segment .data

fmt_out: db "%s", 10,  0
fmt_debug: db "Here -> %lld %c", 10, 0
fmt_in: db "%s", 0
str_size: dq 0

segment .bss

array: resq 21
str1: resq 200
str_final: resq 200
mp: resq 200

segment .text

global main
extern printf
extern scanf

make_unique:
	push RBP
	mov RBP, RSP

	mov R8, [RBP + 24] ; main string
	mov R9, [RBP + 16] ; final string

	cmp R8, [str_size] 
	je base_case
	
	mov RAX, 0
	mov AL, [str1 + R8]

	mov RDX, 0
	idiv qword[d]
	mov RAX, RDX

	mov RBX, [mp + RAX*8]
	cmp RBX, 1
	jz increment

	mov RBX, 1
	mov [mp + RAX*8], RBX

	mov [str_final + R9], RAX
	inc R9

	increment:
		inc R8


	push R8
	push R9
	call make_unique

	leave
	ret

	base_case:
		mov AL, 0
		mov [str_final + R9], AL
		leave
		ret

main:
	push RBP
	mov RBP, RSP

	mov RAX, 0
	mov RBX, 0
	mov RCX, 0

	mov RDI, fmt_in
	mov RSI, str1
	call scanf

	mov RAX, 0
	mov RBX, 0
	mov RCX, 0

	SIZE_LOOP:
		cmp qword[str1 + RCX], 0
		jz DONE
		inc qword[str_size]
		inc RCX
		jmp SIZE_LOOP

	DONE:
		mov RAX, 0
		mov RCX, 0
		push RAX
		mov RAX, 0
		push RAX
		call make_unique

		mov RDI, fmt_out
		mov RSI, str_final
		mov RAX, 0
		call printf
	
	leave
	ret

