.data
	 input : .space 400
	 m : .long 4 
	 n : .space 4
	 arr: .space 400
	 arr_perm: .space 400
	 l_vector :.space 4
	 k : .long 0
	 solutie : .long 0 
	 error_msg : .asciz "-1"
	 formatPrintf : .asciz "%d "
	 formatPrintf_exit : .asciz "\n"
	 formatPrintf_nosol : .asciz "%s"
	 formatScanf : .asciz "%300[^\n]"
	 chSep: .asciz " "
	 
	 

.text

.global main 

//AFISARE SOL
	
PrintSol:

	//%esp (<adr de int>)(*arr_perm)(n)
	pushl %ebp
	movl %esp, %ebp
	//%esp : %ebp (%ebp v)(<adr de int>)(*arr_perm)(n)
	
	pushl %edi
	//%esp : (%edi v) %ebp : ....
	pushl %ebx
	//%esp : (%ebx v) (%edi v) %ebp : ....
	 
	movl 8(%ebp), %edi
	movl 12(%ebp), %ebx
	
	xorl %ecx ,%ecx
		
for_afisare:
	
	cmp %ecx, %ebx
	je proc_exit
	
	pushl %ecx
	
	pushl (%edi ,%ecx, 4)
	pushl $formatPrintf
	call printf
	popl %edx
	popl %edx
	
	popl %ecx
	incl %ecx
	jmp for_afisare


proc_exit:
	
	movl $1, solutie
	popl %ebx
	popl %edi
	popl %ebp
	
	ret
	
//VALIDARE 
is_valid:
	
	//%esp : (<adr de int>)(*arr)(*arr_perm)(k)
	pushl %ebp
	movl %esp, %ebp
	//%esp : %ebp : (ebp v)(<adr de int>)(*arr)(*arr_perm)(k)
	
	pushl %edi
	pushl %esi
	pushl %ebx
	pushl %ecx
	pushl %edx
	movl 8(%ebp), %edi
	movl 12(%ebp), %esi
	//%edi = arr
	//%esi = arr_perm
	
	
	//%esp : (%ebx v)(%esi v)(%edi v) %ebp : ....
	
	movl 16(%ebp), %edx
	
	//%edx = k
	//%eax = m
	

verif1:
	//%ecx = %edx = k - m 
	//%eax = k
	subl m, %edx
	movl %edx, %ecx 
	movl 16(%ebp), %eax
	cmp $0, %edx
	jl index_0
	jmp for_verif1

index_0: 
	movl $0, %ecx
	movl 16(%ebp), %eax
	
	
for_verif1:	
	// for (%ecx ; %ecx < k ; ecx ++)
	// if(arr_perm[i] == arr[k]) return 0
	cmp %ecx, %eax
	je verif2 
	
	movl (%esi, %ecx, 4), %ebx
	movl (%esi, %eax, 4), %edx
	
	cmp %ebx, %edx 
	je ret_0
	
	incl %ecx
	jmp for_verif1
	
verif2:
	
	movl 16(%ebp), %eax
	//arr[k] != arr_perm[k] 
	movl (%esi, %eax, 4), %ebx
	movl (%edi, %eax, 4), %edx
	
	cmp %ebx, %edx
	je verif3

	xorl %ecx, %ecx
	//arr[k] != 0
	cmp %ecx, %edx
	jne ret_0
	
	
	
verif3:
	//%ebx = frecventa (verificam aparitia de 3 ori in sir)
	movl $1, %ebx
	xorl %ecx, %ecx
	//for (%ecx = 0 ; %ecx < k ; %ecx ++)
for_verif3:	
	
	cmp %ecx, %eax
	je check_freq
	
	//if(arr_perm[i] == arr_perm[k])
	//freq ++
	pushl %ecx
	movl (%esi, %eax, 4), %edx
	movl (%esi, %ecx, 4), %ecx
	
	cmp %edx, %ecx
	je incl_freq

cont_for_verif3:

	popl %ecx
	incl %ecx
	jmp for_verif3

incl_freq:

	incl %ebx
	jmp cont_for_verif3
	
check_freq:
	
	movl $3, %ecx
	cmp %ecx, %ebx
	jg ret_0

ret_1:
	
	popl %edx
	popl %ecx
	popl %ebx
	popl %esi
	popl %edi
	popl %ebp
	movl $1, %eax
	ret
		
ret_0:
	popl %edx
	popl %ecx
	popl %ebx
	popl %esi
	popl %edi
	popl %ebp
	movl $0, %eax
	ret
	
	
//BACTRACKING
backtrack:
	
	//%esp (<adr de int>)(*arr_perm)(k)
	pushl %ebp
	movl %esp, %ebp
	//%esp : %ebp : (%ebp v)(<adr de int>)(*arr_perm)(k)
	
	pushl %ebx
	pushl %edi
	pushl %edx
	pushl %esi
	//%esp : (%edx v)(%edi v), (%ebx v) %ebp : ....
	
	movl 8(%ebp), %edi
	movl 12(%ebp), %ebx
	movl n, %edx
	
	//%edi = *arr_perm
	//%ebx = k
	//%edx = n
	 
	movl $1, %ecx
	
	
for_backtrack:	

	//for (%ecx = 1 ; %ecx <=n ; ++%ecx)
	cmp n, %ecx
	jg exit_backtrack
	
	movl %ecx, (%edi, %ebx, 4)
	
	//is_valid(*arr, *arr_perm, k)
	pushl %ebx
	pushl %edi
	pushl $arr
	call is_valid
	popl %esi
	popl %esi
	popl %esi
	
	
	cmp $0, %eax
	je cont_for_backtrack
	
	cmp $1, solutie
	je cont_for_backtrack
	
	movl $3, %eax
	mull n
	subl $1, %eax
	
	cmp %eax, %ebx
	je afis_sol
	jmp apel_rec

apel_rec:
	
	incl %ebx
	movl %ebx, k
	
	pushl %ecx
	pushl %ebx
	pushl %edi
	call backtrack
	popl %esi
	popl %esi
	popl %ecx

eticheta:
	
	subl $1, %ebx
	jmp cont_for_backtrack

cont_for_backtrack:

	incl %ecx
	jmp for_backtrack

afis_sol:
	
	movl $3, %eax
	mull n
	pushl %eax
	pushl $arr_perm
	call PrintSol
	popl %esi 
	popl %esi

exit_backtrack:
	

	popl %esi
	popl %edx
	popl %edi
	popl %ebx	
	popl %ebp
	
	ret
	
	
main :
	//citire sir initial
	
	pushl $input
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
assign_n_m:
	
//n assignment

	pushl $chSep
	pushl $input
	call strtok 
	popl %ebx
	popl %ebx


	pushl %eax
	call atoi
	popl %ebx
	movl %eax, n 

//m assignment

	pushl $chSep
	pushl $0
	call strtok 
	popl %ebx
	popl %ebx	
	
	pushl %eax
	call atoi
	popl %ebx
	movl %eax, m
	
// l_vector assignement

	movl $3, %eax
	mull n
	movl %eax, l_vector
	
	xorl %ecx, %ecx
	movl $arr, %edi
	
citire_vector:

	cmp %ecx, l_vector
	je apel_back
	
	pushl %ecx
	pushl $chSep
	pushl $0
	call strtok 
	popl %ebx
	popl %ebx	
	
	pushl %eax
	call atoi
	popl %ebx
	popl %ecx
	movl %eax, (%edi, %ecx, 4)
	
	incl %ecx
	jmp citire_vector

apel_back:

	pushl k
	pushl $arr_perm
	call backtrack
	popl %ebx
	popl %ebx	
		
failure:
	
	movl solutie, %ebx
	cmp $0, %ebx
	je afis_failure
	jmp et_exit

afis_failure:
	
	pushl $error_msg
	pushl $formatPrintf_nosol
	call printf
	popl %ebx
	popl %ebx


et_exit:
	
	pushl $formatPrintf_exit
	call printf
	popl %ebx
	
	
	movl $1, %eax
	xorl %ebx ,%ebx
	int $0x80
	
