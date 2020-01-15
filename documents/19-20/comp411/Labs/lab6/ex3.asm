#---------------------------------
# Lab 6: Pixel Conversion
#
# Name: Katherine Li
#
# --------------------------------
# Below is the expected output.
# 
# Converting pixels to grayscale:
# 0
# 1
# 2
# 34
# 5
# 67
# 89
# Finished.
# -- program is finished running --
#---------------------------------

.data 0x0
  startString:  .asciiz "Converting pixels to grayscale:\n"
  finishString: .asciiz "Finished.\n"
  newline:      .asciiz "\n"
  pixels:       .word   0x00010000, 0x010101, 0x6,      0x3333,
                        0x030c,     0x700853, 0x294999, -1

.text 0x3000

main:
  addi $v0, $0, 4       	# system call code 4 for printing a string
  la   $a0, startString      	# put address of startString in $a0
  syscall               	# print the string

  add $t0, $0, $0		# t0 = i = 0
  
loop: 
  lw $t4, pixels($t0)		# t4 = pixels[i]
  beq $t4, -1, exit		# exit loop if equal to -1

  andi $t1, $t4, 0xff		# t1 = blue
  srl $t4, $t4, 8		# t4 >> 8
  andi $t2, $t4, 0xff		# t2 = green
  srl $t4, $t4, 8		# t4 >> 8
  andi $t3, $t4, 0xff		# t3 = red

  jal rgb_to_gray		# call rgb to gray function

  addi $v0, $0, 1		# print int
  add $a0, $0, $t5		# a0 = gray
  syscall
  
  addi $v0, $0, 4		# print string
  la $a0, newline		# load address newline to a0
  syscall
  
  addi $t0, $t0, 4		# t0++
  j loop			#jump to the beginning of the loops

# There is already code below that prints the final message "Finished.",
#   and terminate the program.
#
#
#------------ END CODE ---------------


exit:

  addi $v0, $0, 4            	# system call code 4 for printing a string
  la   $a0, finishString   	# put address of finishString in $a0
  syscall               	# print the string

  addi $v0, $0, 10      	# system call code 10 for exit
  syscall               	# exit the program



#----------------------------------------------------------#



#---- Procedure rgb_to_gray ----#
#
#
#-------------------------------#

rgb_to_gray:            # procedure to calculate gray = (red + green + blue) / 3
  add $t6, $t1, $t2		# temp = blue + green
  add $t6, $t6, $t3		# temp = temp + red
  div $t5, $t6, 3		# gray = temp / 3

#------- INSERT YOUR CODE HERE -------
#
# Simply add instructions here to calculate
#   gray = (red + green + blue) / 3
#
#   i.e., $v0 = ($a0 + $a1 + $a2) / 3
#
#  That's it!
#
#------------ END CODE ---------------

  jr $ra                # return to main
