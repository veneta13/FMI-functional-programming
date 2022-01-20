# FMI-functional-programming
Tasks for the functional programming course @ FMI.

### Homework 1
#### Task 1

Define a procedure **(sum-counts-iter x d)** that returns the sum of the digits of the number of occurrences of the digit d in the numbers from the interval [1, x]. The procedure must implement a linearly iterative process.

```racket
  (sum-counts-iter 1 1) ; → 1
  (sum-counts-iter 5123 1) ; → 19
  (sum-counts-iter 1234 8) ; → 10
  (sum-counts-iter 5555 5) ; → 10
  (sum-counts-iter 65432 6) ; → 11
  (sum-counts-iter 70000 1) ; → 11
  (sum-counts-iter 123321 1) ; → 29
```

#### Task 2

Define a procedure **(add-ones n)** that adds 1 to each digit of the non-negative number n. In case 1 to 9 is added instead of done carry 1, add 10 to the new number.

```racket
  (add-ones 123) ; → 234
  (add-ones 193) ; → 2104
  (add-ones 998) ; → 10109
  (add-ones 9999) ; → 10101010
```

### Homework 2
#### Task 1

Define a higher-order procedure **(itinerary flights)**, which accepts a list of pairs representing air travel in the form **(&lt;start>.&lt;end>)**, and returns a unary procedure accepting the initial airport - such that the value of **((itinerary flights) start)** is lexicographically the smallest sequence of travels that includes all given trips exactly once (it is possible to go through one airport more than once). If case such does not exist,  return error indication.

```racket
((itinerary '(("SFO" . "HKO") ("YYZ" . "SFO") ("YUL" . "YYZ")("HKO" . "ORD"))) "YUL") ; → '("YUL" "YYZ" "SFO" "HKO" "ORD")
((itinerary '(("A" . "B") ("A" . "C") ("B" . "C") ("C" . "A"))) "A") ; → '("A" "B" "C" "A" "C")
((itinerary '(("SFO" . "COM") ("COM" . "YYZ"))) "COM") ; → "No such itinerary!"
```

#### Task 2

Define a higher-order procedure **(pad xs)** that accepts a matrix xs and returns a unary procedure that takes the number x - such that the return value is a new matrix in which xs is enclosed by x.

```racket
((pad '( (1 2 3)
         (4 5 6)
         (7 8 9) )
         ) 0)

;→ '( (0 0 0 0 0)
;     (0 1 2 3 0)
;     (0 4 5 6 0)
;     (0 7 8 9 0)
;     (0 0 0 0 0) )

((pad '( (1 2 3)
         (4 5 6)
         (7 8 9) )
         ) 9)

;→ '( (9 9 9 9 9)
;     (9 1 2 3 9)
;     (9 4 5 6 9)
;     (9 7 8 9 9)
;     (9 9 9 9 9) )
```
