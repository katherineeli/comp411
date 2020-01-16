.data
.align 2
  animals: .space 400
  lyrics:  .space 400
  astring: .space 60
  lstring: .space 3200

  newline: 	.asciiz "\n"
  first: 	.asciiz "There was an old lady who swallowed a "
  semicolon: 	.asciiz ";"
  second: 	.asciiz "She swallowed the "
  catch: 	.asciiz " to catch the "
  last:		.asciiz "I don't know why she swallowed a "
  dash: 	.asciiz " - "
  space: 	.asciiz " "
  end: 		.asciiz "END"
  
.text

main: 
	li $t0, 0	# i = 0
	li $t1, 0	# line = 0
	li $t3, 1	# iterator = 1
	la $s0, animals # store pointers
	la $s1, lyrics
	la $s2, astring # store string values 
	la $s3, lstring
  read: 
  	move $a0, $s2	# store string 
	li $v0, 8	# fgets animals[i]
	li $a1, 16
	syscall
  	
  	li $t4, 0
  removeenter:
  	add $t7, $a0, $t4
  	lb $a3, 0($t7)
  	addi $t4, $t4, 1
  	bnez $a3, removeenter
  	beq $a1, $t4, next
  	addi $t4, $t4, -2
  	add $t7, $t4, $a0
  	sb $0, 0($t7)
  	
  next: 
	li $t2, 0	# compare = 0

  compare: # compare the input to END\n
	beq $t2, 3, stop
	add $t3, $a0, $0
	lb $a2, 0($t3)
  	lb $a3, end($0)
  	bne $a2, $a3, nocomp # if (animals[i] == END)) break
  	addi $t2, $t2, 1
  	j compare
  nocomp: 
  	sw $a0, animals($t0) # store pointer 
  	
  	move $a0, $s3	# store string 
	li $v0, 8	# fgets lyrics[i]
	li $a1, 61
	syscall
	sw $a0, lyrics($t0) # store pointers
	
	addi $t1, $t1, 2	# move line counter
	addi $t0, $t0, 4	# i++
	addi $t3, $t3, 1	# increment
	addi $s2, $s2, 240	# make more space
	addi $s3, $s3, 240
	j read

  stop:
  	#addi $t1, $t1, -2
  		
	li $v0, 4	# printf("There was an old lady who swallowed a %s;\n", animals[0]);
	la $a0, first
	syscall
	
	li $v0, 4
	lw $a0, animals($0)
	syscall 
	
	li $v0, 4
	la $a0, semicolon
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	li $t4, 1	# j = 1
	div $t6, $t1, 2		# line/2 = t6
	#li $t7, 0
  forj:
  	beq $t4, $t6, exitj
  	li $t5, 0	# spacecounter = 0
   forspacej:
   	beq $t5, $t4, endforj  	
   	li $v0, 4		# printf("%*s", j, ""); 
   	la $a0, space
   	syscall
   	addi $t5, $t5, 1
   	j forspacej
   endforj:
   	addi $t7, $t4, 0
   	addi $t7, $t7, -1
   	sll $t7, $t7, 2	
   	
  	li $v0, 4		# printf("She swallowed the %s to catch the %s;\n", animals[j-1], animals[j]);
  	la $a0, second		
  	syscall
  	
  	#addi $t7, $t4, -1	# j-1
  	lw $a0, animals($t7)
  	li $v0, 4
  	syscall
  	
  	li $v0, 4
  	la $a0, catch
  	syscall 
  	
  	addi $t7, $t7, 4
  	lw $a0, animals($t7)
  	li $v0, 4
  	syscall
  	
  	li $v0, 4
	la $a0, semicolon
	syscall
	
  	li $v0, 4
	la $a0, newline
	syscall
  	
  	addi $t4, $t4, 1	# j++
  	j forj
 exitj:
 
  li $t1, 0  
  li $t4, 0 # k = t4
  #div $t6, $t1, 2
  addi $t4, $t6, 0 	# k = line/2 = t4
  fork:
  	beq $t4, $t1, exit
  	li $t5, 0  	# spacecounter = 0	
  	addi $t8, $t4, -1	# k-1
  forspacek:
   	beq $t5, $t8, endfork		# printf("%*s", k-1, "");
   	li $v0, 4
   	la $a0, space
   	syscall
   	addi $t5, $t5, 1
   	j forspacek
   endfork:
   	addi $t9, $t4, 0
   	addi $t9, $t9, -1
   	sll $t9, $t9, 2
   	
   	li $v0, 4			# printf("I don't know why she swallowed a %s - %s\n")
   	la $a0, last
   	syscall
   	
   	#addi $t9, $t4, -1	# k-1
   	lw $a0, animals($t9)
   	li $v0, 4
   	syscall
   	
   	li $v0, 4
   	la $a0, dash
   	syscall
   	
   	lw $a0, lyrics($t9)
   	li $v0, 4
   	syscall
   	
   	addi $t4, $t4, -1
   	j fork 
 	 	
exit:
  	li $v0, 10
  	syscall
	
