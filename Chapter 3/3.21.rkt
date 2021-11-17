#lang sicp
;====================================QUEUES===========================================

;Queues are represented as a pair of pointers to the first and last item of a list :

(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))

(define (set-front-ptr! queue item)
  (set-car! queue item))
(define (set-rear-ptr! queue item)
  (set-cdr! queue item))

;We define an empty queue to have front-ptr pointing to an empty list :

(define (empty-queue? queue)
  (null? (front-ptr queue)))

;We create an empty queue by consing empty lists :

(define (make-queue) (cons '() '()))

;We also define a selector for the front item, given by returing the front-ptr :

(define (front-queue queue)
  (if (empty-queue? queue)
      (error "Queue is empty")
      (car (front-ptr queue))))

;We also define a procedure to add an element to the end of the queue :

(define (insert-queue! queue item)
  (let ((new-pair (cons item '())))
    (cond ((empty-queue? queue)
           (set-front-ptr! queue new-pair)
           (set-rear-ptr! queue new-pair)
           queue)
          (else (set-cdr! (rear-ptr queue) new-pair)
                (set-rear-ptr! queue new-pair)
                queue))))

;Finally, we remove the front element by the following procedure :

(define (delete-queue! queue)
  (if (empty-queue? queue)
      (error "Queue is empty")
      (begin (set-front-ptr! queue (cdr (front-ptr queue)))
             queue)))

;=========================================================3.21========================================

;The printed representation of a queue arising from those procedure is not to be understood as
;the list of element contained in it. A queue is actually a pair consisting of pointers to the front
;and rear element, hence it's printed representation as a pair is to be understood as such :
;first element is a pair with car the actual first element of the list and the cdr a pointer to the
;after "after it", while the second element point to a pair with car the last element of the list,
;and cdr the empty list.


;We can iterate throught the queue and display each element one-by-one :
(define (print-queue queue)
  (define (printer pair)
    (if (not (null? pair))
        (begin (display (car pair))
               (printer (cdr pair)))))
  (printer (front-ptr queue)))

(define q2 (make-queue))
(print-queue (insert-queue! q2 'a))
(print-queue (insert-queue! q2 'b))
(print-queue (delete-queue! q2))
(print-queue (delete-queue! q2))


