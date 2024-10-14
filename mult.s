##############################################################################
# File: mult.s
# Skeleton for ECE 154a project
##############################################################################

	.data
student:
	.asciz "Diego Mateos, Kevin Mazariegos Garcia" 	# Place your name in the quotations in place of Student
	.globl	student
nl:	.asciz "\n"
	.globl nl


op1:	.word 7				# change the multiplication operands
op2:	.word 19			# for testing.


	.text

	.globl main
main:					# main has to be a global label
	addi	sp, sp, -4		# Move the stack pointer
	sw 	ra, 0(sp)		# save the return address

	mv	t0, a0			# Store argc
	mv	t1, a1			# Store argv

# a7 = 8 read character
#  ecall
				
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
	jal	multiply		# go to multiply code

	jal	print_result		# print operands to the console




					# Usual stuff at the end of the main
	lw	ra, 0(sp)		# restore the return address
	addi	sp, sp, 4
	
	li      a7, 10
	ecall


multiply:
##############################################################################
# Your code goes here.
# Should have the same functionality as running 
#	mul	a2, a1, a0
# assuming a1 and a0 stores 8 bit unsigned numbers
##############################################################################

    mv      t2, a1          # load a1 to t2
    mv      t3, a0          # Load a0 to t3
    mv      a2, zero        # set a2 to 0

loop:
    andi    t1, t2, 1       # check if LSB = 1
    
    beqz    t1, skip_add    #if LSB = 0 dont add to product

    add     a2, a2, t3      # add multiplicant to product

skip_add:
    slli    t3, t3, 1       #shift left 
    srli    t2, t2, 1       # shift to right

    bnez    t2, loop        # continue loop if multiplier not equal to 0

    


##############################################################################
# Do not edit below this line
##############################################################################
	jr	ra


print_result:

# print string or integer located in a0 (code a7 = 4 for string, code a7 = 1 for integer) 
	mv	t0, a0
	li	a7, 4
	la	a0, nl
	ecall
	
# print integer
	mv	a0, t0
	li	a7, 1
	ecall
# print string
	li	a7, 4
	la	a0, nl
	ecall
	
# print integer
	li	a7, 1
	mv	a0, a1
	ecall
# print string	
	li	a7, 4
	la	a0, nl
	ecall
	
# print integer
	li	a7, 1
	mv	a0, a2
	ecall
# print string	
	li	a7, 4
	la	a0, nl
	ecall

	jr      ra

