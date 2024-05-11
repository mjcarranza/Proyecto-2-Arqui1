.arch armv7-a
.fpu vfpv3
.eabi_attribute 67, "2.09"  @ EABI version 2.09
.eabi_attribute 6, 10       @ Hard float ABI

.section .data
    data_file: .asciz "data.txt"

    .align 1
    buffer_reader: .space 800   @ Espacio en memoria para almacenar 100 en ASCII
    screen: .space 80000        @ Espacio en memoria para representar 100 caracteres con 100 bits (matriz de 10 x 10)

.section .text
.globl _start

_start:
    @ Abrir el archivo

    mov r7, #0x5                @ r7: Codigo de la llamada al sistema para abrir
    ldr r0, =data_file          @ r0: Nombre del archivo
    mov r1, #2                  @ r1: Configuracion para abrir
    mov r2, #0                  @ r2: Configuracion para abrir
    swi 0                       @ Llamada al sistema

_read:
    @ Leer el archivo

    mov r7, #0x3                @ r7: Codigo de la llamada al sistema para leer
    ldr r1, =buffer_reader      @ r1: Buffer que guarda el contenido
    ldr r2, =#800               @ r2: Cantidad de bytes para leer
    swi 0                       @ Llamada al sistema 

_registers:
    @ Registros con un unico proposito

    ldr r12, =buffer_reader     @ r12: Posicion en memoria del buffer_reader
    ldr r11, =screen            @ r11: Posicion en memoria de la letra
    mov r10, #1

_stepsHandler:
    ldr r4, [r12]               @ r4:8 bits del contenido del buffer_reader
    ldr r0, =#0x000000FF        @ r0: Mascara para tomar el primer byte de r4
    and r4, r4, r0              @ r4: ASCII de un caracter

    cmp r10, #1
    beq _stepI
    cmp r10, #2
    beq _stepII
    cmp r10, #3
    beq _stepIII
    cmp r10, #4
    beq _stepIV
    cmp r10, #5
    beq _stepV
    cmp r10, #6
    beq _stepVI
    cmp r10, #7
    beq _restartSteps

_stepI:
    cmp r4, #0
    beq _exit

    add r10, r10, #1

    mov r0, #2                  
    mov r1, #2                  
    mov r2, #2                  
    mov r3, #10

    cmp r4, #0x41              @ A
    beq _bresenham
    cmp r4, #0x42              @ B
    beq _bresenham
    cmp r4, #0x43              @ C
    beq _bresenham
    cmp r4, #0x44              @ D
    beq _bresenham
    cmp r4, #0x45              @ E
    beq _bresenham
    cmp r4, #0x46              @ F
    beq _bresenham                 
    cmp r4, #0x47              @ G
    beq _bresenham
    cmp r4, #0x48              @ H
    beq _bresenham
    cmp r4, #0x4b              @ K
    beq _bresenham
    cmp r4, #0x4c              @ L
    beq _bresenham
    cmp r4, #0x4d              @ M
    beq _bresenham
    cmp r4, #0x4e              @ N
    beq _bresenham
    cmp r4, #0x4f              @ O
    beq _bresenham
    cmp r4, #0x50              @ P
    beq _bresenham
    cmp r4, #0x51              @ Q
    beq _bresenham
    cmp r4, #0x52              @ R
    beq _bresenham
    cmp r4, #0x55              @ U
    beq _bresenham
    cmp r4, #0x57              @ W
    beq _bresenham
    
    mov r0, #2                  
    mov r1, #2 
    mov r2, #6                  
    mov r3, #2

    cmp r4, #0x4a              @ J
    beq _bresenham  

    mov r0, #2                  
    mov r1, #6                  
    mov r2, #2                  
    mov r3, #10  

    cmp r4, #0x53              @ S
    beq _bresenham

    mov r0, #2
    mov r1, #10                  
    mov r2, #6                  
    mov r3, #2
    
    cmp r4, #0x56              @ V
    beq _bresenham

    mov r0, #2
    mov r1, #10                  
    mov r2, #6             
    mov r3, #6
 
    cmp r4, #0x59              @ Y
    beq _bresenham

    mov r0, #2
    mov r1, #1                  
    mov r2, #3                  
    mov r3, #2

    cmp r4, #0x2c              @ ,
    beq _bresenham

    mov r0, #2
    mov r1, #2                  
    mov r2, #2 
    mov r3, #2

    cmp r4, #0x2e              @ .
    beq _bresenham

_stepII:
    add r10, r10, #1

    mov r0, #2                  
    mov r1, #10                  
    mov r2, #10                  
    mov r3, #10

    cmp r4, #0x41              @ A
    beq _bresenham
    cmp r4, #0x43              @ C
    beq _bresenham
    cmp r4, #0x45              @ E
    beq _bresenham
    cmp r4, #0x46              @ F
    beq _bresenham
    cmp r4, #0x47              @ G
    beq _bresenham
    cmp r4, #0x49              @ I
    beq _bresenham
    cmp r4, #0x4a              @ J
    beq _bresenham
    cmp r4, #0x4d              @ M
    beq _bresenham
    cmp r4, #0x4f              @ O
    beq _bresenham
    cmp r4, #0x50              @ P
    beq _bresenham
    cmp r4, #0x51              @ Q
    beq _bresenham
    cmp r4, #0x52              @ R
    beq _bresenham
    cmp r4, #0x53              @ S
    beq _bresenham
    cmp r4, #0x54              @ T
    beq _bresenham
    cmp r4, #0x5a              @ Z
    beq _bresenham

    mov r0, #2                  
    mov r1, #10 
    mov r2, #9                  
    mov r3, #10

    cmp r4, #0x42              @ B
    beq _bresenham

    mov r0, #2                  
    mov r1, #10                  
    mov r2, #10                  
    mov r3, #9

    cmp r4, #0x44              @ D
    beq _bresenham

    mov r0, #2                  
    mov r1, #6                  
    mov r2, #10                  
    mov r3, #2
    
    cmp r4, #0x4b              @ K
    beq _bresenham

    mov r0, #2                  
    mov r1, #10                  
    mov r2, #10                  
    mov r3, #2    
    
    cmp r4, #0x4e              @ N
    beq _bresenham
    cmp r4, #0x58              @ X
    beq _bresenham

    mov r0, #6                  
    mov r1, #2                  
    mov r2, #10                  
    mov r3, #10
 
    cmp r4, #0x56              @ V
    beq _bresenham

    mov r0, #6                  
    mov r1, #6                  
    mov r2, #10                  
    mov r3, #10

    cmp r4, #0x59              @ Y
    beq _bresenham

_stepIII:
    add r10, r10, #1

    mov r0, #2                  
    mov r1, #2                  
    mov r2, #10                  
    mov r3, #2

    cmp r4, #0x42              @ B
    beq _bresenham
    cmp r4, #0x43              @ C
    beq _bresenham
    cmp r4, #0x45              @ E
    beq _bresenham
    cmp r4, #0x47              @ G
    beq _bresenham
    cmp r4, #0x49              @ I
    beq _bresenham
    cmp r4, #0x4c              @ L
    beq _bresenham
    cmp r4, #0x4f              @ O
    beq _bresenham
    cmp r4, #0x51              @ Q
    beq _bresenham
    cmp r4, #0x53              @ S
    beq _bresenham
    cmp r4, #0x55              @ U
    beq _bresenham
    cmp r4, #0x57              @ W
    beq _bresenham
    cmp r4, #0x5a              @ Z
    beq _bresenham

    mov r0, #2                  
    mov r1, #2                  
    mov r2, #10                  
    mov r3, #3

    cmp r4, #0x44              @ D
    beq _bresenham

    mov r0, #2                  
    mov r1, #6                  
    mov r2, #10                  
    mov r3, #10

    cmp r4, #0x4b              @ K
    beq _bresenham

    mov r0, #10                  
    mov r1, #6                  
    mov r2, #10                  
    mov r3, #10

    cmp r4, #0x50              @ P
    beq _bresenham
    cmp r4, #0x52              @ R
    beq _bresenham

    mov r0, #6                  
    mov r1, #2                  
    mov r2, #6                  
    mov r3, #6

    cmp r4, #0x59              @ Y
    beq _bresenham

_stepIV:
    add r10, r10, #1

    mov r0, #2                  
    mov r1, #6                  
    mov r2, #10                  
    mov r3, #6

    cmp r4, #0x41              @ A
    beq _bresenham
    cmp r4, #0x42              @ B
    beq _bresenham
    cmp r4, #0x45              @ E
    beq _bresenham
    cmp r4, #0x46              @ F
    beq _bresenham
    cmp r4, #0x48              @ H
    beq _bresenham
    cmp r4, #0x50              @ P
    beq _bresenham
    cmp r4, #0x52              @ R
    beq _bresenham
    cmp r4, #0x53              @ S
    beq _bresenham

    mov r0, #10                  
    mov r1, #3                  
    mov r2, #10                  
    mov r3, #9

    cmp r4, #0x44              @ D
    beq _bresenham

    mov r0, #6                  
    mov r1, #6                 
    mov r2, #10                  
    mov r3, #6

    cmp r4, #0x47              @ G
    beq _bresenham

    mov r0, #6                  
    mov r1, #2                  
    mov r2, #6                  
    mov r3, #10

    cmp r4, #0x49              @ I
    beq _bresenham
    cmp r4, #0x4a              @ J
    beq _bresenham
    cmp r4, #0x4d              @ M
    beq _bresenham
    cmp r4, #0x54              @ T
    beq _bresenham
    cmp r4, #0x57              @ W
    beq _bresenham

    mov r0, #8                  
    mov r1, #3                  
    mov r2, #9                  
    mov r3, #1

    cmp r4, #0x51              @ Q
    beq _bresenham

    mov r0, #2                 
    mov r1, #2                  
    mov r2, #10                  
    mov r3, #10

    cmp r4, #0x58              @ X
    beq _bresenham
    cmp r4, #0x5a              @ Z
    beq _bresenham
    
_stepV:
    add r10, r10, #1

    mov r0, #10                 
    mov r1, #2                  
    mov r2, #10                  
    mov r3, #10

    cmp r4, #0x41              @ A
    beq _bresenham
    cmp r4, #0x48              @ H
    beq _bresenham
    cmp r4, #0x4d              @ M
    beq _bresenham
    cmp r4, #0x4e              @ N
    beq _bresenham
    cmp r4, #0x4f              @ O
    beq _bresenham
    cmp r4, #0x51              @ Q
    beq _bresenham
    cmp r4, #0x55              @ U
    beq _bresenham
    cmp r4, #0x57              @ W
    beq _bresenham

    mov r0, #10                 
    mov r1, #2                  
    mov r2, #10                  
    mov r3, #6

    cmp r4, #0x42              @ B
    beq _bresenham
    cmp r4, #0x47              @ G
    beq _bresenham
    cmp r4, #0x53              @ S
    beq _bresenham

    mov r0, #8                 
    mov r1, #6                  
    mov r2, #10                  
    mov r3, #2

    cmp r4, #0x52              @ R
    beq _bresenham

_stepVI:
    add r10, r10, #1

    mov r0, #9                 
    mov r1, #6                  
    mov r2, #9                  
    mov r3, #10

    cmp r4, #0x42              @ B
    beq _bresenham

_restartSteps:
    add r12, r12, #1            @ r12: Corriemiento de 1 bytes de la posicion en memoria del buffer_reader
    add r11, r11 , #100
    mov r10, #1
    b _stepsHandler

_bresenham:
    sub r2, r2, r0              @ r2: dx = x2 - x1
    sub r3, r3, r1              @ r3: dy = y2 - y1
    mov r4, #1                  @ r4: ++ (aumento en la direcion de y)

    cmp r3, #0                  
    bge _bresenham2             @ Salta si dy es positivo

    @ angulo negativo 
    lsl r4, r3, #1              @ r4: 2*dy
    sub r3, r3, r4              @ r3: dy = dy - 2dy = -dy 
    mov r4, #-1                 @ r4: -- (decremento en la direcion de y)

_bresenham2:
    sub r5, r2, r3              @ r5: dx - dy
    cmp r5, #0
    mov r5, #0
    bge _bresenham3             @ Salta si r5 es positivo

    @ angulo mayor a 45°
    mov r5, #1

@ r0: x
@ r1: y
@ r2: dx
@ r3: dy
@ r4: y++/y--
@ r5: invercion de x,y
@ r6: p
@ r7: Contador
_bresenham3:
    cmp r5, #0
    beq _bresenham3A
    b _bresenham3B

_bresenham3A:
    lsl r6, r3, #1              @ r6: 2*dy
    sub r6, r6, r2              @ r6: p = 2*dy - dx
    add r7, r2, #1              @ r7: dx + 1 (contador)
    b _bresenhamWhile

_bresenham3B:
    lsl r6, r2, #1              @ r6: 2*dx
    sub r6, r6, r3              @ r6: p = 2*dx - dy
    add r7, r3, #1              @ r7: dy + 1 (contador)
    b _bresenhamWhile

_bresenhamWhile:
    sub r7, r7, #1              @ r7: r7--
    b _addPixel

_bresenhamWhile2:
    cmp r7, #0
    beq _stepsHandler

    cmp r5, #0
    beq _bresenhamWhile2A
    b _bresenhamWhile2B

_bresenhamWhile2A:
    add r0, r0, #1              @ x++
    lsl r8, r3, #1              @ r8: 2*dy
    lsl r9, r2, #1              @ r9: 2*dx
    b _bresenhamWhile3

_bresenhamWhile2B:
    add r1, r1, r4              @ y++/y--
    lsl r8, r2, #1              @ r8: 2*dx
    lsl r9, r3, #1              @ r9: 2*dy
    b _bresenhamWhile3

_bresenhamWhile3:
    cmp r6, #0
    add r6, r6, r8              @ r6: p = p + r8
    bge _bresenhamElse
    b _bresenhamWhile
    
_bresenhamElse:
    sub r6, r6, r9
    cmp r5, #0
    beq _bresenhamElseA
    b _bresenhamElseB

_bresenhamElseA:
    add r1, r1, r4
    b _bresenhamWhile

_bresenhamElseB:
    add r0, r0, #1
    b _bresenhamWhile

_addPixel:
    mov r8, #10                 @ r8: 10
    sub r8, r8, r1              @ r8: 10 - y (contador)
    sub r9, r0, #1              @ r9: x - 1

_addPixel2:
    cmp r8, #0
    beq _addPixel3 
    add r9, r9, #10             @ r9: r9 + 10
    sub r8, r8, #1              @ r8: r8 - 1
    b _addPixel2  

_addPixel3:
    add r8, r11, r9             @ r8: Posicion en memoria de la letra + r9 
    ldr r9, [r8]  
    orr r9, r9, #1              
    str r9, [r8]                @ Se almacena un 1 en memoria para representar un pixel negro
    b _bresenhamWhile2
    
_exit:
    @ Salir del programa

    mov r7, #0x1                @ r7: Codigo de la llamada al sistema para salir
    mov r0, #0                  @ r0: Codigo de salida
    swi 0                       @ Llamada al sistema
