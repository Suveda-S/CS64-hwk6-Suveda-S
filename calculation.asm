# calculation.asm program
# For CMPSC 64
#
# Don't forget to:
#   make all arguments to any function go in $a-registers
#   make all returned values from functions go in $v0

.text
remove: #a0 is a and a1 is b
    sub $v0, $a1, $a0
    jr $ra

calc:
    li $t1, 5 #t1 is z
    li $t0, 0 #t0 is i

calcloop:
    bge $t0, $a2, endcalc #a2 is n
    #does z = z- x + 2y
    sll $t2, $a1, 1
    add $t1, $t2, $t1
    sub $t1, $t1, $a0

    li $t2, 2 #only need for comparison
    blt $a0, $t2, calciffalse

    #x, y, n, i, z, ra need to stay same through loops and calls 
    addiu $sp, $sp, -24
    sw $a0, 0($sp)
    sw $a1, 4($sp)
    sw $a2, 8($sp)
    sw $t0, 12($sp)
    sw $t1, 16($sp)
    sw $ra, 20($sp)

    jal remove

    lw $a0, 0($sp)
    lw $a1, 4($sp)
    lw $a2, 8($sp)
    lw $t0, 12($sp)
    lw $t1, 16($sp)
    lw $ra, 20($sp)
    addiu $sp, $sp, 24

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
