; n val_to_search
; array

segment .data
fmt_out: db "The value is present at: %lld", 10,  0
fmt_debug: db "Here -> %lld %lld", 10, 0
fmt_not_found: db "Not Found", 10, 0
fmt: db "%s", 10, 0
fmt_in: db "%lld", 0
a: dq 0
b: dq 0
n: dq 0
o1: dq 0
o2: dq 0
cnt: dq 0
mod: dq 0
fnd: dq 0
res: dq -1
arg: dq 2

segment .bss
array resq 21

segment .text

global main
extern printf
extern scanf

binary_search:
	push RBP
	mov RBP, RSP
	mov RAX, [RBP + 24] ; lo
	mov RBX, [RBP + 16] ; hi

	cmp RAX, RBX
	jg base_case

	add RAX, RBX
	mov RBX, 2
	mov RDX, 0
	div RBX

	mov RCX, RAX
	dec RCX
	mov RDX, [array + RCX*8]
	inc RCX

	cmp RDX, [fnd]
	jz found

	compare:
		cmp RDX, [fnd]
		jle less_equal
		jmp greater

	found:
		mov [res], RCX
		jmp compare

	less_equal:
		inc RCX
		mov RDX, RCX
		push RDX
		mov RDX, [RBP + 16]
		push RDX
		call binary_search
		jmp base_case

	greater:
		mov RDX, [RBP + 24]
		push RDX
		dec RCX
		mov RDX, RCX
		push RDX
		call binary_search

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
	inc RAX
	mov [res], RAX

	mov RAX, 0
	mov RBX, 0
	mov RCX, 0

	mov RDI, fmt_in
	mov RSI, fnd
	call scanf

	mov RAX, 0
	mov RBX, 0
	mov RCX, 0

	INPUT_ARRAY: 
		cmp RCX, [n]
		jz DONE
		mov [cnt], RCX
		mov RAX, 0
		mov RDI, fmt_in
		mov RSI, a
		call scanf
		mov RAX, [a]
		mov RCX, [cnt]
		mov [array+RCX*8], RAX
		add RBX, [a]	
		inc RCX	
		jmp INPUT_ARRAY 

	DONE:
		mov RAX, 1
		push RAX

		mov RAX, [n]
		push RAX

		mov RCX, 0
		mov RAX, 0
		mov RBX, 0
		call binary_search

		mov RAX, [res]
		cmp RAX, [n]
		jg not_found

		mov RBX, 0
		mov RDI, fmt_out
		mov RSI, [res]
		mov RAX, 0
		call printf
		leave
		ret

	not_found:
		mov RDI, fmt_not_found
		call printf

	leave
	ret
