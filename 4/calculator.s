#	File: calculator.s
#	Name: Justin Yan
#	Date: Feb 22 2021
#	Purpsoe: Assignment 4 Quesiton 3:
#			 To perform some algorithmic and logical calculations
#				- lessThan (Check if Less than) function
#				- plus (addition) function
#				- minus (subtraction) function
#				- mul (multiply) function

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
# You can assume that both operands are non-negative.
# Requirements:
# - you cannot use imul* instruction 
#   (or any kind of instruction that multiplies such as mul)
# - you must use a loop
# algorithm I used:
#	int counter;			// Makes a counter
#	while (counter < x){	// Check if counter is less than x
#		result += y;		// If so, add y into result
#		counter++;			// Increment Counter by 1
#	}
#	return return;			// Returns "return" variable


	movl	$0, %edx	# Create Counter = 0
	xorl	%eax, %eax	# Resets result to 0

loop:
	cmpl	%edi, %edx	# Checks if counter is less than x
	jge	endloop			# If greater or equal to x, jumps out of loop and returns
	addl	%esi, %eax	# Adds y to return
	addl	$1, %edx	# Increments counter by 1
	jmp loop			# Jumps back to start of loop

endloop: 
	ret					# Returns


# algorithm:
#	int counter;
#	while (counter < x){
#		result += y;
#		counter++;
#	}
#	return return;
