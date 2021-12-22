#lang racket

(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n)
    (lambda (f) (lambda (x) (f ((n f) x)))))
(define one (lambda (f) (lambda (x) (f x))))
(define two (lambda (f) (lambda (x) (f (f x)))))
(define (add a b) (lambda (f) (lambda (x) ((a f) ((b f) x)))))

#| (add-1 zero)
((lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) x)) f) x)))))
((lambda (f) (lambda (x) (f ((lambda (x) x) x)))))
((lambda (f) (lambda (x) (f x)))) |#

(add-1 ((zero (lambda (x) (+ 1 x))) 0))