#lang racket

(define (cont-frac n d k)
    (define (recur s)
        (if (= s k)
            (/ (n s) (d s))
            (/ (n s) (+ (d s) (recur (+ s 1))))))
    (recur 1))

(define (cont-frac-iter n d k)
    (define (iter i result)
        (if (= i 0)
            result
            (iter (- i 1) (/ (n i) (+ (d i) result)))))
    (iter k 0))

(define (tan-cf x k)
    (cont-frac
        (lambda (i) (if (= i 1) x (- (sqr x))))
        (lambda (i) (- (* 2 i) 1))
        k))

(exact->inexact (tan-cf (/ pi 4.0) 15))