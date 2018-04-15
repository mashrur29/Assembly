; sum of: 2 + 3 + 5 + 8 + 12 + . . . . + n

segment .data

fmt_out: db "Sum: %lld", 10,  0
fmt_debug: db "Here -> %lld %lld", 10, 0
fmt_in: db "%lld", 0
first_val: dq 2
common_diff: dq 1
n: dq 0
result: dq 0

segment .bss

array: resq 21
str1: resq 200
str_final: resq 200
mp: resq 200

segment .text

global main
extern printf
extern scanf

series_sum:
	push RBP
	mov RBP, RSP

	mov R8, [RBP + 24] ; current val
	mov R9, [RBP + 16] ; common difference

	cmp R8, [n]
	jg base_case

	add R8, R9
	push R8
	inc R9
	push R9

	call series_sum

	mov RAX, [result]
	add RAX, [RBP + 24]
	mov [result], RAX

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
	
	mov RAX, 0
	mov RBX, 0
	mov RCX, 0

	mov RAX, [first_val]
	push RAX
	mov RAX, [common_diff]
	push RAX

	call series_sum

	mov RDI, fmt_out
	mov RSI, [result]
	mov RAX, 0
	call printf

	leave
	ret

