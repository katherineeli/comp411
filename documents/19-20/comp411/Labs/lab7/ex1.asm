
.data
  AA:     .space 400  		# int AA[100]
  BB:     .space 400  		# int BB[100]
  CC:     .space 400  		# int CC[100]
  m:      .space 4   		# m is an int whose value is at most 10
                     		# actual size of the above matrices is mxm
 newline: .asciiz "\n"
 space:   .asciiz " "
 
.text

main:

#------- INSERT YOUR CODE HERE for main -------
 li $v0, 5 	# scanf("%d", &m)
 syscall
 move $t0, $v0	# m = t0

# read matrix AA
 li $t1, 0	# x = 0
 #li $s4, 0	# y = 0
 for1A:
	#blt $s3, $t0, exitForA	# for(x=0; x<m; x++)
	beq $t1, $t0, exitForA		# for(x=0; x<m; x++)
	li $t2, 0			# y = 0
 for2A:
	#blt $s4, $t0, for1A	
	beq $t2, $t0, end2A	# for(y=0; y<m; y++)
	li $v0, 5		# scanf(%d) 
	syscall
	#move $t1, $v0		# scan value in $t1
	mul $t4, $t1, $t0	# x*m
	add $t5, $t4, $t2	# x*m+y
	addi $t6, $0, 4
	mul $t7, $t6, $t5
	sw $v0, AA($t7)		# store in AA[x*m+y]
	addi $t2, $t2, 1	# y++
	j for2A
 end2A:
 	addi $t1, $t1, 1	# x++
 	j for1A
 exitForA:
 	

# read matrix BB
 li $t1, 0	# x = 0
 #li $s4, 0	# y = 0
 for1B:
	#blt $s3, $t0, exitForB 
	beq $t1, $t0, exitForB # for(x=0; x<m; x++)
	li $t2, 0		# y = 0
 for2B:
	#blt $s4, $t0, for1B	
	beq $t2, $t0, endB2 	# for(y=0; y<m; y++)
	li $v0, 5		# scanf(%d) 
	syscall
	#move $t1, $v0		# scan value in $t1
	mul $t4, $t1, $t0	# x*m
	add $t5, $t4, $t2	# x*m+y
	addi $t6, $0, 4
	mul $t7, $t6, $t5
	sw $v0, BB($t7)		# store in BB[x*m+y]
	addi $t2, $t2, 1	# y++
	j for2B
 endB2:
 	addi $t1, $t1, 1	# x++
 	j for1B
 exitForB:
 	

# matrix product CC 
 li $t1, 0	# i = 0
 #li $t2, 0	# j = 0
 #li $t3, 0	# k = 0
 for1C:
	#blt $t1, $t0, exitForC 
	beq $t1, $t0, exitForC # for(i=0; i<m; i++)
	li $t2, 0		# j = 0
 for2C:
	#blt $t2, $t0, for1C	
	beq $t2, $t0, endC2 	# for(j=0; j<m; j++)
	li $t3, 0		# k = 0
 for3C:
	#blt $t3, $t0, for2C	
	beq $t3, $t0, endC3	# for(k=0; k<m; k++)
	
	mul $t4, $t1, $t0	# t4 = i*m
	add $t5, $t4, $t2	# t5 = i*m+j (index CC)
	sll $t5, $t5, 2
	
	add $t6, $t4, $t3	# t6 = i*m+k (index AA)
	sll $t6, $t6, 2
	
	mul $t7, $t3, $t0	# t4 = k*m
	add $t7, $t7, $t2	# t7 = k*m+j (index BB)
	sll $t7, $t7, 2
	
	lw $a1, AA($t6)		# load AA val
	lw $a2, BB($t7)		# load BB val
	lw $a3, CC($t5)		# load CC val
	
	mul $t8, $a1, $a2	# t8 = multiply values of AA and BB 
	add $t8, $t8, $a3	# CC += AA * BB
	sw $t8, CC($t5)
	
	addi $t3, $t3, 1	# k++
	j for3C
 endC3:
 	addi $t2, $t2, 1	# j++
 	j for2C
 endC2:
 	addi $t1, $t1, 1	# i++
 	j for1C
 exitForC:
 	

# print result
 li $t2, 0	# j = 0
 #li $t3, 0	# k = 0
 for1print:
	#blt $t2, $t0, exit	
	beq $t2, $t0, exit	# for(j=0; j<m; j++)
	li $t3, 0		# k = 0	
 for2print: 
	#blt $t3, $t0, for1print    
	beq $t3, $t0, end2print	# for(k=0; k<m; k++)
	mul $t4, $t2, $t0		# j*m
	add $t5, $t4, $t3		# j*m+k
	sll $t7, $t5, 2
	
	lw $t6, CC($t7)			# load array value
	li $v0, 1			# print integer
	add $a0, $t6, $0
	syscall
	li $v0, 4
	la $a0, space			# print space
	syscall
	addi $t3, $t3, 1		
	#addi $t7, $t7, 4		# increment by 4 
	#move $t6, $v0
	j for2print
 end2print:
 	li $v0, 4 		# print newline 
	la $a0, newline
	syscall
 	addi $t2, $t2, 1
 	j for1print
	
#  1.  First, read m (the matrices will then be size mxm).
#  2.  Next, read matrix A followed by matrix B.
#  3.  Compute matrix product.  You will need triple-nested loops for this.
#  4.  Print the result, one row per line, with one (or more) space(s) between
#      values within a row.
#  5.  Exit.
#
#------------ END CODE ---------------


exit:                     # this is code to terminate the program -- don't mess with this!
  addi $v0, $0, 10      	# system call code 10 for exit
  syscall               	# exit the program



#------- If you decide to make other functions, place their code here -------
#
#  You do not have to use helper methods, but you may if you would like to.
#  If you do use them, be sure to do all the proper stack management.
#  For this exercise though, it is easy enough to write all your code
#  within main.
#
#------------ END CODE ---------------
