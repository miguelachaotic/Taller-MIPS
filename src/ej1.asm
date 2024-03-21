.data

	vector: 			.word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
	
	fraseInput1:		.asciiz "Introduce un número entero positivo: "
	
	fraseBucle: 		.asciiz "Introduce un número entero: "
	
	fraseResultado:	.asciiz "La media de todos los números introducidos es: "
	
	fraseError:		.asciiz "Tienes que introducir un entero positivo!!!"
	
.text

main:
	# Primero preguntamos al usuario cuantos enteros va a leer de pantalla
	
	li $v0, 4
	la $a0, fraseInput1
	syscall
	# Ahora recibimos un número entero por teclado
	
	li $v0, 5
	syscall
	
	slt $t0, $zero, $v0		# Si $zero es menor estricto a $v0 pone un 1 en $t0.
	beq $t0, $zero, error
	
	move $s0, $v0
	li $s1, 0		# Índice que nos llevará la cuenta de cuantos enteros hemos leído
	li $s2, 0		# $s2 va a hacer de acumulador. Cuando leamos un entero lo sumamos en $s2
bucleInput:
	beq $s1, $s0, salidaBucleInput
	
	li $v0, 4
	la $a0, fraseBucle
	syscall			# Imprimimos la pregunta
	
	li $v0, 5
	syscall			# Recibimos el entero en $v0
	
	add $s2, $s2, $v0	# Lo sumamos al acumulador
	
	addi $s1, $s1, 1	# Incrementamos índice
	j bucleInput		# Volvemos al inicio del bucle
salidaBucleInput:
	
	# Ahora tenemos que leer del vector. $s1 sigue siendo necesario porque necesitamos saber el número total de numeros que se han sumado
	
	addi $s1, $s1, 10	# Añadimos a $s1 el tamaño del vector
	li $s0, 10
	li $s3, 0
	la $s4, vector		# Cargamos la dirección del vector
bucleVector:
	
	beq $s0, $s3, salidaBucleVector
	sll $t0, $s3, 2		# Multiplicamos por 4 el índice
	add $t0, $t0, $s4		# Obtenemos la dirección del siguiente elemento en el vector
	lw $t0, 0($t0)			# Obtenemos el entero en esa posición de memoria
	add $s2, $s2, $t0		# Lo sumamos al acumulador
	
	addi $s3, $s3, 1		# Aumentamos el índice
	j bucleVector
salidaBucleVector:

	div $s2, $s1			# Calculamos la media
	mflo $s1				# Obtenemos el resultado de la media

	li $v0, 4
	la $a0, fraseResultado
	syscall				# Imprimimos el mensaje de resultado
	
	li $v0, 1
	move $a0, $s1
	syscall				# Imprimimos el número
	
fin:
	li $v0, 10
	syscall				# Termina el programa

error:
	li $v0, 4
	la $a0, fraseError
	syscall
	
	j fin


	
