#lang sicp
;=======================================3.9================================

;For the first procedure :

;(define (factorial n)
;  (if (= n 1) 1 (* n (factorial (- n 1)))))

;In the global environment frame G, there's a single binding for the procedure object factorial,
;consisting of some code and a pointer to that global environment.

;Evaluating (factorial 6) creates a new env F6, pointing to G, in which we have parameters n : 6,
;and body : (if (= n 1) 1 (* n (factorial (- n 1)))), which evaluate to (* 6 (factorial 5)).

;Evaluating (factorial 5) result in the creation of a new environment F5, pointing to G, with paramters n : 5
; and body (if (= n 1) 1 (* n (factorial (- n 1)))), which evaluate to (* 5 (factorial 4)).

;In total, we create environments Fi, i = 6, 5, 4, 3, 2, all pointing to G, with parameter n : i and body : (if (= n 1) 1 (* n (factorial (- n 1))),
;evaluating to (* i (factorial (- i 1)), plus one last frame F1, pointing to G, with parameter n : 1, and body : (if (= n 1) 1 (* n (factorial (- n 1)))),
;evaluating to 1.

;We then multiply the return value from F1 with the one in F2 and so forth, until we arrive at the return value of F6.
;Note that the return value in each frames is different (product of n times return value of "next" frame).

; For the iterative version :

;(define (factorial n) (fact-iter 1 1 n))
;(define (fact-iter product counter max-count)
;  (if (> counter max-count)
;      product
;      (fact-iter (* counter product)
;                 (+ counter 1)
;                 max-count)))

;In the global environment G, there's two bindings for the procedure objects factorial-2 and fact-iter,
;consisting of some code and a pointer to G.

;Evaluating (factorial 6) creates a new environment FF, pointing to G, with parameter n : 6 and body : (fact-iter 1 1 n),
;which evaluate to (fact-iter 1 1 6).

;Evaluating (fact-iter 1 1 6) creates a new environment F6, pointing to G, with parameters (product : 1, counter : 1, max-count : 6)
; and body reducing to (fact-iter 1 2 6).

;Again, we create a series of environment Fi, i = 6, 5, 4, 3, 2, 1 pointing to G, with 3 parameters and evaluating to fact-iter, and
; a frame F0, pointing to G, with parameters (product : 1*2*3*4*5*6, counter : 7, max-count : 6), with body : 6!.

;Note here the return value of each frame is 6!, since we subtitute the "final" return value in each frames.
;In other words, the multiplation happening in the returns of the first procedure is done in the case before creating
;a new frame.