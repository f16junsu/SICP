#lang racket

(define (last-pair l)
    (if (null? (cdr l)) l (last-pair (cdr l))))

;test
(last-pair (list 1 2 3 4))