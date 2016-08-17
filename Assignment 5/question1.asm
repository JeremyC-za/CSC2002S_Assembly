#Jeremy Coupland
#CPLJER001
#CSC2002S - Assignment 5, Question 1
#2014/10/04

.data
isPaln: .asciiz	"It is a palindrome\n"
isNotPaln: .asciiz		"It is not a palindrome\n"
entMsg:	.asciiz "Enter a number:\n"
x: .word 0


.text
main:
	la $a0,entMsg
   	li $v0, 4			# Enter a number
   	syscall

	li $v0, 5
  	syscall			# Stores number
   	sw $v0,x 

	lw $s3, x			# Keeps track of original x
	lw $s0, x			# Sets x = s0
	li $t1, 10			# Sets t1 = 10
    	li $t3, 0			# Sets t3 = 0
    	move $a2, $t3		# sets a2 = t3, ie a2 = 0
    	beq $s0, 0, goto		# if (s0 == 0) goto

loop:
    	divu $s0, $t1      	# Divide number by 10
     	mflo $s0           	# $s0 = quotient
     	mfhi $t2           	# $t2 = reminder
     	mul $a2, $a2, $t1  	# reverse=reverse*10
     	addu $a2, $a2, $t2 	# + reminder    
     	bne $s0, 0,loop
	j check   
goto: 
     	move $s0, $a2
     	j check    	   	# $a2 contains reverse

check:
	beq $s3, $a2, isPal
	bne $s3, $a2, isNotPal

isPal:
	la $a0,isPaln
   	li $v0, 4
   	syscall
	j exit

isNotPal:
	la $a0,isNotPaln
   	li $v0, 4
   	syscall
	j exit

exit:
	jr $ra

