#lang racket

(define (product f a b)
    (if (> a b)
        1
        (* (f a) (product f (+ a 1) b))))
    
(define (product_iter f a b )
    (define (iter i result)
        (if (> i b)
            result
            (iter (+ i 1) (* (f i) result))))
    (iter a 1))

(define (func n)
    (if (even? n)
        (/ n (- n 1))
        (/ (- n 1) n)))

;(exact->inexact (* 4 (product func 3 100000)))
(exact->inexact (* 4 (product_iter func 3 100000)))
