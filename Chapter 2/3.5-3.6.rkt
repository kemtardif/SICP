#lang sicp
;==========================================3.5=====================================

; We recall the Monte-Carlo procedure :

(define (monte-carlo trials experiment)
  (define (iter remaining success)
    (cond ((= remaining 0)
           (/ success trials))
          ((experiment)
           (iter (- remaining 1) (+ success 1)))
          (else (iter (- remaining 1) success))))
  (iter trials 0))

;For vectors (x1, y1), (x2, y2), opposite corners of a rectangle, the area is given by :

(define (area x1 y1 x2 y2)
  (* (- x2 x1) (- y2 y1)))

;We will also need the following random number generator :

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

;We can then write :

(define (estimate-integral predicate x1 y1 x2 y2 trials)  
  (define area
    (* (- x2 x1) (- y2 y1)))
  (define (experiment)
    (predicate (random-in-range x1 x2)
               (random-in-range y1 y2)))
  (* area (monte-carlo trials experiment)))

(define (pi-predicate x y)
  (<= (+ (* x x) (* y y)) 1))

(estimate-integral pi-predicate -1.0 -1.0 1.0 1.0 10)
(estimate-integral pi-predicate -1.0 -1.0 1.0 1.0 100)
(estimate-integral pi-predicate -1.0 -1.0 1.0 1.0 1000)
(estimate-integral pi-predicate -1.0 -1.0 1.0 1.0 10000)
(estimate-integral pi-predicate -1.0 -1.0 1.0 1.0 100000)
(estimate-integral pi-predicate -1.0 -1.0 1.0 1.0 1000000)
(estimate-integral pi-predicate -1.0 -1.0 1.0 1.0 10000000)

;====================================3.6=============================


;For the purpose of this exercise, we can define :

(define (rand-update x) (+ x 1))

(define rand
  (let ((x 0))
    (lambda (action)
      (cond ((eq? action 'generate)
             (begin (set! x (rand-update x)) x))
            ((eq? action 'reset)
             (lambda (newValue)
               (begin (set! x newValue) x)))
            (else (error "Not defined"))))))

(rand 'generate)
(rand 'generate)
((rand 'reset)4)
(rand 'generate)