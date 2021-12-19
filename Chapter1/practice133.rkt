#lang racket

(define (accumulate combiner null-value term a next b)
    (if (> a b)
        null-value
        (combiner (term a) 
                  (accumulate combiner null-value term (next a) next b))))

(define (filtered-accumulate filter combiner null-value term a next b)
    (cond ((> a b) null-value)
          ((filter a) (combiner (term a) (filtered-accumulate filter combiner null-value term (next a) next b)))
          (else (combiner null-value (filtered-accumulate filter combiner null-value term (next a) next b)))))

;divisor
(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-divisor)
    (cond ((> (sqr test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b) (= (remainder b a) 0))

;prime procedure
(define (prime? n) (= (smallest-divisor n) n))

(define (sum-of-squared-primes a b)
    (define (inc n) (+ 1 n))
    (filtered-accumulate prime? + 0 sqr a inc b))

(define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))

(define (product-of-relatively-prime-numbers n)
    (define (relative-prime? b) (= (gcd n b) 1))
    (define (inc x) (+ 1 x))
    (define (give x) x)
    (filtered-accumulate relative-prime? * 1 give 1 inc n))
