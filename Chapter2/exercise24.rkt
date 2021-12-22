#lang racket

(define (cons2 x y)
    (lambda (m) (m x y)))

(define (car2 z)
    (z (lambda (p q) p)))

(define (cdr2 z)
    (z (lambda (p q) q)))

;test
(cdr2 (cons2 3 6))