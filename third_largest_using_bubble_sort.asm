; Write a program which reads 5 numbers into an array and prints the third largest
; number. If the user enters 7, 13, 2, 10, 6 then your program should print 7.

segment .data
a: dq 2
b: dq 0
ind: dq 0
cnt: dq 0
cnt2: dq 0
fmt: dq "%lld ",10,0
fmt_in: dq "%lld", 0
fmt_out: dq "The 3rd largest number is: %lld ", 10, 0

segment .bss
array resq 21

segment .text
global main
extern printf
extern scanf

main:
push RBP

mov RAX, 0
mov RCX, 0
mov RBX, 0

INPUT_ARRAY: 
	cmp RCX, 5
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
	mov RAX, 0
	mov RCX, 0
	mov RBX, 0	

OUTER_LOOP:
	cmp RCX, 5
	jz PRINT
	mov [cnt], RCX
	mov RAX, [array+RCX*8]
	inc RCX
	INNER_LOOP:
		cmp RCX, 5
		jz OUTER_LOOP
		mov RBX, [array+RCX*8]
		cmp RAX, RBX
		inc RCX		
		jl INNER_LOOP
		mov [cnt2], RCX
		mov [array+RCX*8], RAX
		mov RCX, [cnt]
		mov [array+RCX*8], RAX
		mov RCX, [cnt2]
		jmp INNER_LOOP
	mov RCX, [cnt]
	jmp OUTER_LOOP

PRINT:
	mov RAX, 0
	mov RBX, 0
	mov RCX, 2
	mov RAX, [array+RCX*8]
	mov RDI, fmt_out
	mov RSI, RAX
	call printf	

END:
	mov RAX, 0
	pop RBP
ret
