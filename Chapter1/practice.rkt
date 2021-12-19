#lang racket

(define (fun x y z) 
    (cond 
        ((and (> x z) (> y z)) (+ (* x x) (* y y)))
        ((and (> x y) (> (z y))) (+ (* x x) (* z z)))
        (else (+ (* y y) (* z z)))
    )
)

(define (p) (p))

(define (factorial n)
    (define (iter product counter)
        (if (> counter n)
            product
            (iter (* counter product) (+ counter 1))))
    (iter 1 1))

