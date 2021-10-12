#lang sicp
;We first recall the definition of accumulate :

(define (accumulate op initial list1) 
  (if (null? list1)
      initial
      (op (car list1) (accumulate op initial (cdr list1)))))

;In terms of accumulate, the map procedure can be written as :

(define (map p list1)
  (accumulate (lambda (x y) (cons (p x) y)) nil list1))

;For the append procedure, we get:
(define (append list1 list2)
  (accumulate cons list2 list1))

;Finally, the length procedure is given as :
(define (length sequence)
         (accumulate + 0 sequence))\


