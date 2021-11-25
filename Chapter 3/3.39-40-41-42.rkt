#lang sicp
;================================3.39========================================
;In this case, it is (lambda () (* x x)) and (lambda () (set! x (+ x 1))  )that cannot be run concurrently.
;This implies only the access and calculation of the new value (*x x) and the whole set! operation
;cannot be run in parallel, so the value 110, where P2 changes x from 10 to 11 while P1 access x is eliminated,
; leaving the other four possibilities. The value 11 is also eliminated, since P2 cannot both access AND set x while
;P1 access and set x.

;===========================================3.40================================

;1,000,000 : P1 and P2 execute one after the other
;100,000   : P1 set x to 100 while P2 access the first and second x
;10,000    : P1 set x to 100 while P2 access the second and third x
;            P2 set x to 1000 while P1 access the first and second x
;1000      : P1 set x to 100, after P2 has accessed the third x, but before setting x
;100       : P2 set x to 1000, after P1 has accessed the second x, but before setting x

;If we serialize both lambda with the same serializer, no procedure can set x
;while another procedure is running, hence only 1,000, 000 remains

;===========================================3.41===================================

;There is no need to serialize the procedure, since the problems arising from concurrency appears when
;multiple procedure try to access AND modify some state variables. In our case, we only access the variable.
;Since the other procedures are serialized, what could happen is that balance is called concurrently to either one,
;which would just give the balance before and after set!, which would just be the same as if it was serialized.

;=======================================3.42=====================================

;Since in both case we are working with the same serializer, my guess is that both solutions are essentially the same,
; except one serialize procedures at every call, while the other do it once. In either case, this is not relevant for concurrency.