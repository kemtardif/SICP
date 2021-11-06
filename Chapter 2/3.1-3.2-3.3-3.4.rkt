#lang sicp
;=====================================3.1==============================

(define (make-accumulator initial)
 (lambda (value)
   (begin (set! initial (+ initial value))
          initial)))

(define A (make-accumulator 5))
(A 10)
(A 5)

;=====================================3.2==================================


(define (make-monitored f)
  (let ((counter 0))
      (lambda (value)
        (cond ((eq? value 'how-many-calls?)
               counter)
              ((eq? value 'reset-count)
               (begin (set! counter 0) counter))
              (else (begin (set! counter (+ counter 1)) (f value)))))))

(define (double x) (* x x))
(define B (make-monitored double))

(B 'how-many-calls?)
(B 5)
(B 10)
(B 'how-many-calls?)
(B 'reset-count)
(B 'how-many-calls?)


;======================================3.3===================================

;We just need to add a protection layer that checks for matching matching password.
; If they do, we apply dispatch as usual, otherwise we block access.

(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (denied m) "Wrong Password")
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request: MAKE-ACCOUNT"
                       m))))
  (define (password-protection try m)
    (if (eq? password try)
        (dispatch m)
         denied))
  password-protection)

;=============================================3.4============================================

;What we want is a counter that goes up with a wrong password and restart with the right password,
;plus a condition that call the cops if counter > 7.

(define (make-account-cops balance password)
  (let ((counter 0))
    (define (withdraw amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Insufficient funds"))
    (define (deposit amount)
      (set! balance (+ balance amount))
      balance)
    (define (denied m) "Wrong Password")
    (define (dispatch m)
      (cond ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            (else (error "Unknown request: MAKE-ACCOUNT"
                         m))))
    (define (call-the-cops n) "COPS ARE CALLED")
    (define (cops-calling try m)
      (if (>= counter 7)
          call-the-cops
          (password-protection try m)))
    (define (password-protection try m)
      (if (eq? password try)
          (begin (set! counter 0)(dispatch m))
          (begin (set! counter (+ counter 1)) denied)))
  cops-calling))


(define acc (make-account-cops 100 'kem))
((acc 'kemm 'withdraw) 15)
((acc 'kemm 'withdraw) 15)
((acc 'kemm 'withdraw) 15)
((acc 'kemm 'withdraw) 15)
((acc 'kemm 'withdraw) 15)
((acc 'kem 'withdraw) 15)
((acc 'kemm 'withdraw) 15)
((acc 'kemm 'withdraw) 15)
((acc 'kemm 'withdraw) 15)
((acc 'kemm 'withdraw) 15)
((acc 'kemm 'withdraw) 15)
((acc 'kemm 'withdraw) 15)
((acc 'kemm 'withdraw) 15)
((acc 'kemm 'withdraw) 15)
((acc 'kemm 'withdraw) 15)
((acc 'kem 'withdraw) 15)

