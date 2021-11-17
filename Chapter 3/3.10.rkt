#lang sicp
;==========================================3.10=======================================

;We first re-write the local state make-withdraw with the syntactic sugar :

(define (make-withdraw initial-amount)
  ((lambda (balance)
    (lambda (amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Insufficient funds"))) initial-amount))

;This create a procedure object make-withdraw with
;parameter : initial-amount and body : ((lambda (balance) (...)) initial-amount)

(define W1 (make-withdraw 100))

;Evaluating make-withdraw create a frame M0, pointing the global frame G (where make-withdraw is evaluated)
; with binding initial-amount : 100, in which the first lambda is evaluated. This in turn create a frame E1,
; pointing to E0 with binding balance : initial-amount. Then W1 is the result, which is a procedure object
;with paramter amount, and a pointer to E1.

;Basically, this form of make-withdraw create an additional frame E0 holding value for initial-amount, which
;in turn pass it to the balance parameter in the frame where W1 is evaluated.