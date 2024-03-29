#lang sicp
;================================2.81=======================================

;a) apply-generic with exponentiation of complex numbers first yield type-tags '(complex complex),
;while proc is false, since (get 'exp '(complex complex)) isn't defined in the complex package,
;Now if the second if, both types are complex and the coercion oepration is just the identity,
;so what it does is juts call (apply-generic 'exp '(x y)) again, creating an infinite loop.

;b)With no coercion between same types, we get an error in the second if and the procedure ends,
;so it work as is.

;c)We can add a condition on equal types before trying to coerce :

;((equals? type1 type2) (error "No method was found for this type" type1))

;=================================2.82===================================

;What we want to do is for a given type-tags list, we coerce the first element
;with the rest. If all result are true, we return the procedures. If not,
;we compare with the second element and so forth, until we're at the end of the
;list, which mean no coercions is possible using this method.

(define (coersions type-tags type)
  (map (lambda (x)
         (if (equal? x type)
             (lambda (x) x)
             (get-coercion x type)))
      type-tags))

(define (coersions-exist coersions)
  (cond ((nil? coersions) #t)
        ((car coersions)
         (coersions-exist (cdr coersions)))
        (else #f)))

(define (iterate types . args)
  (let ((type (car types))
        (coercion-list (coercions type-tags type)))
    (cond ((nil? type) (error "No conversion possible"))
          ((coersions-exist coercion-list)
           (apply-generic op (map (lambda (coercion arg) (coercion arg)) coercions args)))
          (else (iterate (cdr types) . args))))
  )

;We can finally modify apply-generic using the above procedures :

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          ((define (iterate types)
  (let ((type (car types))
        (coercion-list (coercions type-tags type)))
    (cond ((nil? type) (error "No conversion possible"))
          ((coersions-exist coercion-list)
           (apply-generic op (map (lambda (coercion arg) (coercion (content arg))) coercions args)))
          (else (iterate (cdr types)))))
             )
           (iterate type-tags . args))))))
