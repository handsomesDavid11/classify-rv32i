.globl relu

.text
# ==============================================================================
# FUNCTION: Array ReLU Activation
#
# Applies ReLU (Rectified Linear Unit) operation in-place:
# For each element x in array: x = max(0, x)
#
# Arguments:
#   a0: Pointer to integer array to be modified
#   a1: Number of elements in array
#
# Returns:
#   None - Original array is modified directly
#
# Validation:
#   Requires non-empty array (length ≥ 1)
#   Terminates (code 36) if validation fails
#
# Example:
#   Input:  [-2, 0, 3, -1, 5]
#   Result: [ 0, 0, 3,  0, 5]
# ==============================================================================
relu:
    li t0, 1            #index counter      
    blt a1, t0, error     
    li t1, 0            #zero register
    addi t3, a0, 0x0
loop_start:
    # TODO: Add your own implementation
    bge t0, a1, end1
    lw t2 , 0(t3)
    blt t2,t1,set_zero
    j next1

set_zero:
    sw t2 , 0(a0)



next1:
    addi t3, t3, 4
    addi t0, t0, 1
    j loop_start

end1:
    j exit

error:
    li a0, 36          
    j exit          
