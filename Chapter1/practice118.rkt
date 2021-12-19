#lang racket

(define (double x) (+ x x))
(define (halve x) (/ x 2))

(define (fast-mul-iter a b)
    (define (iter result i j)
        (cond ((= j 0) result)
              ((even? j) (iter result (double i) (halve j)))
              (else (iter (+ result i) i (- j 1)))))
    (iter 0 a b))

(fast-mul-iter 5 4)