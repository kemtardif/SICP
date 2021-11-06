#lang sicp
;=================================2.60===================================

;To adjoin an element x to an ordered set S, we need to add it at the right position.
;We compare x to the elements S sequentially : if x is equal, we return the set,
;if it is smaller, we cons x and the set (thus it first), else we cons the element
;and compare with the the cdr of S : 

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((= x (car set)) set)
        ((< x (car set))
         (cons x set))
        (else (cons (car set)(adjoin-set x (cdr set))))))

;Thus if S has n elements, the process takes at most n steps, but on the average, it
;takes n/2 steps

;=================================2.61======================================

;For intersection-set of ordered sets, we compare the elements sequentially. We start by comparing the first elements :
; if they're equal, they're both the smallest, we cons either and compare both next. if either is smaller, we cons that one
; and compare the next of its set to the same element of the other set. This yield a procedure that takes at most the total
;number of elements of steps, so that for n elements, this is a O(n) process.

(define (intersection-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((< (car set1) (car set2)) (cons (car set1) (intersection-set (cdr set1) set2)))
        ((< (car set2) (car set1)) (cons (car set2) (intersection-set set1 (cdr set2))))
        (else (cons (car set1) (intersection-set (cdr set1) (cdr set2))))
        ))


