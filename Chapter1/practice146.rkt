#lang racket

(define (iterative-improve improvingf good-enough?)
    (define (recur guess) 
        (if (good-enough? guess)
            (improvingf guess)
            (recur (improvingf guess))))
    recur)

(define (fixed-point f first-guess)
    (define tolerance 0.00001)
    (define (improve x) (f x))
    (define (close-enough? v) (< (abs (- v (improve v))) tolerance))
    ((iterative-improve improve close-enough?) first-guess))

(define (sqrt- x)
    (define tolerance 0.00001)
    (define first-guess 1.0)
    (define (improve guess) (/ (+ guess (/ x guess)) 2))
    (define (close-enough? v) (< (abs (- (sqr v) x)) tolerance))
    ((iterative-improve improve close-enough?) first-guess))

(define (average-damp f); x|->1/2(x f(x))
    (lambda (x) (/ (+ x (f x)) 2)))
(define (root x) (fixed-point (average-damp (lambda (y) (/ x y))) 1.0))
(root 4)
(sqrt- 4)