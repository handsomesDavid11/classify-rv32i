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

In this task, the address calculation and skip distance setting were challenging for me and took some time to fix.
* t0 is used to temporarily store the result of the multiplication.
* s0 and s1 represent the addresses of the multiplier and multiplicand, respectively.
* s4 and s5 are used as indices.
* t3 and t2 hold the current multiplier and multiplicand values.
* The multiplication operation is performed using mul1. If t4 is less than t3, the result (t0) is updated as t0 = t0 + t2.

After completing the mul1, the indices are updated:

* s4 = s4 + a3 and s5 = s5 + s4

The next addresses are calculated as:

* s0 = s4 * 4 + a0 and s1 = s5 * 4 + a1.

This process is repeated for the next round of computation.

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


