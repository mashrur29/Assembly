segment .data
fmt_out: db "The sum is: %lld", 10,  0
fmt: db "%s", 10, 0
fmt_in: db "%lld", 0
a: dq 0
b: dq 0

segment .text

global main
extern printf
extern scanf

print_function:
	push RBP
	mov RBP, RSP
	
	mov RAX, [RBP + 16]
	mov RBX, [RBP + 24]
	add RAX, RBX
	mov [a], RAX
	mov RAX, 0
	mov RBX, 0
	mov RDI, fmt_out
	mov RSI, [a]
	call printf

	leave
	ret

main:
	push RBP
	mov RBP, RSP

	mov RAX, 0
	mov RBX, 0
	mov RCX, 0

	mov RDI, fmt_in
	mov RSI, a
	call scanf

	mov RAX, 0
	mov RBX, 0
	mov RCX, 0

	mov RDI, fmt_in
	mov RSI, b
	call scanf

	mov RAX, [a]
	push RAX
	mov RAX, [b]
	push RAX

	call print_function
	leave
	ret
