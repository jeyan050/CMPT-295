# add a header comment block

	.globl	XX # Make sure you change the name of this function - see XX function below
	.globl	plus
	.globl	minus
	.globl	mul

# x in edi, y in esi

XX: # Change the name of this function to something more descriptive and add a description
	xorl	%eax, %eax
	cmpl	%esi, %edi
	setl	%al         # See Section 3.6.2 of our textbook for a description of the set* instructions
	ret

plus:  # performs integer addition
# Requirement:
# - you cannot use add* instruction


minus: # performs integer subtraction
# Requirement:
# - you cannot use sub* instruction


mul: # performs integer multiplication - when both operands are non-negative!
# You can assume that both operands are non-negative.
# Requirements:
# - you cannot use imul* instruction 
#   (or any kind of instruction that multiplies such as mul)
# - you must use a loop

# algorithm:
#
#
#
#