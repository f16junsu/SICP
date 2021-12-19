#lang racket

(define (accumulate combiner null-value term a next b)
    (if (> a b)
        null-value
        (combiner (term a) 
                  (accumulate combiner null-value term (next a) next b))))

(define (accumulate_iter combiner null-value term a next b)
    (define (iter a result)
        (if (> a b)
            result
            (iter (next a) (combiner result (term a)))))
    (iter a null-value))

(define (sum term a next b)
    (accumulate_iter + 0 term a next b))
(define (product term a next b)
    (accumulate_iter * 1 term a next b))

(define (give x) x)
(define (inc x) (+ 1 x))
(sum give 1 inc 10)
(product give 1 inc 5)