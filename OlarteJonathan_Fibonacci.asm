.data
    msg_cantidad:    .asciiz "Ingrese la cantidad de numeros Fibonacci a generar: "
    msg_serie:       .asciiz "Serie Fibonacci: "
    msg_suma:        .asciiz "\nLa suma de la serie es: "
    coma:            .asciiz ", "
    nueva_linea:     .asciiz "\n"

.text
    # Pedir la cantidad de números
    li $v0, 4
    la $a0, msg_cantidad
    syscall

    # Leer la cantidad
    li $v0, 5
    syscall
    move $s0, $v0  # $s0 = cantidad

    # Inicializar variables
    li $t0, 0      # Primer número de Fibonacci
    li $t1, 1      # Segundo número de Fibonacci
    li $s1, 0      # Suma total
    li $t2, 0      # Contador

    # Imprimir mensaje de serie
    li $v0, 4
    la $a0, msg_serie
    syscall

loop:
    # Imprimir número actual
    li $v0, 1
    move $a0, $t0
    syscall

    # Sumar al total
    add $s1, $s1, $t0

    # Incrementar contador
    addi $t2, $t2, 1

    # Verificar si hemos terminado
    beq $t2, $s0, fin_serie

    # Imprimir coma y espacio
    li $v0, 4
    la $a0, coma
    syscall

    # Calcular siguiente número Fibonacci
    add $t3, $t0, $t1
    move $t0, $t1
    move $t1, $t3

    j loop

fin_serie:
    # Imprimir mensaje de suma
    li $v0, 4
    la $a0, msg_suma
    syscall

    # Imprimir suma total
    li $v0, 1
    move $a0, $s1
    syscall

    # Imprimir nueva línea
    li $v0, 4
    la $a0, nueva_linea
    syscall

    # Terminar programa
    li $v0, 10
    syscall