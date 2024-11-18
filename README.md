# Assignment 2: Classify
## Part A: Mathematical Functions
### Task 1: ReLU

ReLU sets each element of an array to zero if its value is negative. In my implementation:

* t0 is the index of the array.
* t3 holds the base address of the array.
* The element at the current index is loaded into the t2 register.

The instruction " blt t2, t1, set_zero " is used to determine whether the value in t2 is less than zero. If t2 is less than zero, the process jumps to the set_zero label to store zero into the array. Otherwise, the original value is stored back into the array.
Once the operation for the current element is complete, the process advances to the next element by incrementing the index (t0) and updating t3 to point to the address of the next element.

### Task 2: ArgMax

The ArgMax function returns the index of the largest element in a given vector. In my implementation:

* t0 temporarily stores the value of the largest element found so far.
* t3 stores the index of the largest element.
* t4 holds the current element being compared.

The instruction "bge t4, t0, change" is used to compare the current element t4 with the largest value t0. If t4 is greater than or equal to t0, the process jumps to the change label, where t0 is updated to store the value of t4,t3 is updated to store the current index t2.
After updating, the process continues to the next comparison.

### Task 3.1: Dot Product
In the first version, I didn't account for negative values. In the updated version, I use slt s0, t2, x0 to detect whether the value is negative. If t2 is negative, I convert it to positive using sub t2, x0, t2. This ensures that the calculations handle both positive and negative values correctly.

* The multiplication is done iteratively using bitwise operations (andi, slli, srli) instead of a direct multiply instruction (mul).
* If either t2 or t3 is negative, they are converted to their absolute values before multiplication.

### Task 3.2: Matrix Multiplication   Performs operation: D = M0 × M1

In this task, I faced challenges in distinguishing between the inner loop and the outer loop.

* Inner Loop:
The inner loop iterates over the columns of matrix M1 (by a5), s1 serves as the loop counter for the columns of M1.
After computing the dot product for the current row-column pair, the column pointer of M1 (s4) is updated to point to the next column.
The pointer for the result matrix (s2) is incremented by 4 (s2 = s2 + 4) to move to the next position for storing the result.

* Outer Loop:
The outer loop iterates over the rows of matrixM0 (by a1), s0 serves as the loop counter for the rows of M0.
The row pointer of M0 (s3) is updated after processing all columns in M1. It increments by 4 * a2 (s3 = s3 + 4 * a2) to point to the next row of M0.
The pointer for M1 (s4) is reset to its initial value for processing the next row of M0.

## Part B: File Operations and Main
### Task 1: Read Matrix

This task implements a function to read a binary matrix from a file and load it into memory.
* s3 store address of rows count, s4 store address of cloumn count
* t1 saves number rows, t2 saves number columns
* t3 = (t1 * t2) * 4 , t3 need size in byte
I replaced the direct multiplication " mul s1, t1, t2" with my own implementation to compute the product.

### Task 2: Write Matrix
This task implements a function to write a matrix to a binary file.
* s1 = matrix pointer, s2 = number of rows, s3 = number of columns
* s4 = s2 * s3 ,s4 save number of total elements 
I replaced the direct multiplication "mul s4, s2, s3" with my own implementation to compute the product.

### Task 3: Classification

Bring everything together to classify an input using two weight matrices(m0,m1) and the ReLU and ArgMax functions.
* h = matmul(m0, input)
* h = relu(h)
* o = matmul(m1, h)
* a0 = armax(o)
* print a0
I replaced the direct multiplication with my own implementation to compute the product.


```
vboxuser@daivd:~/classify-rv32i$ ./test.sh all
test_abs_minus_one (__main__.TestAbs.test_abs_minus_one) ... ok
test_abs_one (__main__.TestAbs.test_abs_one) ... ok
test_abs_zero (__main__.TestAbs.test_abs_zero) ... ok
test_argmax_invalid_n (__main__.TestArgmax.test_argmax_invalid_n) ... ok
test_argmax_length_1 (__main__.TestArgmax.test_argmax_length_1) ... ok
test_argmax_standard (__main__.TestArgmax.test_argmax_standard) ... ok
test_chain_1 (__main__.TestChain.test_chain_1) ... ok
test_classify_1_silent (__main__.TestClassify.test_classify_1_silent) ... ok
test_classify_2_print (__main__.TestClassify.test_classify_2_print) ... ok
test_classify_3_print (__main__.TestClassify.test_classify_3_print) ... ok
test_classify_fail_malloc (__main__.TestClassify.test_classify_fail_malloc) ... ok
test_classify_not_enough_args (__main__.TestClassify.test_classify_not_enough_args) ... ok
test_dot_length_1 (__main__.TestDot.test_dot_length_1) ... ok
test_dot_length_error (__main__.TestDot.test_dot_length_error) ... ok
test_dot_length_error2 (__main__.TestDot.test_dot_length_error2) ... ok
test_dot_standard (__main__.TestDot.test_dot_standard) ... ok
test_dot_stride (__main__.TestDot.test_dot_stride) ... ok
test_dot_stride_error1 (__main__.TestDot.test_dot_stride_error1) ... ok
test_dot_stride_error2 (__main__.TestDot.test_dot_stride_error2) ... ok
test_matmul_incorrect_check (__main__.TestMatmul.test_matmul_incorrect_check) ... ok
test_matmul_length_1 (__main__.TestMatmul.test_matmul_length_1) ... ok
test_matmul_negative_dim_m0_x (__main__.TestMatmul.test_matmul_negative_dim_m0_x) ... ok
test_matmul_negative_dim_m0_y (__main__.TestMatmul.test_matmul_negative_dim_m0_y) ... ok
test_matmul_negative_dim_m1_x (__main__.TestMatmul.test_matmul_negative_dim_m1_x) ... ok
test_matmul_negative_dim_m1_y (__main__.TestMatmul.test_matmul_negative_dim_m1_y) ... ok
test_matmul_nonsquare_1 (__main__.TestMatmul.test_matmul_nonsquare_1) ... ok
test_matmul_nonsquare_2 (__main__.TestMatmul.test_matmul_nonsquare_2) ... ok
test_matmul_nonsquare_outer_dims (__main__.TestMatmul.test_matmul_nonsquare_outer_dims) ... ok
test_matmul_square (__main__.TestMatmul.test_matmul_square) ... ok
test_matmul_unmatched_dims (__main__.TestMatmul.test_matmul_unmatched_dims) ... ok
test_matmul_zero_dim_m0 (__main__.TestMatmul.test_matmul_zero_dim_m0) ... ok
test_matmul_zero_dim_m1 (__main__.TestMatmul.test_matmul_zero_dim_m1) ... ok
test_read_1 (__main__.TestReadMatrix.test_read_1) ... ok
test_read_2 (__main__.TestReadMatrix.test_read_2) ... ok
test_read_3 (__main__.TestReadMatrix.test_read_3) ... ok
test_read_fail_fclose (__main__.TestReadMatrix.test_read_fail_fclose) ... ok
test_read_fail_fopen (__main__.TestReadMatrix.test_read_fail_fopen) ... ok
test_read_fail_fread (__main__.TestReadMatrix.test_read_fail_fread) ... ok
test_read_fail_malloc (__main__.TestReadMatrix.test_read_fail_malloc) ... ok
test_relu_invalid_n (__main__.TestRelu.test_relu_invalid_n) ... ok
test_relu_length_1 (__main__.TestRelu.test_relu_length_1) ... ok
test_relu_standard (__main__.TestRelu.test_relu_standard) ... ok
test_write_1 (__main__.TestWriteMatrix.test_write_1) ... ok
test_write_fail_fclose (__main__.TestWriteMatrix.test_write_fail_fclose) ... ok
test_write_fail_fopen (__main__.TestWriteMatrix.test_write_fail_fopen) ... ok
test_write_fail_fwrite (__main__.TestWriteMatrix.test_write_fail_fwrite) ... ok

----------------------------------------------------------------------
Ran 46 tests in 34.076s

OK
```

