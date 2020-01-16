.data 
	strings: 	.space 100
	array:		.space 10000
#	prompt1: 	.asciiz "Please enter "
#	prompt2: 	.asciiz " strings, one per line:"
#	inputprompt:	.asciiz "Here are the strings in the order you entered:"
#	sortedprompt: 	.asciiz "In alphabetical order, the strings are:"
	newline: 	.asciiz "\n"
#	null: 		.ascii "\0"

.text 
.globl main

 main:
 	la $s0, array # store str val
 	la $s2, strings # store pointers
 	
 	li $v0, 5
 	syscall
 	move $s1, $v0	# N = s1
 	
 	li $t0, 0	# j = 0
 forread:
 	mul $t5, $s1, 4
 	beq $t0, $t5, tosort	# for (int j=0; j<N; j++)
 	
 	move $a0, $s0
 	li $v0, 8		# fgets(strings[j])
 	li $a1, 100
 	syscall
 	sw $a0, strings($t0)
 	
 	addi $t0, $t0, 4
 	addi $s0, $s0, 240
 	j forread
 tosort: 	
 	li $t2, 0
 	addi $t2, $s1, -1 # m = N -1
 forsortj:
 	beq $t2, $0, finalprint 	# for(int m=N-1; m>0; m--)
 	li $t3, 0	# n = 0
 forsortk:
 	mul $t9, $t2, 4
 	beq $t3, $t9, endfork		# for(int n=0; n<m; n++)
 	addi $t8, $t3, 4
 	lw $a2, strings($t3)		# strings[n]
 	lw $a3, strings($t8)		# strings[n+1]
 	jal compareStrings 		# compare = compareStrings(strings[n], strings[n +1])
 	
# 	li $v0, 1
# 	move $a0, $v0
# 	syscall
 	
 	move $t6, $v0	# compare
 	li $t7, -1
 	beq $t6, $t7, finish		# if (compare == 1)
 	beq $t6, $0, finish
   	jal swapStrings			# swapStrings(strings[n], strings[n+1])
   	
   finish:
 	addi $t3, $t3, 4
 	j forsortk
 endfork:
 	addi $t2, $t2, -1 
 	j forsortj
 	
 finalprint:
 	li $t4, 0
 sortprint:
 	beq $t4, $t5, exit
 	
 	lw $a0, strings($t4)
 	li $v0, 4
 	syscall
 	
 	addi $t4, $t4, 4
 	j sortprint
 		
  compareStrings:
  	li $t0, 0	# i=0
#  	lw $a2, string1
#    	lw $a3, string2
    while: 
 #   	la $s3, null
 	add $t7, $a2, $t0
    	lb $t8, 0($t7)
    	add $t7, $a3, $t0
    	lb $t9, 0($t7)
    	
  	beq $0, $t8, returnzero
  	beq $0, $t9, returnpos
  	
  	blt $t8, $t9, returnneg
  	blt $t9, $t8, returnpos
  	
  	addi $t0, $t0, 1
  	j while  	  	
   returnzero:
   	li $v0, 0
   	jr $ra
   returnneg:
   	li $v0, -1
   	jr $ra
   returnpos:
	li $v0, 1
   	jr $ra
   	
  swapStrings:
  	li $t1, 0	# n=0
  	li $t4, 100
#  	lw $a2, string1
#  	lw $a3, string2
  loop:
  	beq $t1, $t4, endswap
  	
  	add $t7, $a2, $t1
  	add $t6, $a3, $t1
  	
  	lb $t8, 0($t7)
  	lb $t9, 0($t6)
  	sb $t8, 0($t6)
  	sb $t9, 0($t7)
  	
  	addi $t1, $t1, 1
  	j loop
  endswap:
  	jr $ra
  
 exit: 
 	li $v0, 10
 	syscall