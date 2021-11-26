#lang racket

; Task 1

; get a list of destinations by the start airport 
(define (find-airports flights start destination)
  (cond
    [(empty?  flights) destination]
    [else
     (cond
       [(equal? (caar flights) start)
            (find-airports
                           (cdr flights)
                           start
                           (list* (cdar flights) destination))]
       [else
            (find-airports
                           (cdr flights)
                           start
                           destination)])]
    )
  )


; search flights
(define (search flights start answer)
  (cond
    [(empty? (find-airports flights start '()))
     (cond
       [(empty? flights) (reverse answer)] 
       [else "No such itinerary!"])
    ]
    [else
     ; make the lexicographically smallest available airport next 
     (let ([next-airport (car (sort (find-airports flights start '()) string<?))])
     (search
           (remove (cons start next-airport) flights)
           next-airport
           (list* next-airport answer))
     )]
    )
  )

;main function
(define (itinerary flights)
  (lambda (start) (search flights start (list start)))
  )



; Tests - Task 1

#|
(
 (itinerary '(
              ("SFO" . "HKO")
              ("YYZ" . "SFO")
              ("YUL" . "YYZ")
              ("HKO" . "ORD")
              ))
 "YUL"
 )

; test 1 - result: '("YUL" "YYZ" "SFO" "HKO" "ORD")

((itinerary '(
              ("A" . "B")
              ("A" . "C")
              ("B" . "C")
              ("C" . "A")))
"A")

; test 2 - result: '("A" "B" "C" "A" "C")

(
 (itinerary '(
              ("SFO" . "COM")
              ("COM" . "YYZ")
              ))
 "COM"
 )

; test 3 - result: "No such itinerary!"

|#


; Task 2

; create the whole x frame
(define (write-x-frame xs x counter counter-max lines)
  (cond
    [(equal? counter counter-max)
     (list*
           (write-x-line x 0 (+ (length (car xs)) 2) '())
           lines)]
    [else
     (write-x-frame
                    xs
                    x
                    (+ counter 1)
                    counter-max
                    (list* (append (list* x (list-ref xs counter)) (list x)) lines))]
   )
  )


; print a line of x-es
(define (write-x-line x counter counter-max line)
  (cond
    [(equal? counter counter-max) line]
    [else (write-x-line
                        x
                        (+ counter 1)
                        counter-max
                        (list* x line))]
   )
  )

; create the grid
(define (make-grid xs x)
   (reverse (write-x-frame
                          xs
                          x
                          0
                          (length xs)
                          (list (write-x-line x 0 (+ (length (car xs)) 2) '()))))
  )

;main function
(define (pad xs)
  (lambda (x) (make-grid xs x))
  )



; Tests - Task 2

#|
((pad '( (1 2 3)
         (4 5 6)
         (7 8 9)
         ))
 0)

((pad '( (1 2 3)
         (4 5 6)
         (7 8 9)
         ))
 9)

|#

#|
test 1 - result:

 '( (0 0 0 0 0)
    (0 1 2 3 0)
    (0 4 5 6 0)
    (0 7 8 9 0)
    (0 0 0 0 0) )

test 2 - result:

'( (9 9 9 9 9)
   (9 1 2 3 9)
   (9 4 5 6 9)
   (9 7 8 9 9)
   (9 9 9 9 9) )
|#


