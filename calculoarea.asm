#calculator for triangle, square and rectangle area
.data
	msg1: 	.asciiz "Calculate area\n1.Triangle\n2.Square\n3.Rectangle\n0.Exit\n"
	msg2:	.asciiz "Height: "
	msg3:	.asciiz "Base: "
	msgQ:	.asciiz "Side: "
	msg4:	.asciiz "Area = "
	enter:	.asciiz "\n==================================\n"
	end:	.asciiz "End"

.text

main:
	#print menu for user choice
	la $a0, msg1
	li $v0, 4
	syscall
	#receive choice
	li $v0, 5
	syscall
	#switch
	beq $v0, 1, areaT	#if choose 1, calculate area of triangle
	beq $v0, 2, areaQ	#if choose 2, calculate area of square
	beq $v0, 3, areaR	#if choose 3, calculate area of rectangle
	beq $v0, 0, exit	#if choose 0, end program
	
areaT:	#base x height / 2
	#print and receive base value
	la $a0, msg3
	li $v0, 4
	syscall			#print
	add $v0, $0, 6
	syscall			#receives value of base and stores in f0
	add.s $f1, $f1, $f0	#store f0 in f1
	#print and receive height value
	la $a0, msg2
	li $v0, 4
	syscall			#print
	add $v0, $0, 6
	syscall			#receives value of height and stores in f0
	add.s $f2, $f2, $f0	#store f0 in f2
	#calculate area of triangle
	mul.s $f0, $f1, $f2	#base x height and save in f0
	#load 2 float
	addi $t0, $0, 2
	mtc1 $t0, $f2		#f2 = 0.0
	cvt.s.w $f2, $f2
	div.s $f0, $f0, $f2	#divide by 2 and save in f0
	#reset f1 and f2
	addi $t0, $0, 0
	mtc1 $t0, $f4		#f4 = 0.0
	cvt.s.w $f4, $f4
	add.s $f1, $f4, $f4	#reset f1
	add.s $f2, $f4, $f4	#reset f2
	j printf		#jump printf
	
areaQ:	#side x side
	#print and receive side value
	la $a0, msgQ
	li $v0, 4
	syscall			#print
	add $v0, $0, 6
	syscall			#receives value of side and stores in f0
	#calculate area of square
	mul.s $f0, $f0, $f0 	#side x side and save in f0 
	j printf		#jump printf
	
areaR:	#base x height
	#print and receive base value
	la $a0, msg3
	li $v0, 4
	syscall			#print
	add $v0, $0, 6
	syscall			#receives value of base and stores in f0
	add.s $f1, $f1, $f0	#store f0 in f1
	#print and receive height value
	la $a0, msg2
	li $v0, 4
	syscall			#print
	add $v0, $0, 6
	syscall			#receives value of height and stores in f0
	add.s $f2, $f2, $f0	#store f0 in f2
	#calculate area of rectangle
	mul.s $f0, $f1, $f2	#base x height and save in f0
	#reset f1 and f2
	addi $t0, $0, 0
	mtc1 $t0, $f4		#f4 = 0.0
	cvt.s.w $f4, $f4
	add.s $f1, $f4, $f4	#reset f1
	add.s $f2, $f4, $f4	#reset f2
	j printf		#jump printf

printf:	#print area result
	la $a0, msg4
	li $v0, 4
	syscall
	li $v0, 2
	mtc1 $0, $f3		#f3 = 0.0
	add.s $f12, $f3, $f0	#f12 print float
	syscall	
	la $a0, enter		#\n
	li $v0, 4
	syscall
	j main			#jump main to loop

exit:	#end program
	la $a0, end
	li $v0, 4
	syscall
	li $v0, 10
	syscall