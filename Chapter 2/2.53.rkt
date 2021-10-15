#lang sicp
;(list 'a 'b 'c) : evaluate to a list with elements as symbols : (a b c)
;(list (list 'george)) : evaluate to a list with a single list element with a single symbol : ((george))
;(cdr '((x1 x2) (y1 y2))) : quotation evaluate to the printed representation of a list, which as cdr : ((y1 y2))
;(cadr '((x1 x2) (y1 y2))): using the above result : (y1 y2)
;(pair? (car '(a short list))) : the car evaluate to the symbol a, which is not a pair : false
;(memq 'red '((red shoes) (blue socks))) : the car of the list evaluate to (red shoes), which is not red, so : false
;(memq 'red '(red shoes blue socks)) : from the definition of memq, the car of the list is red, so the sublist is the list itself : (red shoes blue socks)

