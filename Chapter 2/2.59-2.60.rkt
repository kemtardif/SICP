#lang sicp
;=============================2.59============================================

;We will need :

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

;The union of two sets is the set of disctinct elements from either ones so :

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((element-of-set? (car set1) set2)
         (union-set (cdr set1) set2))
        (else (cons (car set1) (union-set (cdr set1) set2)))))

;===========================2.60=====================================

;We consider the representation for sets with duplicates elements. First, the
;element-of-set procedure stays the same. For adjoin-set, since we don't need to check
;if an element is already in the set, we have :

(define (adjoin-dup x list1)
  (cons x list1))

;The efficiency is O(1).

;For the porcedure intersection-set, we still need to go throught the set, to check
;for elements thatare in both sets, so the procedure stays the same. For the union-set
; there's no check for duplicates, so it reduces to :

(define (union-dup list1 list2)
  (append list1 list2))

;The efficiency is O(n).

