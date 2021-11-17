#lang sicp
;================================3.8=============================

(define (f x)
  (let ((init 0))
    (begin (set! init (+ init x))
    (if (even? init)
        -0.5
        0.5))))

;Evaluation of (+ (f 0) (f 1)) from left to right yield : 
;(+ -0.5 (f 1))
;(+ -0.5 0.5)
;0

;Evaluation from right to left yield :

;(+ (f 0) 0.5)
;(+ 0.5 0.5)
;1