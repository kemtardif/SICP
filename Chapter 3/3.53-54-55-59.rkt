#lang sicp
;==============================3.53========================
;First element of s is 1, then each element is given by summing the element of s iteratively.
;The second element is then 1 + 1 = 2, the third 2 + 2 = 4, the fourth = 4+ 4 = 8, etc.
;Thus the stream is the powers of 2.

;===================================3.54==========================

(define (mul-streams s1 s2) (stream-map * s1 s2))
(define ones (cons-stream 1 ones))
(define integers
  (cons-stream 1 (add-streams ones integers)))

(define factorials
(cons-stream 1 (mul-streams factorials integers)))

;================================3.55================================

(define (partial-sums s)
  (cons-stream (stream-car s) (add-streams (partial-sums s) (stream-cdr s))))

;===============================3.59===================================

;a)

(define inverses (stream-map / ones integers))
(define (integrate-series s)
  (mul-stream inverses s))

;b)

;We have sin(0) = 0 and sin(x) = integral(cos(x)),
;        cos(0) = 1 and cos(x) = 1 - integral(sin(x))

(define sine (integrate-series cosine))
(define minus-ones (cons-stream -1 minus-ones))
(define (minus-serie s) (mul-streams minus-ones s))

(define cosine (cons-stream 1 (integrate-series (minus-series sine))))

