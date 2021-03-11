	.file	"main.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%4d %4d %4d %4d"
	.text
	.p2align 4
	.globl	printMatrixByRow
	.type	printMatrixByRow, @function
printMatrixByRow:
.LFB24:
	.cfi_startproc
	endbr64
	testl	%esi, %esi
	jle	.L6
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	leaq	.LC0(%rip), %r14
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movslq	%esi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movl	%esi, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	xorl	%ebp, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%rdi, %rbx
	.p2align 4,,10
	.p2align 3
.L3:
	movsbl	1(%rbx), %ecx
	movsbl	(%rbx), %edx
	movq	%r14, %rsi
	movl	$1, %edi
	movsbl	3(%rbx), %r9d
	movsbl	2(%rbx), %r8d
	xorl	%eax, %eax
	addl	$1, %ebp
	addq	%r13, %rbx
	call	__printf_chk@PLT
	movl	$10, %edi
	call	putchar@PLT
	cmpl	%ebp, %r12d
	jne	.L3
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 40
	movl	$10, %edi
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_restore 12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_restore 13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_restore 14
	.cfi_def_cfa_offset 8
	jmp	putchar@PLT
	.p2align 4,,10
	.p2align 3
.L6:
	movl	$10, %edi
	jmp	putchar@PLT
	.cfi_endproc
.LFE24:
	.size	printMatrixByRow, .-printMatrixByRow
	.section	.rodata.str1.1
.LC1:
	.string	"Copy: "
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC2:
	.string	"Rotating the matrix by 90 degrees clockwise: "
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB23:
	.cfi_startproc
	endbr64
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	leaq	.LC1(%rip), %rdi
	call	puts@PLT
	movl	$4, %edx
	leaq	C(%rip), %rsi
	leaq	A(%rip), %rdi
	call	copy@PLT
	movl	$4, %esi
	leaq	A(%rip), %rdi
	call	printMatrixByRow
	movl	$4, %esi
	leaq	C(%rip), %rdi
	call	printMatrixByRow
	leaq	.LC2(%rip), %rdi
	call	puts@PLT
	movl	$4, %esi
	leaq	C(%rip), %rdi
	xorl	%eax, %eax
	call	transpose@PLT
	movl	$4, %esi
	leaq	C(%rip), %rdi
	call	printMatrixByRow
	movl	$4, %esi
	leaq	C(%rip), %rdi
	xorl	%eax, %eax
	call	reverseColumns@PLT
	movl	$4, %esi
	leaq	C(%rip), %rdi
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	jmp	printMatrixByRow
	.cfi_endproc
.LFE23:
	.size	main, .-main
	.comm	C,16,16
	.globl	A
	.data
	.align 16
	.type	A, @object
	.size	A, 16
A:
	.ascii	"\001\376\003\374"
	.ascii	"\373\006\371\b"
	.ascii	"\377\002\375\004"
	.ascii	"\005\372\007\370"
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
