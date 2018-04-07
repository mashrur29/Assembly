segment .data
fmt_out: db "The gcd value of %lld and %lld is: %lld", 10,  0
fmt_debug: db "Here -> %lld %lld", 10, 0
fmt: db "%s", 10, 0
fmt_in: db "%lld", 0
a: dq 0
b: dq 0
n: dq 0
o1: dq 0
o2: dq 0
curn: dq 0
mod: dq 0
prev: dq 0
res: dq 0
arg: dq 2

segment .text

global main
extern printf
extern scanf

gcd:
	push RBP
	mov RBP, RSP
	mov RAX, [RBP + 24] ; a
	mov RBX, [RBP + 16] ; b
	
	cmp RBX, 0
	je base_case

	mov RAX, [RBP + 24] ; a
	mov RBX, [RBP + 16] ; b

	mov RDX, 0
	idiv RBX
	mov [mod], RDX

	mov RDX, [RBP + 16]
	push RDX
	mov RDX, [mod]
	push RDX
	call gcd

	leave
	ret

	base_case:
		mov RCX, [RBP + 24]
		mov [res], RCX
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

	mov RAX, 0
	mov RBX, 0
	call gcd

	mov RBX, 0
	mov RDI, fmt_out
	mov RSI, [a]
	mov RDX, [b]
	mov RCX, [res]
	mov RAX, 0
	call printf

	leave
	ret
