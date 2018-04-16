; Tower of Hanoi

segment .data

fmt_out: db "Move Disk %lld from %c to %c", 10,  0
fmt_debug: db "Here -> %lld", 10, 0
fmt_in: db "%lld", 0
fmt_new_line: db "", 10, 0
first_val: dq 2
common_diff: dq 1
n: dq 0
A: dq 65
B: dq 66
C: dq 67

segment .bss

taken: resq 2000
str1: resq 2000

segment .text

global main
extern printf
extern scanf

tower_of_hanoi:
	push RBP
	mov RBP, RSP

	mov R8, [RBP + 40] ; n

	cmp R8, 1
	je base_case

	dec R8
	push R8
	mov RAX, [RBP + 32]
	push RAX
	mov RAX, [RBP + 16]
	push RAX
	mov RAX, [RBP + 24]
	push RAX

	call tower_of_hanoi

	pop RAX
	pop RAX
	pop RAX
	pop RAX

	
	; ------------------

	mov RDI, fmt_out
	mov RSI, [RBP + 40]
	mov RDX, [RBP + 32]
	mov RCX, [RBP + 24]
	mov RAX, 0
	call printf

	; --------------------

	mov R8, [RBP + 40]
	dec R8
	push R8
	mov RAX, [RBP + 16]
	push RAX
	mov RAX, [RBP + 24]
	push RAX
	mov RAX, [RBP + 32]
	push RAX

	call tower_of_hanoi

	leave
	ret

	base_case:
		mov RAX, 1
		mov RDI, fmt_out
		mov RSI, RAX
		mov RDX, [RBP + 32]
		mov RCX, [RBP + 24]
		mov RAX, 0
		call printf

		leave
		ret

main:
	push RBP
	mov RBP, RSP

	mov RDI, fmt_in
	mov RSI, n
	mov RAX, 0
	call scanf

	
	mov RAX, [n]
	push RAX

	mov RAX, [A]
	push RAX
	
	mov RAX, [C]
	push RAX

	mov RAX, [B]
	push RAX

	call tower_of_hanoi

	leave
	ret
