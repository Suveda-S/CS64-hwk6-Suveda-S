# print_array.asm program
# For CMPSC 64
#
# Don't forget to:
#   make all arguments to any function go in $a0, $a1
#   make all returned values from functions go in $v0

# Example array and alen - your code should work for any integer array of any length > 1.
.data
    array:  .word 6, 4, 0, 1, 2, 9, 3, 5, 8, 7
    alen:   .word 10
    newline: .asciiz "\n"
    space:  .asciiz " "

.text

bubble:
    lw $t0, 0($a1)
    addi $t0, $t0, -1
    j loopone
looponecounter:
    addi $t0, $t0, -1
loopone:
    blt $t0, $zero, looponeend
    li $t1, 1
    j looptwo
looptwocounter:
    addi $t1, $t1, 1
looptwo:
    bgt $t1, $t0, looponecounter
bubbleif:
    sll $t2, $t1, 2
    addu $t2, $a0, $t2 
    
    addi $t3, $t2, -4
    lw $t4, 0($t3)
    lw $t5, 0($t2)
    ble $t4, $t5, looptwocounter
    sw $t5, 0($t3)
    sw $t4, 0($t2)
    j looptwocounter
    
looponeend:
    jr $ra


printArray:
	# $a0 is array address, $a1 is its size address $t0 is i
    li $t0, 0
    lw $a1, 0($a1)

printloop:
    bge $t0, $a1, exitprint
    sll $t1, $t0, 2
    addu $t1, $t1, $a0

    move $t2, $a0

    lw $a0, 0($t1)
    li $v0, 1
    syscall

    la $a0, space
    li $v0, 4
    syscall

    move $a0, $t2
    addi $t0, $t0, 1
    j printloop

exitprint:
    la $a0, newline
    li $v0, 4
    syscall
    jr $ra
    
main:
    la $a0, array
    la $a1, alen
    jal printArray

    la $a0, array
    la $a1, alen
    jal bubble

    la $a0, array
    la $a1, alen
    jal printArray

    li $v0, 10
    syscall	