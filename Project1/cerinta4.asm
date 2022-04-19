.data
	sir: .space 1000
	nrLinii: .space 100
	nrCol: .space 100
	dMat: .space 1600
	res: .space 100
	operand: .space 100
	matrix: .space 1600
	rot_matrix: .space 1600
	m: .space 10
	n: .space 10
	counter: .long 0
	aux: .space 4
	sign_changer: .long -1
	formatPrintf: .asciz "%d "
	formatPrintf_endl: .asciz "\n"
	formatScanf: .asciz "%300[^\n]"
	chSep: .asciz " "
	
	

.text 

.global main

main:

//citire sir initial
	pushl $sir
	pushl $formatScanf 
	call scanf
	popl %ebx
	popl %ebx
		
d_matrix:
	
	
	pushl $chSep
	pushl $sir
	call strtok
	popl %ebx
	popl %ebx
	
	pushl $chSep
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	movl %eax, res
	
	pushl res
	call atoi
	popl %ebx
	
	movl %eax, nrLinii
	
	pushl $chSep
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	movl %eax, res
	
	pushl res
	call atoi
	popl %ebx
	
	movl %eax, nrCol
	
	mull nrLinii
	movl %eax, dMat
	
	xorl %ecx , %ecx
	movl $matrix, %edi

//for_Vmatrix:
for:
	
	movl dMat, %eax
	cmp counter, %eax
	je et_op
	
	pushl $chSep
	pushl $0
	call strtok
	popl %ebx
	popl %ebx

	movl %eax , res
	pushl res
	call atoi
	popl %ebx


	movl counter, %ecx
	movl %eax,  (%edi, %ecx, 4)
	incl %ecx
	movl %ecx, counter

	
	//jmp for_Vmatrix
	jmp for
	
et_op:
	
	
	pushl $chSep
	pushl $0
	call strtok
	popl %ebx
	popl %ebx


	//sarim peste let
	
	pushl $chSep
	pushl $0
	call strtok
	popl %ebx
	popl %ebx



	movl %eax, res
	push res
	call atoi
	popl %ebx


	cmp $0, %eax
	je rotire 
	
	movl %eax, operand
	
	pushl $chSep
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	
	movl %eax, res 
	movl res, %esi
	xorl %ecx, %ecx 
	movb (%esi ,%ecx, 1), %al 

	movl $matrix, %edi
	movl dMat, %ebx
	movl $0, counter #???
	
	cmp $97, %al
	je et_add
	
	cmp $115, %al
	je et_sub
	
	cmp $109, %al 
	je et_mul
	
	cmp $100, %al
	je et_div
	
et_add:
	
	cmp %ecx, %ebx
	je et_afisare
	
	movl (%edi, %ecx, 4), %eax
	addl operand, %eax
	movl %eax, (%edi, %ecx, 4) 
	
	incl %ecx 
	jmp et_add

et_sub:
	
	cmp %ecx, %ebx
	je et_afisare
	
	movl (%edi, %ecx, 4), %eax
	subl operand, %eax
	movl %eax, (%edi, %ecx, 4) 
	
	incl %ecx 
	jmp et_sub
	
et_mul:
	
	cmp %ecx, %ebx
	je et_afisare
	
	movl (%edi, %ecx, 4), %eax
	mull operand
	movl %eax, (%edi, %ecx, 4) 
	
	xorl %edx, %edx
	incl %ecx 
	jmp et_mul

et_div:
	
	cmp %ecx, %ebx
	je et_afisare
	
	movl (%edi, %ecx, 4) ,%eax 
	
	cmp $0, %eax
	jg div_poz
	
	jmp div_neg
	
div_poz:
	
	movl operand, %eax
	cmp $0, %eax
	jg poz_poz
	jmp poz_neg

poz_poz:
	
	xorl %edx, %edx
	movl (%edi, %ecx, 4) ,%eax 
	divl operand
	movl %eax, (%edi, %ecx, 4)
	
	incl %ecx
	jmp et_div

poz_neg:
	
	xorl %edx, %edx
	movl operand, %eax
	mull sign_changer
	movl %eax, aux
	xorl %edx, %edx 
	movl (%edi, %ecx, 4) ,%eax 
	divl aux
	xorl %edx, %edx
	mull sign_changer
	movl %eax, (%edi, %ecx, 4)
	
	incl %ecx
	jmp et_div
	
div_neg:
	
	movl operand, %eax
	cmp $0, %eax
	jg neg_poz
	jmp neg_neg

neg_poz:
	
	xorl %edx, %edx
	movl (%edi, %ecx, 4) ,%eax 
	mull sign_changer
	xorl %edx, %edx
	divl operand
	xorl %edx ,%edx
	mull sign_changer
	movl %eax, (%edi, %ecx, 4)
	
	incl %ecx
	jmp et_div
	
neg_neg:
	
	xorl %edx, %edx
	movl operand, %eax
	mull sign_changer 
	movl %eax, aux 
	xorl %edx, %edx
	movl (%edi, %ecx, 4), %eax
	mull sign_changer
	xorl %edx, %edx
	divl aux
	movl %eax, (%edi, %ecx, 4)
	
	incl %ecx
	jmp et_div		
	
rotire:
	
	movl nrLinii, %eax
	subl $1, %eax
	movl %eax, m
	movl nrCol , %eax
	subl $1, %eax
	movl %eax, n
	movl $matrix, %edi
	movl $rot_matrix, %esi
	
	xorl %ecx, %ecx
	xorl %edx, %edx
m1:
	cmp nrLinii, %ecx
	je afisare_90
	movl $0, counter
	
m2:
	movl counter, %eax
	cmp nrCol, %eax
	je cont_m1	
	
	movl nrCol ,%eax
	mull %ecx
	addl counter , %eax 
	
	movl (%edi, %eax, 4), %ebx

	movl nrLinii, %eax
	mull counter
	addl nrLinii, %eax 
	subl $1, %eax
	subl %ecx, %eax
	
	movl %ebx, (%esi, %eax, 4)
	
	movl counter, %ebx
	incl %ebx
	movl %ebx, counter 
	
	jmp m2
			
cont_m1:
	incl %ecx
	jmp m1

afisare_90:
	
	xorl %ecx, %ecx
	
	pushl nrCol
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	
	pushl nrLinii
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	
	xorl %ecx, %ecx
	movl dMat, %ebx
	movl $rot_matrix, %edi

afis_arr90:
	
	
	movl $rot_matrix, %edi
	pushl %ecx
	cmp %ecx, %ebx
	je et_exit
	
	
	pushl (%edi, %ecx, 4)
	pushl $formatPrintf
	call printf
	popl %edx
	popl %edx

	popl %ecx
	incl %ecx
	jmp afis_arr90
		
et_afisare:
	
	pushl nrLinii
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	
	pushl nrCol
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	
	xorl %ecx, %ecx
	movl dMat, %ebx
	movl $matrix, %edi

afis_arr:
	
	
	movl $matrix, %edi
	pushl %ecx
	cmp %ecx, %ebx
	je et_exit
	
	
	pushl (%edi, %ecx, 4)
	pushl $formatPrintf
	call printf
	popl %edx
	popl %edx

	popl %ecx
	incl %ecx
	jmp afis_arr
	
	

et_exit:
	
	pushl $formatPrintf_endl
	call printf
	popl %ebx
	
	pushl $0
	call fflush 
	
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
