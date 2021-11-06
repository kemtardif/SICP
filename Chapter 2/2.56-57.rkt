#lang sicp
;For those problems, we will recall the selectors and constructors :

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2))
         (+ a1 a2))
        (else (list '+ a1 a2))))

(define (=number? exp num) (and (number? exp) (= exp num)))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))


(define (sum? x) (and (pair? x) (eq? (car x) '+)))

(define (addend s) (cadr s))

(define (augend s) (caddr s))

(define (product? x) (and (pair? x) (eq? (car x) '*)))

(define (multiplier p) (cadr p))

(define (multiplicand p) (caddr p))

;===============================2.56===============================================
;We first need to introduce selectors and constructors appropriate for exponentiation.

;A term is an exponentiation if it is a list and it's firs term is '**':
(define (exponentiation? a) (and (pair? a) (eq? (car a) '**)))

;If a is an exponentiation, i.e a = '(** m n), we find the base m and the exponent n by :
(define (base n)(cadr n))
(define (exponent n ) (caddr n))

;We can create exponentiation from m and n, taking care of the case of numbers 0 and 1 :

(define (make-exponentiation m n)
  (cond ((=number? n 0) 1)
        ((=number? n 1) m)
        (else (list '** m n))))

;Finally, we extend the deriv procedure to include exponentiation :

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        ((sum? exp) (make-sum (deriv (addend exp) var)
                              (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))
        ((exponentiation? exp)
         (make-product (exponent exp)
                       (make-product (make-exponentiation
                                      (base exp)
                                      (make-sum (exponent exp) -1))
                                     (deriv (base exp) var))))
        (else
         (error "unknown expression type: DERIV" exp))))

;==============================2.57===============================================


;To handle sums and products or arbitrary number of terms, we need to modifiy the
;selectors.

;For addition, we need modify the augend selector, so that for '(+ a b c ..), we get '(+ b c ...),
; and the result is b in the case the sum is just '(+ a b) :  


(define (augend-mod x)
  (if (= (length (cddr x)) 1)
      (caddr x)
      (cons '+ (cddr x))))

;For multiplication, we can do the same thing for the multiplicant :


(define (multiplicant-mod x)
  (if (= (length (cddr x)) 1)
      (caddr x)
      (cons '+ (cddr x))))
