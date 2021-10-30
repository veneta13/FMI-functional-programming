#lang racket

; Task 1

; find the sum of the digits of the number 
(define (digit-sum number accumulator)
   (cond
     [(= number 0) accumulator]
     [else (digit-sum (/ (- number (remainder number 10)) 10) (+ accumulator (remainder number 10)) )]
   )
)

; check if a digit of the number is equal to the wanted digit
; return 1 for true and 0 for false 
(define (digit-checker number power-of-10 digit)
  (cond
    [(= (remainder (quotient number (expt 10 power-of-10)) 10) digit) 1]
    [else 0]
   )
 )

; Count how many digits of the number are the right digit 
(define (digit-counter number digit)
  (define (iterator-digits accumulator power-of-10)
    (cond
      [(> (expt 10 power-of-10) number) accumulator]
      [else (iterator-digits (+ accumulator (digit-checker number power-of-10 digit)) (+ power-of-10 1))]
      )
    )
  (iterator-digits 0 0)
 )

; main function
(define (sum-counts-iter x d)
  (define (iterator-func accumulator counter)
    (cond
      [(> counter x) accumulator]
      [else (iterator-func (+ accumulator (digit-counter counter d)) (+ counter 1))])
    )
  (digit-sum (iterator-func 0 1) 0)
 )

; Tests - Task 1

#|
(= (sum-counts-iter 1 1) 1)
(= (sum-counts-iter 5123 1) 19)
(= (sum-counts-iter 1234 8) 10)
(= (sum-counts-iter 5555 5) 10)
(= (sum-counts-iter 65432 6) 11)
(= (sum-counts-iter 70000 1) 11)
(= (sum-counts-iter 123321 1) 29)
|#

; Task 2

; more the index by 2 positions in the new number
; if the new digits are 10
(define (digit-index-increase number)
    (cond
    [(> number 9) 2]
    [else 1]
     )
  )

; find current digit and increase by 1
(define (digit-transformer number digit-index)
  (+ (remainder (quotient number (expt 10 digit-index)) 10) 1)
 )

; main function
(define (add-ones n)
  (define (iterator new-number digit-index-old digit-index-new)
    (cond
     [(> (expt 10 digit-index-old) n) new-number]
     [else 
      (iterator
            (+ new-number (* (digit-transformer n digit-index-old) (expt 10 digit-index-new)))
            (+ digit-index-old 1)
            (+ digit-index-new (digit-index-increase (digit-transformer n digit-index-old)))
        )
      ]
     )
    )
  (iterator 0 0 0)
  )

; Tests - Task 2

#|
(= (add-ones 123) 234)
(= (add-ones 193) 2104)
(= (add-ones 998) 10109)
(= (add-ones 9999) 10101010)
|#

