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

    addi sp, sp , -28
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw s4, 16(sp)
    sw s5, 20(sp)
    mv s0, a0
    mv s1, a1

    li t6, 4
    li s4, 0
    li s5, 0  
    


loop_start:
    bge t1, a2, loop_end
    # TODO: Add your own implementation
    lw t2, 0(s0)
    lw t3, 0(s1)
    li t4, 0
mul1:
    bge t4, t3, next
    add t0, t0, t2
    addi t4, t4, 1
    j mul1
next:
#s4 s5 = index
    addi t1, t1, 1
    add s4, s4, a3
    add s5, s5, a4
    li t5, 0
    li s2, 0
    li s3, 0

addr:    #*4
    bge t5 , t6, next2
    addi t5, t5, 1
    add s2 , s2, s4
    add s3 , s3, s5
    j addr


next2:
    add s0, a0, s2
    add s1, a1, s3
    

    j loop_start 


loop_end:
    mv a0, t0
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw s4, 16(sp)
    lw s5, 20(sp)
    addi sp, sp , 28
    
    jr ra

error_terminate:
    blt a2, t0, set_error_36
    li a0, 37
    j exit

set_error_36:
    li a0, 36
    j exit