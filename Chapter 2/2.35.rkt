#lang sicp
;We first recall the definition of accumulate :

(define (accumulate op initial list1) 
  (if (null? list1)
      initial
      (op (car list1) (accumulate op initial (cdr list1)))))

;To re-formulate the count-leaves procedure in terms of accumulation,
;we first re-formulate it as such:
;-Takes a tree as argument
;-Enumerate as a sequence of leaves
;-Map the sequence to a sequence of ones
;-Accumulate by addition

;To enumarate a tree into a sequence, we recall :

(define (enumerate-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))

;We then get :
(define (count-leaves tree)
  (accumulate + 0 (map (lambda (x) 1) (enumerate-tree tree))))

