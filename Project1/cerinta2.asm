.data
	text: .space 1000
	formatScanf: .asciz "%300[^\n]"
	formatPrintf : .asciz "%d\n"
	chSep: .asciz " "
	res: .space 10
	x: .long 1
	y: .long 1
	prod: .long 1
	cat: .long 1
	result: .space 100
	sir: .asciz "a" 
	
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
	
	push res
	call atoi
	pop %ebx
	
	push %eax 
	
et_for: 
	
	pushl $chSep
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	
	cmp $0, %eax
	je et_afisare

	movl %eax, res
	movl %eax, sir
	
	push res
	call atoi
	pop %ebx

et_verif2: 
	
	push %eax
	cmp $0, %eax
	je et_op
	jmp et_for

et_op:
	
	popl %ebx
	xorl %ecx, %ecx
	movl sir, %edi
	
	movb (%edi, %ecx, 1) , %al
	cmp $97, %al
	je et_add
	
	cmp $115, %al
	je et_sub
	
	cmp $109, %al
	je et_mul
	
	cmp $100, %al
	je et_div
	
et_add:
	
	popl x
	popl y
	movl x, %ebx
	addl y ,%ebx
	pushl %ebx
	jmp et_for 
		
et_sub:
	
	popl x
	popl y
	movl y, %ebx
	subl x, %ebx 
	pushl %ebx
	jmp et_for 

et_mul:
	
	popl x
	popl y 
	pushl %eax
	movl x, %eax
	mull y
	movl %eax, prod
	popl %eax
	pushl prod
	jmp et_for 
	
et_div:	
	
	xor %edx, %edx
	popl x
	popl y
	pushl %eax
	movl y, %eax
	divl x
	movl %eax, cat
	popl %eax
	pushl cat
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
