#lang racket
;       1
;      1 1
;     1 2 1
;    1 3 3 1
;   1 4 6 4 1

(define (pascal row col)
    (if (or (= col 1) (= col row)) 
        1
        (+ (pascal (- row 1) (- col 1)) (pascal (- row 1) col))))

(pascal 5 3)