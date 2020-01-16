# Starter file for ex1.asm

.data 0x0
	newline: 	.asciiz "\n"
        
.text 0x3000
.globl main

main:
	ori $sp, $0, 0x3000	# Initialize stack pointer
	addi $fp, $sp, -4	# set frame pointer
	# while
	li $v0, 5		# scanf(%d, &n)
	syscall
	move $a0, $v0
	
	beq $a0, $0, end 	# if(n==0) break
	
	li $v0, 5		#scanf(%d, &k)
	syscall
	move $a1, $v0
	
	#beq $a0, $0, loop
	
	jal NchooseK
	
	addi $a0, $v0, 0	# v0 = a0 (n) 
	ori $v0, $0, 1		# print result
	syscall 
	
	li $v0, 4		#print new line
	la $a0, newline
	syscall
	
	j main
	
	#----------------------------------------------------------------#
	# Write code here to do exactly what main does in the C program.
	#
	# Please follow these guidelines:
	#
	#	Use syscall 5 each time to read an integer (scanf("%d", ...))
	#	Then call NchooseK to compute the function
	#	Then use syscall 1 to print the result
	#   Put all of the above inside a loop
	#----------------------------------------------------------------#


end: 
	ori   $v0, $0, 10     # system call 10 for exit
	syscall               # we are out of here.

NchooseK:    		# PLEASE DO NOT CHANGE THE NAME "NchooseK"
	#----------------------------------------------------------------#
	# $a0 has the number n, $a1 has k, from which to compute n choose k
	#
	# Write code here to implement the function you wrote in C.
	# Your implementation MUST be recursive; an iterative
	# implementation is not acceptable.
	#
	# $v0 should have the NchooseK result to be returned to main.
	#----------------------------------------------------------------#
	beq $a0, $0, returnOne		# if(n==0||k==0||k==n) return 1
	beq $a1, $0, returnOne
	beq $a1, $a0, returnOne
	
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $fp, 0($sp)
	addi $fp, $sp, 4
	addi $sp, $sp, -8
	sw $a0, -8($fp)
	sw $a1, -12($fp)
	
	addi $a0, $a0, -1	# n-1
	addi $a1, $a1, -1	# k-1
	
	jal NchooseK
	
	lw $a0, -8($fp)
	lw $a1, -12($fp)
	sw $v0, -8($fp)		# NchooseK(n-1, k-1)
	
	addi $sp, $sp, 4
	addi $a0, $a0, -1	# n-1
	
	jal NchooseK
	
	lw $t0, -8($fp)		# NchooseK(n-1, k)
	addu $v0, $v0, $t0	# NchooseK(n-1, k-1) + NchooseK(n-1, k)
	addi $sp, $sp, 4
	
  restore: # restore sp and fp
  	lw $ra, 0($fp)
  	lw $fp, -4($fp)
  	addi $sp, $sp, 8
  	jr $ra
	
  returnOne:
  	addi $v0, $0, 1
	jr	$ra
  exit:
  	lw $ra, 0($fp)
  	lw $fp, -4($fp)
  	addiu $sp, $sp, 8
  	jr $ra
