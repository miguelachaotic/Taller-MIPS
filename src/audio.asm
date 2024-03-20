.data 												
	notas: 			.byte 60, 62, 65, 62, 69, 69, 67,								
	 	     	      	 60, 62, 65, 62, 67, 67, 65, 64, 62						
	 	     	      	 60, 62, 65, 62, 65, 67, 64, 62, 60, 60, 60, 67, 65,		
	 	     	      	 60, 62, 65, 62, 69, 69, 67,								
	 	     	      	 60, 62, 65, 62, 72, 64, 65, 64, 62
	 	     	      	 60, 62, 65, 62, 65, 67, 64, 62, 60, 60, 60, 67, 65
	 	  
	 	  
	duraciones: 		.word 100, 100, 100, 100, 300, 300, 600, 							# 7 notas
			      	 	 100, 100, 100, 100, 300, 300, 300, 100, 200						# 9
			      	 	 100, 100, 100, 100, 400, 200, 300, 100, 200, 200, 200, 400, 800,	# 13
			      	 	 100, 100, 100, 100, 300, 300, 600,							# 7
			      	 	 100, 100, 100, 100, 400, 200, 300, 100, 200,					# 9
			      	 	 100, 100, 100, 100, 400, 200, 300, 100, 200, 200, 200, 400, 800		# 13
			      			      
	total: 			.word 58
	
	userString: 		.asciiz "Introduce el número de iteraciones:"

     instrumentString:   .asciiz "Introduce el instrumento:"
	
	
.text
	li $s1, 0		 			# índice del bucle for exterior (número de veces que se ejecutará el programa)
	la $a0, userString
	li $v0, 51
	syscall
	bnez $a1, salida
	add $s4, $a0, $zero     
     la $a0, instrumentString   
     syscall
     bnez $a1, salida
     add $a2, $a0, $zero
	li $a3, 127
	la $at, total
	lw $s3, 0($at) 			# Cargo en $s3 el número de enteros que hay que leer
	la $s7, notas				# Cargamos en $s7 la dirección del vector notas	
	la $s6, duraciones			# Cargamos en $s6 la dirección del vector duraciones
bucleExterior:
	beq $s1, $s4, salida 		# Si hemos llegado al final del bucle salimos del programa
	li $s2, 0					# indice que controla la posición de memoria del vector de arriba
bucleInterior:
	beq $s2, $s3, salidaBucleInterior
	add $t0, $s7, $s2 			# $t0 va a guardar la dirección de memoria i-ésima del vector notas
	sll $t2, $s2, 2			# Multiplicamos $s2 por 4 y lo guardamos en $t2
	add $t1, $s6, $t2			# $t1 va a guardar la dirección de memoria i-ésima del vector duraciones
	lw $s0, 0($t1)				# Guardamos en $s0 la duración de una nota
	lb $s5, 0($t0)				# Guardamos en $s5 la nota
	add $a1, $s0, $zero			# Movemos $s0 a $a1 para hacer la syscall
	add $a0, $s5, $zero			# Movemos $s5 a $a0 para hacer la syscall
	li $v0, 33
	syscall
	addi $s2, $s2, 1
	j bucleInterior	
salidaBucleInterior:
	addi $s1, $s1, 1
	j bucleExterior
salida:
	li $v0, 10
	syscall
