#lang sicp
;==========================3.17================================

;We first define a procedure to check if an element is part of a given list:

(define (is-in-list? element list)
  (cond ((null? list) #f)
        ((eq? (car list) element)#t)
        (else (is-in-list? element (cdr list)))))

;The count-pair procedure needs to keep track of which pair it alreadly has traversed,
;which is done by adding each distinct pair to a list, after checking it is not in the list :


(define (count-pairs x)
  (let ((counted '()))
    (define (count x)
      (if (not (pair? x))
          0
          (if (is-in-list? x counted)
              (+ (count (car x))
                 (count (cdr x)))
              (begin (set! counted (cons x counted))
                     (+ (count (car x))
                        (count (cdr x))
                        1)))))
    (count x)))


;===================================3.18============================================


;One way to check if a list contain a cycle is to keep track of the cdrs while we go throught them,
; checking for equality at each iteration ;

(define (has-cycle? list)
  (let ((cdrs '()))
    (define (cycling list)
      (cond ((null? list) #f)
            ((is-in-list? list cdrs) #t)
            (else (begin (set! cdrs (cons list cdrs))
                               (cycling (cdr list))))))
    (cycling list)))