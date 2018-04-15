; all possible combination

segment .data

fmt_out: db "%lld ",  0
fmt_out2: db "The permutations are:", 10,  0
fmt_debug: db "Here -> %lld", 10, 0
fmt_in: db "%lld", 0
fmt_new_line: db "", 10, 0
first_val: dq 2
common_diff: dq 1
n: dq 0
result: dq 0
temp: dq 0

segment .bss

taken: resq 2000
str1: resq 2000

segment .text

global main
extern printf
extern scanf

back_track:
	push RBP
	mov RBP, RSP

	mov R8, [RBP + 16] ; current index

	cmp R8, [n]
	jg base_case

	mov RAX, 1
	mov [taken + R8*8], RAX
	inc R8
	push R8
	call back_track
	pop R8
	dec R8

	mov RAX, 0
	mov [taken + R8*8], RAX
	inc R8
	push R8
	call back_track

	leave
	ret

	base_case:
		mov RCX, 1

		loop_base:
			mov RAX, [taken + RCX*8]
			mov [temp], RCX
			cmp RAX, 0
			je else
			mov RDI, fmt_out
			mov RSI, [temp]
			mov RAX, 0
			call printf 
			else:
				mov RCX, [temp]
				inc RCX
				cmp RCX, [n]
			jle loop_base

		mov RDI, fmt_new_line
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

	mov RCX, 0

	clear_array:
		mov RAX, 0
		mov [taken + RCX*8], RAX
		inc RCX
		cmp RCX, [n]
		jle clear_array
	
	mov RAX, 0
	mov RBX, 0
	mov RCX, 0

	mov RAX, 1
	push RAX
	push RAX

	call back_track

	leave
	ret

