#lang sicp
;We first recall the definition of accumulate :

(define (accumulate op initial list1) 
  (if (null? list1)
      initial
      (op (car list1) (accumulate op initial (cdr list1)))))

;For a sequence of coefficient ordered from 0 to N,
;we can re-formulate Horner's backward :
;Starting from the zeroth coefficient, we add x times the
;next coefficient, to which we add x, and so on, until we reach the
;N-th coefficient.

(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms)
                (+ this-coeff (* x higher-terms)))
              0
              coefficient-sequence))


