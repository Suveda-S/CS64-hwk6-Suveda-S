# swap_case.asm program
# For CMPSC 64
#
# Data Area
.data
    buffer:         .space 100
    input_prompt:   .asciiz "Enter string:\n"
    output_prompt:  .asciiz "Output:\n"
    convention:     .asciiz "Convention Check\n"
    newline:        .asciiz "\n"

.text

#
# DO NOT MODIFY THE MAIN PROGRAM 
#       OR ANY OF THE CODE BELOW, WITH 1 EXCEPTION!!!
# YOU SHOULD ONLY MODIFY THE SwapCase FUNCTION 
#       AT THE BOTTOM OF THIS CODE
#
main:
    la $a0, input_prompt    # prompt user for string input
    li $v0, 4
    syscall

    li $v0, 8       # take in input
    la $a0, buffer
    li $a1, 100
    syscall
    move $s0, $a0   # save string to s0

    li $s1, 0
    li $s2, 0
    li $s3, 0
    li $s4, 0
    li $s5, 0
    li $s6, 0
    li $s7, 0

    move $a0, $s0
    jal SwapCase

    add $s1, $s1, $s2
    add $s1, $s1, $s3
    add $s1, $s1, $s4
    add $s1, $s1, $s5
    add $s1, $s1, $s6
    add $s1, $s1, $s7
    add $s0, $s0, $s1

    la $a0, output_prompt    # give Output prompt
    li $v0, 4
    syscall

    move $a0, $s0
    jal DispString

    j Exit

DispString:
    addi $a0, $a0, 0
    li $v0, 4
    syscall
    jr $ra

ConventionCheck:
    addi    $t0, $zero, -1
    addi    $t1, $zero, -1
    addi    $t2, $zero, -1
    addi    $t3, $zero, -1
    addi    $t4, $zero, -1
    addi    $t5, $zero, -1
    addi    $t6, $zero, -1
    addi    $t7, $zero, -1
    ori     $v0, $zero, 4
    la      $a0, convention
    syscall
    addi    $v0, $zero, -1
    addi    $v1, $zero, -1
    addi    $a0, $zero, -1
    addi    $a1, $zero, -1
    addi    $a2, $zero, -1
    addi    $a3, $zero, -1
    addi    $k0, $zero, -1
    addi    $k1, $zero, -1
    jr      $ra
    
Exit:
    li $v0, 10
    syscall

# COPYFROMHERE - DO NOT REMOVE THIS LINE

# YOU CAN ONLY MODIFY THIS FILE FROM THIS POINT ONWARDS:
SwapCase:
    #TODO: write your code here, $a0 stores the address of the string
    
    
    la $t3, 0($a0)
    addiu $sp, $sp, -4
    sw $a0, 0($sp)
StringLoop:
    lb $t0, 0($t3)
    beq $t0, $zero, endloop
    
    #in asciiz 65 is A, 90 is Z, 97 is a, 122 is z
    slti $t1, $t0, 91
    slti $t2, $t0, 65
    bne $t1, $t2, isUpper

    slti $t1, $t0, 123
    slti $t2, $t0, 97
    bne $t1, $t2, isLetter

    j endround

isUpper:
    #if t4 is 1 its a upper case, if its 0, its a lower case
    li $t4, 1

isLetter:

    lb $a0, 0($t3)
    li $v0, 11
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    bne $t4, $zero, UpperPrint
    lb $t0, 0($t3)
    addi $t0, $t0, -32
    sb $t0, 0($t3)
    lb $a0, 0($t3)
    li $v0, 11
    syscall

    la $a0, newline
    li $v0, 4
    syscall


    j CallCheck

UpperPrint:
    lb $t0, 0($t3)
    addi $t0, $t0, 32
    sb $t0, 0($t3)
    lb $a0, 0($t3)
    li $v0, 11
    syscall

    la $a0, newline
    li $v0, 4
    syscall


CallCheck:
    addiu $sp, $sp, -12
    sw $ra, 0($sp)
    sw $t3, 4($sp)
    sw $t4, 8($sp)
    jal ConventionCheck
    lw $ra, 0($sp)
    lw $t3, 4($sp)
    lw $t4, 8($sp)
    addiu $sp, $sp, 12

endround:
    addi $t3, $t3, 1
    li $t4, 0
    j StringLoop

endloop:
    # Do not remove the "jr $ra" line below!!!
    # It should be the last line in your function code!
    lw $a0, 0($sp)
    addiu $sp, $sp, 4
    
    jr $ra

    