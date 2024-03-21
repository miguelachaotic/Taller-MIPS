.data
	
	v0:		.word 1, 2, 3 			# Media = 2
	v1: 		.word 4, 5, 6, 7		# Media = 5
	v2:		.word 8, 9			# Media = 8
	v3:		.word 1				# Media = 0
								# Media de todos = 3
								
	respuesta: .ascii "El resultado es: \0"
								
.text


main:
	la $a0, v0
	la $a1, v1
	la $a2, v2
	la $a3, v3
	
	jal media4
	
	move $s0, $v0
	
	li $v0, 4
	la $a0, respuesta
	syscall
	
	
	li $v0, 1
	move $a0, $s0
	syscall
	

	li $v0, 10
	syscall
	
	
	
	
	
	
	
media4:
	addi $sp, $sp, -4
	sw $ra, 0($sp)				# Guardamos el punto de retorno
	
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	move $s3, $a3
	
	li $a1, 3
	
	addi $sp, $sp, -16 			# Decrementamos el puntero de pila para introducir enteros
	sw $s0, 12($sp)
	sw $s1, 8($sp)
	sw $s2, 4($sp)
	sw $s3, 0($sp)
	
	jal media					# Llamamos a la función media
	
	move $s0, $v0
	
	lw $a0, 8($sp)
	li $a1, 4
	
	sw $s0, 12($sp)
	
	jal media
	
	lw $s0, 12($sp)
	add $s0, $s0, $v0
	
	lw $a0, 4($sp)
	li $a1, 2
	
	sw $s0, 12($sp)
	
	jal media
	
	lw $s0, 12($sp)
	add $s0, $s0, $v0
	
	lw $a0, 0($sp)
	li $a1, 1
	
	sw $s0, 12($sp)
	
	jal media
	
	lw $s0, 12($sp)
	add $s0, $s0, $v0
	
	li $t0, 4
	div $s0, $t0
	mflo $v0
	
	addi $sp, $sp, 16
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	


# media recibe en $a0 el inicio de la cadena del vector y en $a1 el tamaño del array
media:
	li $s0, 0 	# Acumulador
	li $s1, 0		# Índice del bucle
	move $s2, $a1
bucleMedia:
	beq $s1, $s2, finMedia 		# Si el indice es igual al numero de iteraciones salimos
	sll $t0, $s1, 2			# Multiplicamos por 4			
	add $t0, $t0, $a0			# Calculamos la dirección de memoria
	lw $t0, 0($t0)				# Obtenemos el elemento del vector
	add $s0, $s0, $t0			# Añadimos al acumulador
	addi $s1, $s1, 1			# Incrementamos índice
	j bucleMedia
finMedia:
	div $s0, $s2
	mflo	$v0
	jr $ra


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
