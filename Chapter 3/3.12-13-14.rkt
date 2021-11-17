#lang sicp
;==============================3.12================================================

;In the first response, we note that (append x y) create a new list, which doesnt
; modify x, so that (cdr x) is then (b). For (append! x y ), this actually modify
; x, and w points to x, so that (cdr x) (b c d).

;==================================3.13=========================================

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define (last-pair x)
  (if (null? (cdr x)) x (last-pair (cdr x))))

; We have x => (. , .) -> (. , .) -> (. , x), before make-cycle. Make-cycle replace
;               |          |         |        the cdr x of the last pair with a pointer
;               a          b         c        to itself, and z point to x :

; After make-cycle We have z => x => (. , .) -> (. , .) -> (. , .) -> x
;                                     |          |         |       
;                                     a          b         c

;Thus if we try to compute (last-pair z, we get an infinite loop.

;====================================3.14=================================

(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))


;Initially, we have v => (a b c d). Computing (mystery v), we'll have various
;iterations of (loop x y), where the the value of v will change, and w will point to the return value :

;First, we have (mystery v) -> (loop v '()),  which change v => (a), with temp1 => (b c d).
;Second, we have (loop temp v), which change temp1 => (b a), with temp2 => (c d).
;Third, we have (loop temp2 temp1), which change temp2 => (c b a), with temp3 => (d).
;Fourth, we have (loop temp3 temp2), which change temp3 =>(d c b a), with temp4 => ()

; Thus w => (d c b a) and x => (a)
 


