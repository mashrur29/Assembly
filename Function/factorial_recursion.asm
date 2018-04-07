segment .data
fmt_out: db "The factorial is: %lld", 10,  0
fmt: db "%s", 10, 0
fmt_in: db "%lld", 0
a: dq 0
b: dq 0
n: dq 0

segment .text

global main
extern printf
extern scanf

factorial:
	push RBP
	mov RBP, RSP
	mov RBX, [RBP + 16]
	cmp RBX, 1
	jz base_case
	dec RBX
	push RBX
	call factorial
	mov RBX, [RBP + 16]
	imul RBX
	leave
	ret

	base_case:
		leave
		ret

main:
	push RBP
	mov RBP, RSP

	mov RAX, 0
	mov RBX, 0
	mov RCX, 0

	mov RDI, fmt_in
	mov RSI, n
	call scanf

	mov RAX, [n]
	push RAX

	mov RAX, 1
	call factorial

	mov RBX, 0
	mov RDI, fmt_out
	mov RSI, RAX
	mov RAX, 0
	call printf

	leave
	ret
