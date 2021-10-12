#lang sicp
;We first recall the definition of accumulate :

(define (accumulate op initial list1) 
  (if (null? list1)
      initial
      (op (car list1) (accumulate op initial (cdr list1)))))

;Each terms in the resulting sequence is given by accumulating
;the cars in each term of the initial "sequence of sequences"
;(given by a mapping). Recursion allow to calculate the whole sequence.

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate op init (map (lambda (x) (car x)) seqs))
            (accumulate-n op init (map (lambda (x) (cdr x)) seqs)))))

(define x (list (list 1 2 3) (list 1 2 3) (list 1 2 3) (list 1 2 3)))
(accumulate-n + 0 x)