.data
	formatPrintf_char: .asciz "%c "
	formatPrintf_minus: .asciz "%c"
	formatPrintf_int  : .asciz "%d "
	formatPrintf_str : .asciz "%s "
	formatPrintf_afisare: .asciz "\n"
	formatScanf : .asciz "%s"
	sir_hexa: .space 1000
	let_op: .asciz "let"
	add_op: .asciz "add"
	sub_op: .asciz "sub"
	mul_op: .asciz "mul"
	div_op: .asciz "div"
	sum: .long 0 
	aux: .asciz "a"
	
.text

.global main

main:

citire_sir_hexa:
		
	pushl $sir_hexa
	pushl $formatScanf
	call scanf 
	popl %ebx
	popl %ebx
	
	xorl %ecx, %ecx
	movl $sir_hexa, %edi
	
et_for:
	movb (%edi, %ecx, 1), %al
	cmp $0, 	%al
	je et_exit
	
	cmp $65, %al
	je et_var
	
	cmp $67, %al 
	je et_op
	
	cmp $56, %al
	je et_int
	
	cmp $57, %al 
	je et_int
	
cont_for: 
	
	incl %ecx 
	jmp et_for

	
et_var:
	incl %ecx
	movb (%edi, %ecx, 1), %al
	
	cmp $54, %al
	je a_to_o
	cmp $55, %al 
	je p_to_z 
	
afisare_char: 
	
	pushl %ecx
	pushl aux
	push $formatPrintf_char
	call printf
	popl %ebx
	popl %ebx
	popl %ecx
	
	jmp cont_for
	

a_to_o:
	
	incl %ecx
	movb (%edi, %ecx, 1), %al
	
	cmp $49, %al
	je et_a
	
	cmp $50, %al
	je et_b
	
	cmp $51, %al
	je et_c
	
	cmp $52, %al
	je et_d
	
	cmp $53, %al
	je et_e
	
	cmp $54, %al
	je et_f
	
	cmp $55, %al
	je et_g
	
	cmp $56, %al
	je et_h
	
	cmp $57, %al
	je et_i
	
	cmp $65, %al
	je et_j
	
	cmp $66, %al
	je et_k
	
	cmp $67, %al
	je et_l
	
	cmp $68, %al
	je et_m
	
	cmp $69, %al
	je et_n
	
	cmp $70, %al
	je et_o
	
	

p_to_z:
	
	incl %ecx
	movb (%edi, %ecx, 1), %al
	
	cmp $48, %al
	je et_p
	
	cmp $49, %al
	je et_q
	
	cmp $50, %al
	je et_r
	
	cmp $51, %al
	je et_s
	
	cmp $52, %al
	je et_t
	
	cmp $53, %al
	je et_u
	
	cmp $54, %al
	je et_v
	
	cmp $55, %al
	je et_w
	
	cmp $56, %al
	je et_x
	
	cmp $57, %al
	je et_y
	
	cmp $65, %al
	je et_z
	
et_a:
	movl $97, aux
	jmp afisare_char
et_b:
	movl $98, aux
	jmp afisare_char
et_c:
	movl $99, aux
	jmp afisare_char
et_d:
	movl $100, aux
	jmp afisare_char
et_e:
	movl $101, aux
	jmp afisare_char
et_f:
	movl $102, aux
	jmp afisare_char
et_g:
	movl $103, aux
	jmp afisare_char
et_h:
	movl $104, aux
	jmp afisare_char
et_i:
	movl $105,  aux
	jmp afisare_char
et_j:
	movl $106, aux
	jmp afisare_char
et_k:
	movl $107, aux
	jmp afisare_char
et_l:
	movl $108, aux
	jmp afisare_char
et_m:
	movl $109, aux
	jmp afisare_char
et_n:
	movl $110, aux
	jmp afisare_char
et_o:
	movl $111,  aux
	jmp afisare_char
et_p:
	movl $112, aux
	jmp afisare_char
et_q:
	movl $113, aux
	jmp afisare_char
et_r:
	movl $114, aux
	jmp afisare_char
et_s:
	movl $115, aux
	jmp afisare_char
et_t:
	movl $116, aux
	jmp afisare_char
et_u:	
	movl $117, aux
	jmp afisare_char
et_v:
	movl $118,  aux
	jmp afisare_char
et_w:
	movl $119, aux
	jmp afisare_char
et_x:
	movl $120, aux
	jmp afisare_char
et_y:
	movl $121, aux
	jmp afisare_char
et_z:
	movl $122, aux
	jmp afisare_char
	
	
	
et_op:
	
	addl $2, %ecx
	movb (%edi, %ecx, 1), %al
	cmp $48, %al
	je et_let
	cmp $49, %al
	je et_add
	cmp $50, %al
	je et_sub
	cmp $51, %al
	je et_mul
	cmp $52, %al
	je et_div
	
	
et_let:

	push %ecx
	push $let_op
	push $formatPrintf_str
	call printf
	pop %ebx
	pop %ebx
	pop %ecx
	jmp cont_for
	
	
et_add:
	
	push %ecx
	push $add_op
	push $formatPrintf_str
	call printf
	pop %ebx
	pop %ebx
	pop %ecx
	jmp cont_for
	
	
et_sub:
	
	push %ecx
	push $sub_op
	push $formatPrintf_str
	call printf
	pop %ebx
	pop %ebx
	pop %ecx
	jmp cont_for
	
et_mul:
	
	push %ecx
	push $mul_op
	push $formatPrintf_str
	call printf
	pop %ebx
	pop %ebx
	pop %ecx
	jmp cont_for

et_div:
	
	push %ecx
	push $div_op
	push $formatPrintf_str
	call printf
	pop %ebx
	pop %ebx
	pop %ecx
	jmp cont_for

et_int:
	
	cmp $57 , %al
	je et_minus

cont_int_cif1:
	
	incl %ecx 
	movb (%edi, %ecx, 1), %al
	
	cmp $48, %al
	je cont_cif_2
	
	cmp $49, %al
	je et_16
	
	cmp $50, %al
	je et_32
	
	cmp $51, %al
	je et_48
	
	cmp $52, %al
	je et_64
	
	cmp $53, %al
	je et_80
	
	cmp $54, %al
	je et_96
	
	cmp $55, %al
	je et_112	
	
	cmp $56, %al
	je et_128
	
	cmp $57, %al
	je et_144
	
	cmp $65, %al
	je et_160
	
	cmp $66, %al
	je et_176
	
	cmp $67, %al
	je et_192
	
	cmp $68, %al
	je et_208
	
	cmp $69, %al
	je et_224	
	
	cmp $70, %al
	je et_240

cont_cif_2: 
	
	incl %ecx
	movb (%edi, %ecx, 1), %al
	
	cmp $48, %al
	je cont
	
	cmp $49, %al
	je et_1
	
	cmp $50, %al
	je et_2
	
	cmp $51, %al
	je et_3
	
	cmp $52, %al
	je et_4
	
	cmp $53, %al
	je et_5
	
	cmp $54, %al
	je et_6
	
	cmp $55, %al
	je et_7	
	
	cmp $56, %al
	je et_8
	
	cmp $57, %al
	je et_9
	
	cmp $65, %al
	je et_10
	
	cmp $66, %al
	je et_11
	
	cmp $67, %al
	je et_12
	
	cmp $68, %al
	je et_13
	
	cmp $69, %al
	je et_14	
	
	cmp $70, %al
	je et_15

et_1:
	addl $1, sum 
	jmp cont
et_2:
	addl $2, sum 
	jmp cont
et_3:
	addl $3, sum 
	jmp cont
et_4:
	addl $4, sum 
	jmp cont
et_5:
	addl $5, sum 
	jmp cont
et_6:
	addl $6, sum 
	jmp cont
et_7:
	addl $7, sum 
	jmp cont
et_8:
	addl $8, sum 
	jmp cont
et_9:
	addl $9, sum 
	jmp cont
et_10:	
	addl $10, sum 
	jmp cont
et_11:
	addl $11, sum 
	jmp cont
et_12:
	addl $12, sum 
	jmp cont
et_13:
	addl $13, sum 
	jmp cont
et_14:
	addl $14, sum 
	jmp cont
et_15:
	addl $15, sum 
	jmp cont



et_16:
	addl $16, sum 
	jmp cont_cif_2
et_32:
	addl $32, sum 
	jmp cont_cif_2
et_48:
	addl $48, sum 
	jmp cont_cif_2
et_64:
	addl $64, sum 
	jmp cont_cif_2
et_80:
	addl $80, sum 
	jmp cont_cif_2
et_96:
	addl $96, sum 
	jmp cont_cif_2
et_112:
	addl $112, sum 
	jmp cont_cif_2
et_128:
	addl $128, sum 
	jmp cont_cif_2
et_144:
	addl $144, sum 
	jmp cont_cif_2
et_160:
	addl $160, sum 
	jmp cont_cif_2
et_176:
	addl $176, sum 
	jmp cont_cif_2
et_192:
	addl $192, sum 
	jmp cont_cif_2
et_208:
	addl $208, sum 
	jmp cont_cif_2 
et_224:
	addl $224, sum 
	jmp cont_cif_2
et_240:
	addl $240, sum 
	jmp cont_cif_2



et_minus:
	push %ecx
	push $45
	push $formatPrintf_minus
	call printf
	pop %ebx
	pop %ebx
	pop %ecx
	jmp cont_int_cif1
	
cont: 
	
	pushl %ecx
	pushl sum
	push $formatPrintf_int
	call printf
	popl %ebx
	popl %ebx
	popl %ecx
	
	movl $0, sum
	incl %ecx 
	jmp et_for



et_exit: 	
	//terminatorul de sir
	
	pushl $formatPrintf_afisare
	call printf
	popl %ebx
	
	pushl $0
	call fflush
	
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
