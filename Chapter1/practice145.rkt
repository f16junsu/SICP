#lang racket

;fixed-point
(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    (define (try guess)
        (let ((next (f guess)))
            (if (close-enough? guess next)
                next
                (try next))))
    (try first-guess))
(define tolerance 0.00001)

;repeated
(define (compose f g)
    (lambda (x) (f (g x))))
(define (repeated f n)
    (if (= n 1) f (compose f (repeated f (- n 1)))))

;average-damp
(define (average-damp f); x|->1/2(x f(x))
    (lambda (x) (/ (+ x (f x)) 2)))
(define (n-folded-damped f n)
    (lambda (x) (((repeated average-damp n) f) x)))

(define (n-th-root x n)
    (fixed-point (n-folded-damped (lambda (y) (/ x (expt y (- n 1)))) 2) 1.0))

(n-th-root 64 3)