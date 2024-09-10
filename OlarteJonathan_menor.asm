.data
    msg_cantidad:    .asciiz "Ingrese la cantidad de numeros a comparar (3-5): "
    msg_ingrese:     .asciiz "Ingrese el numero "
    msg_dos_puntos:  .asciiz ": "
    msg_resultado:   .asciiz "El numero menor es: "
    msg_error:       .asciiz "Error: La cantidad debe estar entre 3 y 5.\n"
    nueva_linea:     .asciiz "\n"
    numeros:         .word 0, 0, 0, 0, 0  # Espacio para hasta 5 números

.text
    # Pedir la cantidad de números
    li $v0, 4
    la $a0, msg_cantidad
    syscall

    # Leer la cantidad
    li $v0, 5
    syscall
    move $s0, $v0  # $s0 = cantidad

    # Verificar que la cantidad esté entre 3 y 5
    blt $s0, 3, error_cantidad
    bgt $s0, 5, error_cantidad

    # Leer los números
    li $t0, 0  # Contador
    la $t1, numeros  # Dirección base del array

leer_numeros:
    # Imprimir mensaje "Ingrese el numero X: "
    li $v0, 4
    la $a0, msg_ingrese
    syscall

    li $v0, 1
    addi $a0, $t0, 1
    syscall

    li $v0, 4
    la $a0, msg_dos_puntos
    syscall

    # Leer número
    li $v0, 5
    syscall

    # Guardar número en el array
    sw $v0, ($t1)

    # Incrementar contador y dirección
    addi $t0, $t0, 1
    addi $t1, $t1, 4

    # Verificar si hemos leído todos los números
    blt $t0, $s0, leer_numeros

    # Encontrar el menor
    la $t1, numeros
    lw $t2, ($t1)  # $t2 = menor actual
    li $t0, 1  # Contador

encontrar_menor:
    addi $t1, $t1, 4
    lw $t3, ($t1)
    blt $t3, $t2, actualizar_menor # blt Ramificar si es Menor o Igual (Ramificar si es Menor o Igual)
    j siguiente_numero

actualizar_menor:
    move $t2, $t3

siguiente_numero:
    addi $t0, $t0, 1
    blt $t0, $s0, encontrar_menor

    # Imprimir resultado
    li $v0, 4
    la $a0, msg_resultado
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    j fin

error_cantidad:
    li $v0, 4
    la $a0, msg_error
    syscall

fin:
    # Imprimir nueva línea
    li $v0, 4
    la $a0, nueva_linea
    syscall

    # Terminar programa
    li $v0, 10
    syscall