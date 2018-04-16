; palindrome check

segment .data

fmt_out: db "%s ",  0
fmt_palin: db "Palindrome", 10, 0
fmt_not_palin: db "Not Palindrome", 10, 0
fmt_debug: db "Here -> %lld", 10, 0
fmt_in: db "%s", 0
fmt_new_line: db "", 10, 0
first_val: dq 2
common_diff: dq 1
n: dq 0
result: dq 0
temp: dq 0
flag: dq 1
str_size: dq 0

segment .bss

taken: resq 2000
str1: resq 2000

segment .text

global main
extern printf
extern scanf

isPalindrome:
	push RBP
	mov RBP, RSP

	mov RCX, [RBP + 32] ; is Palin?
	mov R8, [RBP + 24] ; forward index
	mov R9, [RBP + 16] ; last index

	mov RAX, 0
	mov AL, [str1 + R8]

	mov RBX, 0
	mov BL, [str1 + R9]

	cmp R8, R9
	jge base_case

	cmp RAX, RBX
	je else
	mov RCX, 0
	mov [RBP + 32], RCX

	else:
		inc R8
		dec R9

	mov RCX, [RBP + 32]
	push RCX
	push R8
	push R9

	call isPalindrome

	pop R9
	pop R8
	pop RCX
	mov [RBP + 32], RCX

	leave
	ret

	base_case:	
		leave
		ret

main:
	push RBP
	mov RBP, RSP

	mov RDI, fmt_in
	mov RSI, str1
	mov RAX, 0
	call scanf

	mov RCX, 0

	str_size_loop:
		inc qword[str_size]
		inc RCX
		cmp qword[str1 + RCX], 0
		jne str_size_loop
	
	dec qword[str_size]

	
	mov RAX, 1
	push RAX

	mov RAX, 0
	push RAX
	
	mov RAX, [str_size]
	push RAX

	call isPalindrome

	pop RAX
	pop RAX
	pop RAX

	cmp RAX, 0
	je else2
	mov RDI, fmt_palin
	mov RAX, 0
	call printf
	leave 
	ret
	else2:
		mov RDI, fmt_not_palin
		mov RAX, 0
		call printf
	leave
	ret
