#
# @LANG: asm
# @GENERATED: true
#

	.section	.data
	.comm	target,8,8
	.text
	.section	.data
	.comm	last,8,8
	.text

%%{
	machine next2;

	unused := 'unused';

	one := 'one' @{
		.section	.rodata
1:
	.string		"one\n"
	.text
	movq	$1b, %rax
	pushq	%rax
	movq	$.L_fmt_str, %rdi
	popq	%rsi
	movq	$0, %rax
	call	printf
	movq	$fentry(main), %rax
	pushq	%rax
	popq	%rax
	movq	%rax, target (%rip)
	movq	target(%rip), %rax
	pushq	%rax
movq	$0, %rax
popq	%rcx
fnext	* %rcx;

};

	two := 'two' @{
		.section	.rodata
2:
	.string		"two\n"
	.text
	movq	$2b, %rax
	pushq	%rax
	movq	$.L_fmt_str, %rdi
	popq	%rsi
	movq	$0, %rax
	call	printf
	movq	$fentry(main), %rax
	pushq	%rax
	popq	%rax
	movq	%rax, target (%rip)
	movq	target(%rip), %rax
	pushq	%rax
movq	$0, %rax
popq	%rcx
fnext	* %rcx;

};

	three := 'three' @{
		.section	.rodata
3:
	.string		"three\n"
	.text
	movq	$3b, %rax
	pushq	%rax
	movq	$.L_fmt_str, %rdi
	popq	%rsi
	movq	$0, %rax
	call	printf
	movq	$fentry(main), %rax
	pushq	%rax
	popq	%rax
	movq	%rax, target (%rip)
	movq	target(%rip), %rax
	pushq	%rax
movq	$0, %rax
popq	%rcx
fnext	* %rcx;

};

	main :=  (
		'1' @{
		movq	$fentry(one), %rax
	pushq	%rax
	popq	%rax
	movq	%rax, target (%rip)
	movq	target(%rip), %rax
	pushq	%rax
movq	$0, %rax
popq	%rcx
fnext	* %rcx;
	movq	$1, %rax
	pushq	%rax
	popq	%rax
	movq	%rax, last (%rip)

} |

		'2' @{
		movq	$fentry(two), %rax
	pushq	%rax
	popq	%rax
	movq	%rax, target (%rip)
	movq	target(%rip), %rax
	pushq	%rax
movq	$0, %rax
popq	%rcx
fnext	* %rcx;
	movq	$2, %rax
	pushq	%rax
	popq	%rax
	movq	%rax, last (%rip)

} |

		# This one is conditional based on the last.
		'3' @{
		movq	last (%rip), %rax
	pushq	%rax
	movq	$2 , %rax
	pushq	%rax
	popq	%rcx
	popq	%rax
	cmp		%rcx, %rax
	sete	%al
	movsbq	%al, %rax
	pushq	%rax
	popq	%rax
	test	%rax, %rax
	jz		4f
	movq	$fentry(three), %rax
	pushq	%rax
	popq	%rax
	movq	%rax, target (%rip)
	movq	target(%rip), %rax
	pushq	%rax
movq	$0, %rax
popq	%rcx
fnext	* %rcx;
4:
	movq	$3, %rax
	pushq	%rax
	popq	%rax
	movq	%rax, last (%rip)

} 'x' |

		'\n'
	)*;
}%%



	.text
	.comm		buf, 1024, 32
	.comm		bpos, 8, 8
	.comm		stack_data, 1024, 32
	.section	.rodata

.L_str_accept:
	.string "ACCEPT"
.L_str_fail:
	.string "FAIL"
.L_fmt_int:
	.string "%ld"
.L_fmt_str:
	.string "%s"

	%% write data;

	.text
exec:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$96, %rsp

	movq	$stack_data, -56(%rbp)

	pushq	%r12
	pushq	%r13
	movq	%rdi, %r12

	# Get the length.
	movq	%r12, %rdi
	call	strlen
	movq	%r12, %r13
	movslq	%eax, %rax
	addq	%rax, %r13

	movq	$0,	bpos(%rip)

	%% write init;
	%% write exec;

	# current state is in r11.
	movq	next2_first_final(%rip), %rax
	cmpq	%rax, %r11
	jl		.L_exec_fail
	movq	$.L_str_accept, %rdi
	call	puts
	jmp		.L_exec_done
.L_exec_fail:
	movq	$.L_str_fail, %rdi
	call	puts
.L_exec_done:
	popq	%r13
	popq	%r12
	leave
	ret
	.section	.rodata
.L_debug_msg:
	.string	"debug %d\n"
.L_inp_0:
	.string	"1one3x2two3three\n"

	.align 8
inp:
	.quad	.L_inp_0

	.align 8
inplen:
	.quad 1

	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r12
	movq	$0, %r12
.L_again:
	movq	inplen(%rip), %rax
	cmpq	%r12, %rax
	je		.L_done
	movq	inp(,%r12,8), %rdi
	call	exec
	incq	%r12
	jmp		.L_again
.L_done:
	popq	%r12
	mov		$0, %rax
	leave
	ret
debug:
	movl	%edi, %esi
	movq	$0, %rax
	movq	$.L_debug_msg, %rdi
	call	printf
	ret
	
