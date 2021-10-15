#lang sicp
;To evaluate (car ''abracadabra), we remember that 'abc is a shorthand for (quote abc), thus
; the expression is read as (car '(quote abracadabra)). The quoted term is the list of symbols,
; which has car quote.
