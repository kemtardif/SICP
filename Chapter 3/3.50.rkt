#lang sicp

;===============================3.50============================

;We suppose proc is procedure of n arguments and argstreams is a list of n streams,
;so that if (car argstreams) is the empty stream, then so are the other elements. If not,
;we create a new stream where the car is the application of proc to the cars of argstreams,
;and the cdr is the delayed application of stream-map to the cdrs : 

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc (map stream-cdr argstreams))))))

;================================3.51======================================

;When we define x, we first evaluate stream-enumerate-interval, which gives (cons 0 (delay (stream-enumerate-interval 1 10))).
;stream-map then evaluate to (cons 0 (delay (stream-map show (cons 1 (delay (stream-enumerate-interval 2 10)))))), while displaying
;0 once. For (stream-ref 5 x), We need to evaluate 5 delays, dsiplaying in turn 1 , 2 ,3 ,4 ,5, while the procedure itself return 5.
;For (stream-ref 7 x), lazy-evaluation of delay implies x is computed up to 5, so that the only new results on the screen are 6 and 7
;from de delayed evaluation, plus the return value of 7 from the procedure. Thus we see on the screen 0 1 2 3 4 5 5 6 7 7.

;==================================3.52===============================


;When defining seq, sum will be set to 1 and seq to
;(cons 1
;      (delay (stream-map accum
;                         (cons 2
;                               (delay
;                                 (stream-enumerate-interval 3 20))))))

;Defining y will evaluated the delayed stream-map and set sum to 3, while forcing (cdr seq) will set sum 6, giving y :

;(cons 2
;      (delay (stream-filter even?
;                            (cons 3
;                                  (delay
;                                    (stream-enumerate-interval 4 20))))))

;While defining z, for which the first element is 5, we will evaluate stream-map up to 5, so the sum will be 15.
;stream-ref will evaluate the 7th element of y, which set sum to 108 and print 14.
;Evaluating display-strem will print 1 to 20, and sum will be 213.

;Without memoization, At each evaluation involving seq, sum will augment while we iterate throught its elements.


