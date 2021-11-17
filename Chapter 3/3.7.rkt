#lang sicp
;========================================3.7=======================================

;We first recall the passowrd-protected account procedure, to which we had a mean to check
;validity of passwords:

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
  (define (dispatch  try m)
    (if (eq? m 'auth)
        (eq? try password)          
        (if (eq? try password)
            (cond ((eq? m 'withdraw) withdraw)
                  ((eq? m 'deposit) deposit)
                  (else (error "Unknown request: MAKE-ACCOUNT"
                               m)))
            denied
            )))
  dispatch)


;Then it is just a matter of checking for corresponding old password at creation,
; and the new password at operations : 
(define (make-joint acc oldP newP)
  (define (dispatch try m)
    (if (acc oldP 'auth)
        (if (eq? try newP)
            (acc oldP m)
            "Wrong password")
        "Access denied"))
  dispatch)


(define oldAcc (make-account 100 'oldP))
(define newAcc (make-joint oldAcc 'oldP 'newP))

((newAcc 'newP 'withdraw) 10)
((oldAcc 'oldP 'withdraw) 10)

