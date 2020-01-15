.data 0x0
  maze: 	.space 400
  wasHere: 	.space 400
  correctPath: 	.space 400
  input:	.space 100
  newline: 	.asciiz "\n"
  period: 	.ascii "."
  star:		.ascii "*"
  start: 	.ascii "S"
  finish: 	.ascii "F"
	
.text 0x3000
.globl main

main: 	
	li $v0, 5	# scanf("%d")
	syscall
	move $s0, $v0	# width = s0
	
	li $v0, 5	# scanf("%d")
	syscall
	move $s1, $v0	# height = s1
	
#	li $v0, 12		# read empty line 
# 	syscall
	
	lb $t2, start	# S = t2
	lb $t9, finish	# F = t9
	lb $s7, star	# * = s7
 	
 	li $t0, 0	# y = 0
 forHeight:
 	beq $s1, $t0, endforH 		# for(y=0; y<height; y++)
 	
 	li $v0, 8			# scanf as string
 	la $a0, input
 	addi $a1, $s0, 2
 	syscall 
 	#sw $v0, input
 	
 	li $t1, 0			# x = 0
 forWidth:
 	beq $s0, $t1, endforW		# for (x=0; x<width; x+++)
 	#li $v0, 12			# scanf("%c")
 	#syscall
 	#move $s2, $v0
 	lb $s2, input($t1)			# tempchar = s2
 	
 	beq $s2, $t2, ifStart	# if (tempchar == 'S')
	beq $s2, $t9, ifFinish	# if (tempchar == 'F')
	
   continue:
	mul $t3, $t0, $s0	# index
 	add $t4, $t3, $t1
 	sb $0, wasHere($t4)		# wasHere[y][x] = false
 	sb $0, correctPath($t4)	# correctPath[y][x] = false
 	 	
 	sb $s2, maze($t4)		# maze(y*width+x)
 	addi $t1, $t1, 1
 	j forWidth
 endforW:
 #	li $v0, 12		# read empty line 
 #	syscall
 	
 	addi $t0, $t0, 1	# y++
 	j forHeight
 endforH:  	
 	
 	add $a0, $s3, 0
 	add $a1, $s4, 0
 	
 	jal recursiveSolve
 	
 	li $t5, 0	# i = 0
 forPrintH:
 	beq $s1, $t5, exit
 	li $t6, 0	# k = 0
 forPrintW:
 	beq $s0, $t6, endprintW
 	
 	mul $t3, $t5, $s0	# index
 	add $t4, $t3, $t6
 	
 	lb $a2, correctPath($t4) # if(correctPath[i][k])
 	li $t3, 1
 	beq $a2, $t3, True 
 printmaze:
 	li $v0, 11	# printf("%c", maze[i][k]) 
 	lb $a0, maze($t4)
 	syscall
 	addi $t6, $t6, 1
 	j forPrintW
  True:
  	 lb $a3, maze($t4) 
 	 beq $a3, $t2, printmaze # if (maze[i][k] == 'S')
 	 lb $v1, period
 	 sb $v1, maze($t4)	# maze[i][k] = '.'
 	 j printmaze
 endprintW:
 	li $v0, 11
 	lb $a0, newline
 	syscall
 	addi $t5, $t5, 1
 	j forPrintH
 	
 ifStart:
 	addi $s3, $t1, 0	# s3 = startX = x
 	addi $s4, $t0, 0	# s4 = startY = y
 	j continue
 ifFinish:
 	addi $s5, $t1, 0	# s5 = endX = x
 	addi $s6, $t0, 0	# s6 = endY = y
 	j continue
 
 recursiveSolve: 
	addi $sp, $sp, -16
	sw $ra, 12($sp)
	sw $a0, 8($sp)	# x
	sw $a1, 4($sp)	# y
	sw $a2, 0($sp)	# index
 
	addi $t0, $s3, 0 # store startX
	addi $t1, $s4, 0 # store startY
  	
	bne $a0, $s5, else # if ( x == endX && y == endY) return 1
	bne $a1, $s6, else
	j returnTrue
  else:   
	mul $t3, $a1, $s0
	add $a2, $t3, $a0	# a2 = y*width+x
	
	lb $t0, maze($a2)
	beq $t0, $s7, returnFalse # if ( maze[y][x] == '*' return 0
	lb $t1, wasHere($a2)	# wasHere[y][x]) return 0
	li $t5, 1
	beq $t1, $t5, returnFalse
	
	sb  $t5, wasHere($a2)	# wasHere[y][x] = true
	bne $a0, 0, leftEdge	# if (x != 0)
 if2:
	addi $t6, $s0, -1	# width - 1
	bne $a0, $t6, rightEdge# if (x != width - 1)
 if3:
	bne $a1, 0, topEdge	# if (y != 0)
 if4:	
	addi $t6, $s1, -1	# height - 1
	bne $a1, $t6, bottomEdge	# if (y != height - 1)
	
	#j returnFalse
	
  leftEdge:	
   	addi $a0, $a0, -1 	# x-1
	jal recursiveSolve   	# if (recursiveSolve(x-1, y)
	beq $t5, $v0, returnTrue
	addi $a0, $a0, 1
	j if2
  rightEdge:	
  	addi $a0, $a0, 1	# x+1
  	jal recursiveSolve	# if (recursiveSolve(x+1, y))
  	beq $t5, $v0, returnTrue
  	addi $a0, $a0, -1
	j if3
	
  topEdge:	
  	addi $a1, $a1, -1	# y-1
	jal recursiveSolve	# if (recursiveSolve(x, y-1)
	beq $t5, $v0, returnTrue
	addi $a1, $a1, 1
	j if4
	  	
  bottomEdge: 
  	addi $a1, $a1, 1	# y+1
	jal recursiveSolve	# if (recursiveSolve(x, y+1)
 	beq $t5, $v0, returnTrue
 	addi $a1, $a1, -1
	j returnFalse
	  	
 returnTrue:
 	sb $t5, correctPath($a2)
 	addi $v0, $0, 1
 	j restore
 	
 returnFalse: 
 	addi $v0, $0, 0
 	j restore

restore: 
	lw $ra, 12($sp)
	lw $a0, 8($sp)
	lw $a1, 4($sp)
	lw $a2, 0($sp)
  	addi $sp, $sp, 16
  	jr $ra
 
exit: 
	addi $v0, $0, 10
	syscall
