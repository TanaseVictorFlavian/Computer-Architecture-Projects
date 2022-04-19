.data
	text: .space 1000
	formatScanf: .asciz "%500[^\n]"
	formatPrintf : .asciz "%d\n"
	sir_val: .space 200 
	chSep: .asciz " "
	res: .space 10
	var1: .long 1
	var2: .long 1
	result: .space 100
	sir: .asciz "a" 
	prod: .long 1
	cat: .long 1
	aux: .long 1
	counter: .long 0
	
.text
	
.global main

main:

//citire_sir:
	
	pushl $text
	pushl $formatScanf
	call scanf 
	popl %ebx
	popl %ebx 
	
first_word:
	
	pushl $chSep 
	pushl $text
	call strtok
	popl %ebx
	popl %ebx

	movl %eax, res 

	pushl res
	call atoi 
	popl %ebx
	
	cmp $0, %eax
	je var_1 
	
	pushl %eax
	jmp et_for 

var_1:
	
	xorl %ecx, %ecx
	movl res, %edi
	xorl %eax, %eax
	
	movb (%edi, %ecx, 1), %al
	movl %eax, %ebx
	subl $97, %ebx
	movl %ebx, counter
	
		
//5 2 4 add add 4 4 add 3 div z 4 let q 1 let 3 q q div w 2 let q 1 add c 1 let div sub add sub	
et_for:
	popl %ebx
	pushl %ebx
	
	pushl $chSep
	pushl $0
	call strtok
	popl %ebx
	popl %ebx

	popl %ebx	#test
	pushl %ebx
	
	cmp $0, %eax
	je et_afisare
	
	movl %eax, res 
	
	pushl res
	call atoi 
	popl %ebx

et_test:	
	cmp $0, %eax
	je var_op
	
	pushl %eax
	jmp et_for
	
var_op:
	
	xorl %eax, %eax
	push res
	call strlen
	pop %ebx
	
	cmp $3, %eax
	je op
	jmp var
	
op:
	xorl %ecx, %ecx
	movl res, %edi 
	
	movb (%edi, %ecx, 1), %al
	cmp $97, %al
	je et_add
	
	cmp $115, %al
	je et_sub
	
	cmp $109, %al
	je et_mul
	
	cmp $100, %al
	je et_div
	
	cmp $108, %al
	je et_let
	
et_let:
	
	xorl %edi, %edi
	movl counter, %ecx
	movl $sir_val , %edi
	popl (%edi ,%ecx, 4) 
	jmp et_for
	
	
	
et_add:
	
	popl var1
	popl var2
	movl var1, %ebx
	addl var2 ,%ebx
	pushl %ebx
	jmp et_for 
		
et_sub:
	
	popl var1
	popl var2
	movl var2, %ebx
	subl var1,  %ebx 
	pushl %ebx
	jmp et_for 

et_mul:
	
	popl var1
	popl var2
	pushl %eax
	movl var1, %eax
	mull var2
	movl %eax, prod
	popl %eax
	pushl prod
	jmp et_for 
	
et_div:	
	
	xor %edx, %edx
	popl var1
	popl var2
	pushl %eax
	movl var2, %eax
	divl var1
	movl %eax, cat
	popl %eax
	pushl cat
	jmp et_for 
	
var:
	xorl %ecx, %ecx
	movl res, %edi
	xorl %eax, %eax 
	
	movb (%edi, %ecx, 1), %al
	movl %eax , %ebx
	subl $97, %ebx
	movl %ebx, %ecx
	movl $sir_val , %edi
	movl (%edi, %ecx, 4), %ebx
	cmp $0, %ebx
	je save_pos
	
	pushl %ebx
	jmp et_for

save_pos:
	
	movl %ecx, counter
	jmp et_for
	
	
et_afisare:
	
	popl result
	pushl result
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

et_exit:

	pushl $0 
	call fflush 
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
