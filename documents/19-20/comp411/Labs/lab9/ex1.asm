.data 0x0
	n:	.space 8	# int n
	pattern: .space 400 	# char pattern[21]
	newline: .asciiz "\n"
	#terminator: .asciiz '\0'
.text 0x3000
.globl main

main: 
	ori $sp, $0, 0x3000	# Initialize stack pointer
	addi $fp, $sp, -4	# set frame pointer
	
	li $v0, 5 		# scanf("%d", &n)
	syscall
	add $t4, $v0, $0	# N = t4
	move $a0, $v0		# n = a0
	#sw terminator, pattern($a0) # pattern[n] = '\0'
	
	jal makepatterns	# generate patterns
	
	j exit
	
makepatterns:
	beq $a0, $0, print		# if(N(input) == 0)
	addi $sp, $sp, -12		# make space on the stack
	sw $fp, 4($sp)
	sw $ra, 8($sp)
	#addi $fp, $sp, 4
	#addi $sp, $sp, -4
	sw $a0, ($sp)
	#sw $a1, -12($fp)		
	
	#move $a2, $a0			# move n = a2
	# else
	addi $t5, $a0, -1		# N-1
	sll $t5, $t5, 2
	sw $0, pattern($t5)		# pattern[N-1] = 0
	la $a1, pattern			# pattern = a1
	
	subi $a0, $a0, 1
	jal makepatterns
	
	lw $a0, ($sp)			# make space on the stack 
	
	addi $t5, $a0, -1
	sll $t5, $t5, 2
	sw $1, pattern($t5)		# pattern[N-1] = 1
	la $a1, pattern			# pattern = a1
	
	subi $a0, $a0, 1
	jal makepatterns
	
	#addi $sp, $sp, 4
	
 restore: # restore fp and sp
	lw $ra, 8($sp)
  	lw $fp, 4($sp)
  	addi $sp, $sp, 12
  	jr $ra
  	
 print:
 	addi $t1, $t4, 0		# i = n
 	for: 
	 beq $t1, $0, endfor
	 addi $t2, $t1, -1		# i-1
	 sll $t2, $t2, 2
	 lw $t3, pattern($t2)
	 li $v0, 1			# print integer
	 add $a0, $t3, $0
	 syscall
	 addi $t1, $t1, -1		# i--
	 j for
 endfor: 
	li $v0, 4
	la $a0, newline
	syscall
	jr $ra
 exit: 
	ori $v0, $0, 10
	syscall
	