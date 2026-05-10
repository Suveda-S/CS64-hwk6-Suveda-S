# calculation.asm program
# For CMPSC 64
#
# Don't forget to:
#   make all arguments to any function go in $a-registers
#   make all returned values from functions go in $v0

.text
remove:
    sub $v0, $a1, $a0
    jr $ra

calc:
    li $t1, 5
    li $t0, 0

calcloop:
    bge $t0, $a2, endcalc
    sll $t2, $a1, 1
    add $t1, $t2, $t1
    sub $t1, $t1, $a0

    li $t2, 2
    blt $a0, $t2, calciffalse

    addiu $sp, $sp, -12
    sw $a0, 0($sp)
    sw $a1, 4($sp)
    sw $ra, 8($sp)

    jal remove

    lw $a0, 0($sp)
    lw $a1, 4($sp)
    lw $ra, 8($sp)
    addiu $sp, $sp, 12

    move $a1, $v0


calciffalse:
    addi $a0, $a0, 1
    addi $t0, $t0, 1
    j calcloop
    
endcalc:
    move $v0, $t1
    jr $ra
    
main:  # DO NOT MODIFY THE MAIN SECTION
    li $a0, 4
    li $a1, 10
    li $a2, 3

    jal calc

    move $a0, $v0
    li $v0, 1
    syscall

    li $v0, 10
    syscall
