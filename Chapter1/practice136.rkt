#lang racket

(define tolerance 0.00001)
(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    (define average (lambda (x y) (/ (+ x y) 2.0)))
    (define (try guess)
        (display guess)
        (newline)
        (let ((next (average (f guess) guess)))
            (if (close-enough? guess next)
                next
                (try next))))
    (try first-guess))

(fixed-point (lambda (x) (/ (log 1000) (log x))) 4.0)