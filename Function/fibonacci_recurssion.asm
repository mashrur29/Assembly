segment .data
fmt_out: db "The Fib value is: %lld", 10,  0
fmt_debug: db "Here -> %lld", 10, 0
fmt: db "%s", 10, 0
fmt_in: db "%lld", 0
a: dq 0
b: dq 0
n: dq 0
o1: dq 0
o2: dq 0
curn: dq 0
temp: dq 0
prev: dq 0
res: dq 0
arg: dq 0

segment .text

global main
extern printf
extern scanf

fibonacci:
	push RBP
	mov RBP, RSP
	mov RBX, [RBP + 16] ; 2 values in stack, IP + BP
	
	cmp RBX, 1
	jz base_case1

	cmp RBX, 2
	jz base_case2

	mov RDX, [RBP + 16]
	dec RDX
	push RDX   
	call fibonacci
	pop RDX             

	push RAX           
	mov RDX, [RBP + 16]
	dec RDX
	dec RDX
	push RDX            
	call fibonacci  
	pop RDX             
	pop RDX            
	add RAX, RDX      
      
	pop RBP
	ret

	base_case1:
		mov RAX, 0
		pop RBP 
		ret
	base_case2:
		mov RAX, 1
		pop RBP
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

	mov RAX, 0
	mov RBX, 0
	call fibonacci
	mov [res], RAX

	mov RBX, 0
	mov RDI, fmt_out
	mov RSI, [res]
	mov RAX, 0
	call printf

	leave
	ret
