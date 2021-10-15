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

;To construct triplets (i, j, k), where 1 <= k < j < i < N, we enumerate thought
; i's from 1 to N, then j's from 1 to i, then k's from 1 to j :

(define (triplets N )
  (map (lambda (i)
         (map (lambda (j)
                (map (lambda (k)
                       (list i j k))
                     (enumerate-interval 1 (- j 1))))
              (enumerate-interval 1 (- i 1))))
         (enumerate-interval 1 N)))

;We flatten the result as a sequence :

(define (triplets-pair N)
  (accumulate append nil
              (accumulate append nil (triplets N)))
  )

;We can now filter results such that i + j + k = s for a given s using;

(define (filter predicate seq)
  (cond ((null? seq) nil)
        ((predicate (car seq))
         (cons (car seq)
               (filter predicate (cdr seq))))
        (else (filter predicate (cdr seq)))))

;The final result is then :

(define (sum-triplets N s)
  (filter (lambda (x)
            (= s (+ (car x) (cadr x) (caddr x))))
          (triplets-pair N)))


