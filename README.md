# FMI-functional-programming
Tasks for the functional programming course @ FMI.

### Homework 1
#### Task 1

Define a procedure **(sum-counts-iter x d)** that returns the sum of the digits of the number of occurrences of the digit d in the numbers from the interval [1, x]. The procedure to implement a linearly iterative process

- (sum-counts-iter 1 1) ; -> 1
- (sum-counts-iter 5123 1) ; -> 19
- (sum-counts-iter 1234 8) ; -> 10
- (sum-counts-iter 5555 5) ; -> 10
- (sum-counts-iter 65432 6) ; -> 11
- (sum-counts-iter 70000 1) ; -> 11
- (sum-counts-iter 123321 1) ; -> 29

#### Task 2

Define a procedure **(add-ones n)** that adds 1 to each digit of the non-negative number n. In case 1 to 9 is added instead of done carry 1, write 10 in the new number.

- (add-ones 123) ; -> 234
- (add-ones 193) ; -> 2104
- (add-ones 998) ; -> 10109
- (add-ones 9999) ; -> 10101010
