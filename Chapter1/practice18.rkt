#lang racket

(define (sqrt3-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt3-iter (improve guess x) x)))

(define (improve guess x)
    (/ (+ (* 2 guess) (/ x (sqr guess))) 3))

(define (good-enough? guess x) 
    (= (improve guess x) guess))

(define (sqrt3 x)
    (sqrt3-iter 1.0 x))

(sqrt3 1000000000000)

