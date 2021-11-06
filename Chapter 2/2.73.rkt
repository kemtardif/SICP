#lang sicp
;;=========================2.73========================

;a) What was done is that we interpreted operations as tags on lists and made the derivation procedure
;general by making it only select the correct procedure to apply depending on the tag;

;We first define how to get the operator and operands part of an expression :

(define (operator z) (car z))
(define (operands z) (cdr z))

;The derivation only select and appropriate procedure to apply, depending on the type of operator :

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp))
               (operands exp) var))))

;From this point of view, there's no way to define an operator to select the predicate
;number? and variable? from a table i.e. they are not represented as a single symbol that can be extracted
;from an expression z.

;As we see, all specific derivation procedures will work with the operands part of an expression
;(and the var symbol). In each representation (+, *, etc), we don't need to specify the operation.

;We will work with the case of operations on at most two symbols for simplicity.



;;b)

(define (install-deriv-sums)
  ;;internal procedures
   (define (make-sum x) (cons x y))
  (define (addend a) (car a))
  (define (augent a) (cadr a))
  (define (deriv-sum exp var)
    (make-sum (deriv (addend exp) var)
              (deriv (augent exp) var)))
  ;;interface to the rest of the system
  (define (tag x) (cons '+ x))
  (put 'make-sum '+
       (lambda (x y) (tag (make-sum x y))))
  (put 'deriv '+ deriv-sum)
  )

(define (make-sum x y)
  ((get 'make-sum '+)(x y)))

(define (install-deriv-products)
  ;;internal procedures
  (define (make-product a b) (cons a b))
  (define (multiplicant a) (car a))
  (define (multipler a) (cadr b))

  (define (deriv-product exp var)
    (make-sum (make-product (multiplicant exp)
                            (deriv (multiplier exp)))
              (make-product (deriv (multiplicant exp))
                            (multiplier exp))))
  ;;interface to the rest of the system
  (define (tag x) (cons '* x))
  (put 'make-product '*
       (lambda (x y) (tag (make=product x y))))
  (put 'deriv '* deriv-product)
  )










