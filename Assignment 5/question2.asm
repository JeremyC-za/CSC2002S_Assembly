#Jeremy Coupland
#CPLJER001
#CSC2002S - Assignment 5, Question 2
#2014/10/04

.data
entMsg: .asciiz 		"Enter a number:\n"
isP: .asciiz 		"It is prime\n"
isNtP: .asciiz 		"It is not prime\n"
x:	.word		0
start: .word	1

.text
main:
   addi $t1, $zero, 0
   la $a0,entMsg
   li $v0, 4			#Asks for input
   syscall

   li $v0, 5
   syscall				#Sets input to x
   sw $v0,x

   lw $s0,start			#Sets bounds for loop
   lw $s1,x 
               
looptop:
   bgt $s0,$s1,loopend     # stop if i>x
   div $s1,$s0		      # s0 / s1
   mfhi $t3
   add $s0, $s0, 1         #increment i
   beq $t3, $zero, equal
   j looptop               # go to top of loop

loopend:
   li $t0, 2
   beq $t1, $t0, prime      #Checks equalities
   bne $t1, $t0, ntPrime

equal:
   add $t1, $t1, 1          #Increments number of factors
   j looptop

prime:
   la $a0,isP
   li $v0, 4			#Prints out prime number
   syscall
   j exit

ntPrime:
   la $a0,isNtP
   li $v0, 4			#Prints out not prime number
   syscall
   j exit

exit:
   jr $ra				#Exits program
