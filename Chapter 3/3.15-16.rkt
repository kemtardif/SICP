#lang sicp
; ================================3.15==================================

;set-to-wow! set the "car of the car" and since both car z1 and cdr z1 point to the same
;object, changing the car of that object also change cdr x.

;On the other hand, for z1, since car z2 and cdr z2 point to different object, changing the car of
;the object that cdr z1 point to doesn't change the object to which cdr z1 point to.

;====================================3.16==================================

(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

(define X (cons 'a 'b))
; The following structure has 3 pairs and return 3
; (. , x) 
;  |
; (. , x)
;  |
;  X

(define y3 (cons (cons X nil) nil))
(count-pairs y3)


(define X1 (cons X X))
;The folllwing structure has 3 pairs and return 4

; (. , x) 
;  |   
;  X1 
;  || 
;  X

(define y4 (cons X1 nil))
(count-pairs y4)

(define y7 (cons X1 X1))
;The following structure has 3 pairs and return 7
; X2
; ||
; X1
; ||
; X
(count-pairs y7)

;Finally, given as structure with three pair, we can use set-cdr! on the cddr part to itself, which
;make an infinite recursion loop in count-pairs.