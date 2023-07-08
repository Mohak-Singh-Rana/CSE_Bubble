main:
    addi $s7, $zero, 0          # {6'b000010,5'b00000,5'b01001,16'd0}

	# li $s0, 0					#initialize counter 1 for loop 1
    addi $s0, $zero, 0          # {6'b000010,5'b00000,5'b00010,16'd0}

	# li $s6, 4 					#n - 1
    addi $s6, $zero, 4          # {6'b000010,5'b00000,5'b01000,16'd4}
	
	# li $s1, 0 					#initialize counter 2 for loop 2
    addi $s1, $zero, 0          # {6'b000010,5'b00000,5'b00011,16'd0}

	# li $t3, 0					#initialize counter for printing
    addi $t3, $zero, 0          # {6'b000010,5'b00000,5'b01101,16'd0}

	# li $t4, 5
    addi $t5, $zero, 5          # {6'b000010,5'b00000,5'b01110,16'd5}

loop:
	sll $t7, $s1, 2			# 001111 00011 10001 00000 00010 000000		#multiply $s1 by 2 and put it in t7
	add $t7, $s7, $t7 		# 000000 01001 10001 10001 00000 100000		# add the address of numbers to t7

	lw $t0, 0($t7)  		# 100001 10001 01010 0000000000000000 		#load numbers[j]	
	lw $t1, 4($t7) 			# 100001 10001 01011 0000000000000001		#load numbers[j+1]

	slt $t2, $t0, $t1		# 101000 01010 01011 01100 00000 101010		#if t0 < t1
	bne $t2, $zero, increment      # 010101 01100 00000 0000000000000010 

	sw $t1, 0($t7) 		# 100000 10001 01011 0000000000000000			#swap
	sw $t0, 4($t7)      # 100000 10001 01010 0000000000000001

increment:	

	addi $s1, $s1, 1		# 000010 00011 00011 0000000000000001		#increment t1
	sub $s5, $s6, $s0 		# 000000 01000 00010 00111 00000 100010		#subtract s0 from s6

	bne  $s1, $s5, loop		#  {6'b010101,5'b00111,5'b00011,-16'd11} 	#if s1 (counter for second loop) does not equal 9, loop
	addi $s0, $s0, 1 		# 000010 00010 00010 0000000000000001		#otherwise add 1 to s0
    
    # li $s1, 0 					#reset s1 to 0
	addi $s1, $zero, 0      # {6'b000010,5'b00000,5'b00011,16'd0}

	bne  $s0, $s6, loop		# {6'b010101,5'b01000,5'b00010,-16'd14}		# go back through loop with s1 = s1 + 1