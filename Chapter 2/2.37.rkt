#lang sicp
;We first recall the definition of accumulate :

(define (accumulate op initial list1) 
  (if (null? list1)
      initial
      (op (car list1) (accumulate op initial (cdr list1)))))

;And the definition of accumulate-n :

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate op init (map (lambda (x) (car x)) seqs))
            (accumulate-n op init (map (lambda (x) (cdr x)) seqs)))))


;The inner product on vectors can be written as :

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

;Matrix-vector multiplication can be written as :

(define (m-*-v m v)
  (map (lambda (x) (dot-product x v)) m))

;The transpose of a matrix can be written as :

(define (transpose m)
  (accumulate-n cons nil m))

;Matrix product can be written as :

(define (matrix-*-matrix m n)
`(let ((cols (transpose n)))
   (map (lambda (x) (m-*-v cols x)) m)))

;As we can see, we build operations on more complex structures from operations
;on simpler structure : dot-product -> matrix-vector multiplication -> matrix product
;This make sense since complex structures are formed from simpler ones.



