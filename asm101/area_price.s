	.file	"area_price.c"
	.globl	int_arr
	.data
	.align 16
	.type	int_arr, @object
	.size	int_arr, 20
int_arr:
	.long	1
	.long	2
	.long	3
	.long	4
	.long	5
	.globl	hello
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"hello \344\270\255\346\226\207 abc"
	.data
	.align 8
	.type	hello, @object
	.size	hello, 8
hello:
	.quad	.LC0
	.globl	ch
	.type	ch, @object
	.size	ch, 1
ch:
	.byte	97
	.globl	int_var
	.align 4
	.type	int_var, @object
	.size	int_var, 4
int_var:
	.long	1
	.globl	long_var
	.align 8
	.type	long_var, @object
	.size	long_var, 8
long_var:
	.quad	1
	.ident	"GCC: (GNU) 4.8.5 20150623 (Red Hat 4.8.5-36)"
	.section	.note.GNU-stack,"",@progbits
