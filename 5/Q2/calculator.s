#	File: calculator.s
#	Name: Justin Yan
#	Student Number: 301403282
#	Date: March 10 2021
#	Purpsoe: Assignment 5 Quesiton 2:
#			 To perform some algorithmic and logical calculations
#			
#			 Contains the same functions from A4 Q3:
#				- lessThan (Check if Less than) function
#				- plus (addition) function
#				- minus (subtraction) function 
#
#			 However, changed mul function where it uses recusion
#				- mul (multiply) function using recusion

#x = %edi ; y = %esi ; return = %eax

	.globl	lessThan # Make sure you change the name of this function - see XX function below
	.globl	plus
	.globl	minus
	.globl	mul

# x in edi, y in esi

lessThan: # Checks if x < y or not, if x < y then return 1, else return 0
	xorl	%eax, %eax	# Resets result to 0
	cmpl	%esi, %edi	# Compares x and y (x-y)
	setl	%al         # See Section 3.6.2 of our textbook for a description of the set* instructions
	ret

plus:  # performs integer addition
# Requirement:
# - you cannot use add* instruction
	xorl	%eax, %eax	# Resets result to 0
	movl	%edi, %eax	# Add x to return
	movl	%esi, %edx	# Add y to a temporary value
	negl	%edx		# Flips sign of temporary value (y)
	subl	%edx, %eax	# Subtracts x (current return value) to negative y (temp value) so its x + y
	ret					# Returns


minus: # performs integer subtraction
# Requirement:
# - you cannot use sub* instruction
	xorl	%eax, %eax	# Resets result to 0
	movl	%esi, %eax	# Add y to return
	negl	%eax		# Flips return value to negative
	addl	%edi, %eax	# Adds x to negative y (current return value) so its x - y
	ret					# Returns 


mul: # performs integer multiplication - when both operands are non-negative!
# x in edi, y in esi
# Requirements:
# -cannot use imul* instruction
# -you must use recursion (no loop) and the stack

# algorithm I used:
#	int mulRecurs(int x, int y){
#		if (y == 0)						// test if y = 0, 
#			return;						// if so, then we added enough x's
#		return x + mulRecurs(x,y-1);	// recursivly calls the function again, but with y-1 instead
#	}

mulRecurs:
	xorl	%eax, %eax		# zeros out eax (result)
	testl	%esi, %esi		# test if y == 0
	je done					# if so, jumps to return;
	pushq	%rdi			# adds x to the stack
	subl	$1, %esi		# decrements y
	call mulRecurs			# calls the function again with new y
	popq	%rdi			# pops x out
	addl	%edi, %eax		# add x to result

done:
	ret						# returns


