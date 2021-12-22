#lang racket

(define (cons2 a b)
    (* (expt 2 a) (expt 3 b)))

(define (exp-num num k)
    (if (= (remainder num k) 0)
        (+ 1 (exp-num (/ num k) k))
        0))

(define (car2 z) (exp-num z 2))
(define (cdr2 z) (exp-num z 3))

(car2 (cons2 3 6))
(cdr2 (cons2 3 6))