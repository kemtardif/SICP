#lang sicp


;The requirement can be stated as such : if both a and b are not pair and are eq?, we get true,
; if both are pairs and both cars and cdr are equal?, we get true (this is the recursive part),
;else we get false. In code :

(define (equal? listA listB)
  (cond ((and (not (pair? listA)) (not (pair? listB)))
         (eq? listA listB))
        ((and (pair? listA) (pair? listB))
         (and (equal? (car listA) (car listB))
              (equal? (cdr listA) (cdr listB)))
         )
        (else #f)))

(equal? '(1 2 3) (list 1 2 3 4))