#lang sicp
;================================3.39=======================
;In this case, it is (lambda () (* x x)) and (lambda () (set! x (+ x 1))  )that cannot be run concurrently.
;This implies only the access and calculation of the new value (*x x) and the whole set! operation
;cannot be run in parallel, so the value 110, where P2 changes x from 10 to 11 while P1 access x is eliminated,
; leaving the other four possibilities. The value 11 is also eliminated, since P2 cannot both access AND set x while
;P1 access and set x.

;===========================================3.40================================

;1,000,000 : P1 and P2 execute one after the other
;