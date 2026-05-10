# calculation.asm program
# For CMPSC 64
#
# Don't forget to:
#   make all arguments to any function go in $a-registers
#   make all returned values from functions go in $v0

.text
remove:
    # CODE MISSING: Student to complete this part

calc:
    # CODE MISSING: Student to complete this part
    
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
