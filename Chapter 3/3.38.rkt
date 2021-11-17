#lang sicp
;==============================3.38==================================

;a)
; (Peter -> Paul  -> Mary):  45
; (Peter -> Mary  -> Paul):  35
; (Paul  -> Peter -> Mary):  45
; (Paul  -> Mary  -> Peter): 50
; (Mary  -> Peter -> Paul):  40
; (Mary  -> Paul  -> Peter): 40

;b)
;  (Mary access Balance : 100)    (Peter access Balance : 100)
;   |                             (Peter New-value : 110)
;  (Mary New-value : 50)           |                              (Paul access Balance : 100)
;   |                             (Peter Set-balance to 110)       |
;  (Mary Set-balance to 50)                                       (Paul New-value : 80)
;                                                                 (Paul Set-balance to 80)      
; 
; Final balance is 80.
