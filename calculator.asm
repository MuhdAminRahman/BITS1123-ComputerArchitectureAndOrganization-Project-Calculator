.data
	myArray: .space 40
	
	introMsg : .asciiz "Welcome to sorting calculator!\n"
	inputMsg : .asciiz "Please enter 10 random numbers. 10\n"
	sortingMsg: .asciiz "Sorting your inputs...\n"
	ascendingMsg: .asciiz "Numbers in ascending order\n"
	totalMsg : .asciiz "Total sum of your input: "
	largestMsg: .asciiz "The largest number in your input: "
	whitespaceMsg: .asciiz "\t"
	endlineMsg: .asciiz "\n"
.text
main:
	addi $t0,$zero,0 # int i=0 loop counter

	
	intro:
		li $v0,4#tells the system to display string/text
		la $a0,introMsg #loads the text as the system arguments
		syscall
	geInput:
		li $v0,4#tells the system to display string/text
		la $a0,inputMsg #loads the text as the system arguments
		syscall
		getInputLoop:
			beq,$t0,40,counterreset #if counter $t0 == 40 branch to counterreset
			li $v0,5 #tells the system to get integer input from user
			syscall
			
			storeInput:
				sw $v0,myArray($t0)#store the input from user in myArray at address $t0
			addi $t0,$t0,4 #counter +1 /i+1
			j getInputLoop #loops back to get input
	counterreset:

		addi $t0,$zero,0 #reset the counter to 0/ i=0
		addi $t2,$zero,0 #makes sure t2 is zero/used to store array[i+1]
		addi $t2,$t0,4 # i+1
		#print message sorting
		li $v0,4#tells the system to display string/text
		la $a0,sortingMsg #loads the text as the system arguments
		syscall

	sortingArray:
		
		beq $t0,40,doneSort #branch if i = 10
		
		innerloop:
			beq $t2,40,endinnerloop
			lw $t1,myArray($t0) # $t1 = array[i]
			lw $t3,myArray($t2) # $t3 = array[i+1]
			slt $s0,$t1,$t3 #set $s0 to 1 if $t1 > $t3
			beq $s0,1,swap #if $s0 == 1 branch to swap
			addi $t2,$t2,4
			j innerloop
			swap:
				sw $t3,myArray($t0)
				sw $t1,myArray($t2)
				addi $t2,$t2,4
				addi $s0,$zero,0
				j innerloop
			
		endinnerloop:
			addi $t2,$zero,0 #reset $t2 counter
			addi $t0,$t0,4
			j sortingArray
	doneSort:
		addi $t0,$zero,0 #reset counter i=0
		addi $t3,$zero,0 #reset t3
		calcTotal:
			beq $t0,40,doneTotal
			lw $t3,myArray($t0)
			add $t4,$t4,$t3 #store total in $t4
			addi $t0,$t0,4
			j calcTotal
	doneTotal:
		addi $t0,$zero,0 #reset counter i=0 
		addi $t0,$t0,36
		lw $t5,myArray($t0)#store max value of myArray in $t5
		addi $t0,$zero,0 #reset counter i=0
		
		#display ascending
		li $v0,4#tells the system to display string/text
		la $a0,ascendingMsg #loads the text as the system arguments
		syscall
		
	displayAscending:
		beq $t0,40,displayTotal
		lw $t6,myArray($t0)
		li $v0,1
		move $a0,$t6
		syscall
		#display whitespace in between array
		li $v0,4#tells the system to display string/text
		la $a0,whitespaceMsg #loads the text as the system arguments
		syscall
		addi $t0,$t0,4
		j displayAscending
	
	displayTotal:
	li $v0,4#tells the system to display string/text
	la $a0,endlineMsg #loads the text as the system arguments
	syscall
	li $v0,4#tells the system to display string/text
	la $a0,totalMsg #loads the text as the system arguments
	syscall
	#display total
	li $v0,1
	move $a0,$t4
	syscall
	li $v0,4#tells the system to display string/text
	la $a0,endlineMsg #loads the text as the system arguments
	syscall
	
	displayMax:
	li $v0,4#tells the system to display string/text
	la $a0,largestMsg #loads the text as the system arguments
	syscall
	#display largest/max value
	li $v0,1
	move $a0,$t5
	syscall
	li $v0,4#tells the system to display string/text
	la $a0,endlineMsg #loads the text as the system arguments
	syscall
	
		
	#exit program
	li $v0,10
	syscall