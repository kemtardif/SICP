#lang sicp

;We will need a procedure that take numbers a and b and make the list of numbers from a to b :

(define (enumerate-interval a b)
  (if (> a b)
      nil
      (cons a (enumerate-interval (+ a 1) b))))

;We will also need to accumulate :

(define (accumulate op initial seq)
  (if (null? seq)
      initial
      (op (car seq)
          (accumulate op initial (cdr seq)))))

;To make a sequence of pairs (i, j), we enumerate throught the i's, then enumerate throught the j's
; such that j < i:

(define (pairs-sequence N)
  (map (lambda (i)
         (map (lambda (j)
                (list i j))
              (enumerate-interval 1 (- i 1))))
       (enumerate-interval 1 N)))

;Finally, we make a list by accumulation throught append :

(define (unique-pairs N)
  (accumulate append nil
              (pairs-sequence N)))




