.globl dot

.text
# =======================================================
# FUNCTION: Strided Dot Product Calculator
#
# Calculates sum(arr0[i * stride0] * arr1[i * stride1])
# where i ranges from 0 to (element_count - 1)
#
# Args:
#   a0 (int *): Pointer to first input array
#   a1 (int *): Pointer to second input array
#   a2 (int):   Number of elements to process
#   a3 (int):   Skip distance in first array
#   a4 (int):   Skip distance in second array
#
# Returns:
#   a0 (int):   Resulting dot product value
#
# Preconditions:
#   - Element count must be positive (>= 1)
#   - Both strides must be positive (>= 1)
#
# Error Handling:
#   - Exits with code 36 if element count < 1
#   - Exits with code 37 if any stride < 1
# =======================================================
dot:
    li t0, 1
    blt a2, t0, error_terminate  
    blt a3, t0, error_terminate   
    blt a4, t0, error_terminate  

    li t0, 0            
    li t1, 0     


    addi sp, sp , -8
    sw s0, 0(sp)
    sw s1, 4(sp)
    mv s0, a0
    mv s1, a1




loop_start:
    bge t1, a2, loop_end
    # TODO: Add your own implementation
    lw t2, 0(s0)
    lw t3, 0(s1)
    li t4, 0
mul1:
    bge t4, t3, next
    add t0, t0, t2
    j mul1


next:
    addi t1, t1, 1
    addi s0, s0, 4
    addi s1, s1, 4
    j loop_start 


loop_end:
    mv a0, t0
    lw s0, 0(sp)
    lw s1, 4(sp)
    addi sp, sp , 8
    
    jr ra

error_terminate:
    blt a2, t0, set_error_36
    li a0, 37
    j exit

set_error_36:
    li a0, 36
    j exit