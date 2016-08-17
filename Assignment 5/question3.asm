#Jeremy Coupland
#CPLJER001
#CSC2002S - Assignment 5, Question 3
#2014/10/05

.data
entN:		.asciiz	"Enter the starting point N:\n"
entM:		.asciiz	"Enter the ending point M:\n"
list:		.asciiz	"The palindromic primes are:\n"
space:	.asciiz	"\n"
N:		.word		0
M:		.word		0

.text
main:
	la $a0,entN
   	li $v0, 4				#Enter N
   	syscall

	li $v0, 5
  	syscall				#Stores N
   	sw $v0,N 
	
	la $a0,entM
   	li $v0, 4				#Enter M
   	syscall

	li $v0, 5
  	syscall				#Stores M
   	sw $v0,M

	la $a0,list
	li $v0, 4				#Prints last message of program
	syscall
 

	lw $t0, N				#t0 = N
	lw $t1, M				#t1 = M
	beq $t0, $t1, exit		#checks if t0 == t1

	add $t0, $t0, 1			#t0++
	move $s0, $t0			#s0 = t0 = i

	beq $t0, $t1, exit		#checks if t0 == t1
	sub $t1, $t1, 1			#t1--
	move $s1, $t1			#s1 = t1



looptop:
	beq $s0, $s1, exit		#if N==M, exit
	move $t4, $s0			#t4 = i
	move $t7, $s0			#t7 = i
	add $s0, $s0, 1			#increment i
	move $a1, $zero			#remainder = 0
	j checkPal	

checkPal:
	
	li $t0, 10				#t0 = 10
	li $t1, 0				#t1 = 0
	
	divu $t4, $t0			#i / 10
	mflo $t4				#t4 = quotient 
	mfhi $t3				#t3 = remainder
	mul 	$a1, $a1, $t0		#reverse = reverse*10
	addu 	$a1, $a1, $t3		# + remainder
	bne $t4, $zero, checkPal
	j check

check:
	beq $t7, $a1, checkPrime	#if palindrome, check prime
	bne $t7, $a1, looptop		#else, continue

checkPrime:
	li $s2, 2				#s2 = 2 = y
	sub $s3, $s0, 1			#s3 = s0 - 1 = i-1
	j primeLoop

primeLoop:
	beq $s2, $s3, isP		
	div $s3, $s2			#$s3 / $s2 
	mfhi $t6				#sets remainder to t6
	addu $s2, $s2, 1		#increment y
	beq $t6, $zero, equal		#if number divides perfectly
	j primeLoop

equal:
	j looptop
	
isP:
	li $v0, 1
	move $a0, $t7
	syscall

	la $a0,space
   	li $v0, 4			
   	syscall
	
	j looptop

exit:
	jr $ra	
	