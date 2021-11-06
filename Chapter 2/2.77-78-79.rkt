#lang sicp
;================================================2.77============================

;THe problem is that there's no entry in the table corresponding to they keys'magnitude and '(complex).
;Thus when applying magnitude to a complex z, it's tag is '(complex), which return nothing.
;Now if we were to add the following procedure to the comprex operations package :

;(put 'magnitude '(complex) magnitude)

; Then when evaluating (magnitude z), (apply-generic z) will find magnitude again in the table and apply it
;to the content of z, which is striped from it's '(complex) tag and now only has a 'polar or 'rectangular tag.
;Thus apply-generic is called again, find the right reprensentation for evaluation and evaluate. Thus apply-generic is
;called twice, dipatching to magnitude first, then to the magnitude procedure relevant to the right (polar, rectangular) representation.

;==========================================2.78=======================================

(define (type-tag datum)
  (cond ((or (symbol? datum) (number? datum)) 'scheme-number)
        ((pair? datum) (car datum))
        (else (error "Bad tagged datum: TYPE-TAG" datum))))


(define (contents datum)
  (cond ((or (symbol? datum) (number? datum)) datum)
        ((pair? datum) (cdr datum))
        (else (error "Bad tagged datum: CONTENTS" datum))))


(type-tag 'a)
(contents 'a)

;======================================2.79=====================================

;We firs
;We first define equality in the generic-package in terms of scheme-number operations,
; and as a front-facing general procedure :

(put 'equ? '(scheme-number scheme-number) (lambda (x y) (= x y)))

(define (equ? x y) (apply-generic 'eq? x y))

;We can now define equality on the other representation by refering to this operation :

(define (equ?-rat x y)
  (equ? (* (num x) (den y)) (* (num y) (den x))))
(put 'equ? '(rational rational) equ?-rat)

(define (equ?-complex x y)
  (and (equ? (real-part x) (real-part y))
       (equ? (complex-part x) (complex-part y))))
(put 'equ? '(complex complex) equ?-complex)