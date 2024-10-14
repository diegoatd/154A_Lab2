##############################################################################
# File: div.s
# Skeleton for ECE 154a project
##############################################################################

	.data
student:
	.asciz "Student" 	# Place your name in the quotations in place of Student
	.globl	student
nl:	.asciz "\n"
	.globl nl


op1:	.word 3			# divdend for testing
op2:	.word 276		# divisor for testing


	.text

	.globl main
main:					# main has to be a global label
	addi	sp, sp, -4		# Move the stack pointer
	sw 	ra, 0(sp)		# save the return address

	mv	t0, a0			# Store argc
	mv	t1, a1			# Store argv
				
	li	a7, 4			# print_str (system call 4)
	la	a0, student		# takes the address of string as an argument 
	ecall	

	slti	t2, t0, 2		# check number of arguments
	bne     t2, zero, operands
	j	ready

operands:
	la	t0, op1
	lw	a0, 0(t0)
	la	t0, op2
	lw	a1, 0(t0)
		

ready:
	jal	divide			# go to divide code

	jal	print_result		# print operands to the console

					# Usual stuff at the end of the main
	lw	ra, 0(sp)		# restore the return address
	addi	sp, sp, 4

	li      a7, 10
	ecall


divide:
##############################################################################
# Your code goes here.
# Should have the same functionality as running
#	divu	a2, a1, a0
# 	remu    a3, a1, a0 
# assuming a1 is unsigned divident, and a0 is unsigned divisor
##############################################################################
    mv      t3, a1        # a1 is the divided, loading into t3
    mv      t4, a0        # a0 is the divison, laoding into t2
    li      a2, 0         # initalizing quotient, a2, to 0
    mv      a3, t3        # a3 is the remainded, initalized to t3

div_loop:
    blt     t4, a3, end_div  # if divisor > remainder then exit
    sub     a3, a3, t4       # divison = remainder - divison
    addi    a2, a2, 1        # 
    j       div_loop         # loop

end_div:
    jr      ra               # return to the caller


##############################################################################
# Do not edit below this line
##############################################################################
	jr	ra


# Prints a0, a1, a2, a3
print_result:
	mv	t0, a0
	li	a7, 4
	la	a0, nl
	ecall

	mv	a0, t0
	li	a7, 1
	ecall
	li	a7, 4
	la	a0, nl
	ecall

	li	a7, 1
	mv	a0, a1
	ecall
	li	a7, 4
	la	a0, nl
	ecall

	li	a7, 1
	mv	a0, a2
	ecall
	li	a7, 4
	la	a0, nl
	ecall

	li	a7, 1
	mv	a0, a3
	ecall
	li	a7, 4
	la	a0, nl
	ecall

	jr ra

