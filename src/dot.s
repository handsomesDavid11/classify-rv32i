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
    addi sp, sp, -8
    sw s0, 0(sp)
    sw s1, 4(sp)
    


loop_start:
    bge t1, a2, loop_end
    # TODO: Add your own implementation
    lw t2, 0(a0)
    lw t3, 0(a1)

    li t5, 0
    # detect negative
    slt s0, t2, x0
    slt s1, t3, x0
    beq s0, x0, pos1
    # t2 = -t2
    sub t2, x0, t2
pos1: 
    beq s1, x0, mul_loop
    # t3 = -t3
    sub t3, x0, t3
mul_loop:
    # Booth's Algorithm
    beq t3, x0, mul_end
    andi t4, t3, 1
    beq t4, x0, mul_cont
    add t5, t5, t2
mul_cont:
    slli t2, t2, 1
    srli t3, t3, 1
    j mul_loop
mul_end:
    beq s0, s1, mul_finish
    sub t5, x0, t5
mul_finish:
    add t0, t0, t5
    addi t1, t1, 1
    slli t4, a3, 2
    slli t5, a4, 2
    add a0, a0, t4
    add a1, a1, t5
    j loop_start
    

loop_end:
    lw s0, 0(sp)
    lw s1, 4(sp)
    addi sp, sp, 8

    mv a0, t0
    jr ra

error_terminate:
    blt a2, t0, set_error_36
    li a0, 37
    j exit

set_error_36:
    li a0, 36
    j exit
