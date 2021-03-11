#	File: matrix.s
#	Name: Justin Yan 
#	Student Number: 301403282
#	Date: March 10 2021
#	Purpsoe: Assignment 5 Quesiton 3:
#			 To manipulate 2D arrays in assembly code
#			
#			 Contains given function:
#				- copy - copies the content of 1 matrix to another
#
#			 Contains other functions to produce a matrix flipped 90 degrees clockwise
#				- transpose - Flips the matrix over its diagonal with its row and column indices
#				- reverse - Reverse the columns of a matrix by swapping the columns

	.globl	copy
copy:
# A in rdi, C in rsi, N in edx
	xorl %eax, %eax			# set eax to 0
# since this function is a leaf function, no need to save caller-saved registers rcx and r8
	xorl %ecx, %ecx			# row number i is in ecx -> i = 0

# For each row
rowLoop:
	movl $0, %r8d			# column number j in r8d -> j = 0
	cmpl %edx, %ecx			# loop as long as i - N < 0
	jge doneWithRows

# For each cell of this row
colLoop:
	cmpl %edx, %r8d			# loop as long as j - N < 0
	jge doneWithCells

# Compute the address of current cell that is copied from A to C
# since this function is a leaf function, no need to save caller-saved registers r10 and r11
	movl %edx, %r10d        # r10d = N 
    imull %ecx, %r10d		# r10d = i*N
	addl %r8d, %r10d        # j + i*N
	imull $1, %r10d         # r10 = L * (j + i*N) -> L is char (1Byte)
	movq %r10, %r11			# r11 = L * (j + i*N) 
	addq %rdi, %r10			# r10 = A + L * (j + i*N)
	addq %rsi, %r11			# r11 = C + L * (j + i*N)

# Copy A[L * (j + i*N)] to C[L * (j + i*N)]
	movb (%r10), %r9b       # temp = A[L * (j + i*N)]
	movb %r9b, (%r11)       # C[L * (j + i*N)] = temp

	incl %r8d				# column number j++ (in r8d)
	jmp colLoop				# go to next cell

# Go to next row
doneWithCells:
	incl %ecx				# row number i++ (in ecx)
	jmp rowLoop				# Play it again, Sam!

doneWithRows:				# bye! bye!
	ret

#####################
	.globl	transpose
# C (array) in rdi, N (length of each row/column) in esi
# ecx = row number (i), r8d = column number (j)
# r10d = temp value for old, r11 = temp value for new
# r9b = temp value to hold r10, r12b = temp value to hold r11
transpose:
	xorl %eax, %eax			# set eax to 0
	xorl %ecx, %ecx			# row number i is in ecx -> i = 0

rowLoopTranspose:
	movl $0, %r8d			# reset temp column number back to 0
	cmpl %esi, %ecx			# check if done with row, if so it goes to return
	jge doneTranspose

columnLoopTranspose:
	cmpl %esi, %r8d			# check if done with column, if so jumps to doneWithColumnTranspose
	jge doneWithColumnTranspose

	cmpl %r8d, %ecx			# jumps to skipCells if i > j
	jg	skipCells		

	movl %esi, %r10d		# r10d = N 
	imull %ecx, %r10d		# r10d = i*N
	addl %r8d, %r10d		# j + i*N
	imull $1, %r10d			# r10d = L * (j + i*N) -> L is char (1Byte)

	movl %esi, %r11d		# r11d = N
	imull %r8d, %r11d		# r11d = j*N
	addl %ecx, %r11d		# i + j*N
	imull $1, %r11d			# r11d = L * (i + j*N) -> L is char (1Byte)

	addq %rdi, %r10			# r10 = C + L * (j + i*N)
	addq %rdi, %r11			# r11 = C + L * (i + j*N)

	movb (%r10), %r9b		# temp1 = C[L * (j + i*N)]
	movb (%r11), %r12b		# temp2 = C[L * (i + j*N)]
	movb %r12b, (%r10)		# C[L * (j + i*N)] = temp2
	movb %r9b, (%r11)		# C[L * (i + j*N)] = temp1

	incl %r8d				# increments j by 1 (goes to next cell)
	jmp columnLoopTranspose # jumps to back to start of columnLoopTranspose

skipCells:
	incl %r8d				# increments j by 1 (goes to next cell)
	jmp columnLoopTranspose # goes back to columnLoopTranspose

doneWithColumnTranspose:
	incl %ecx				# increments i by 1 (goes down 1 row)
	jmp rowLoopTranspose	# jumps back to rowLoopTranspose

doneTranspose:
	ret						# returns


#####################
	.globl	reverseColumns
# C (array) in rdi, N (length of each row/column) in esi
# ecx = current row number (i), r8d = current column number (j)
# r10d = temp value for old, r11 = temp value for new
# r9b = temp value to hold r10, r12b = temp value to hold r11
# r13b = total/2 (N/2), r14b = total - current column number (N-j)

reverseColumns:
	xorl %eax, %eax			# set eax to 0
	xorl %ecx, %ecx			# row number i is in ecx -> i = 0

	movl %esi, %r13d		# sets up temparary value which is equal to N/2
	shrl $1, %r13d

rowLoopReverse:
	movl $0, %r8d			# reset temp column number back to 0
	cmpl %esi, %ecx			# check if done with row, if so it goes to return
	jge doneReverse

columnLoopReverse:
	cmpl %r13d, %r8d		# check if done with column, if so jumps to doneWithColumnReverse
	jge doneWithColumnReverse

	movl %esi, %r10d		# r10d = N 
	imull %ecx, %r10d		# r10d = i*N
	addl %r8d, %r10d		# j + i*N
	imull $1, %r10d			# r10 = L * (j + i*N) -> L is char (1Byte)

	movl %esi, %r14d		# Makes a temperary variable thats (N-j)
	subl $1, %r14d			# Minus 1 since the end of array is N-1
	subl %r8d, %r14d

	movl %esi, %r11d		# r10d = N 
	imull %ecx, %r11d		# r10d = i*N
	addl %r14d, %r11d		# (N-j) + i*N
	imull $1, %r11d			# r10 = L * ((N-j) + i*N) -> L is char (1Byte)

	addq %rdi, %r10			# r10 = C + L * (j + i*N)
	addq %rdi, %r11			# r11 = C + L * ((N-j) + i*N)

	movb (%r10), %r9b		# temp = C[L * (j + i*N)]
	movb (%r11), %r12b
	movb %r12b, (%r10)		# C[L * (j + i*N)] = C[L * ((N-j) + i*N)]
	movb %r9b, (%r11)		# C[L * ((N-j) + i*N)] = temp

	incl %r8d				# increments j by 1 (goes to next cell)
	jmp columnLoopReverse	# jumps to back to start of columnLoopReverse

doneWithColumnReverse:
	incl %ecx				# increments i by 1 (goes to next row)
	jmp rowLoopReverse		# jumps back to rowLoopReverse

doneReverse:
	ret						# returns

