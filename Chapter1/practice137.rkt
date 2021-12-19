#lang racket

(define (cont-frac-iter n d k)
    (define (iter i result)
        (if (= i 0)
            result
            (iter (- i 1) (/ (n i) (+ (d i) result)))))
    (iter k 0))

(define (cont-frac n d k)
    (define (recur s)
        (if (= s k)
            (/ (n s) (d s))
            (/ (n s) (+ (d s) (recur (+ s 1))))))
    (recur 1))

(cont-frac-iter (lambda (i) 1.0)
           (lambda (i) 1.0)
           12)
(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           12)
(/ 1 1.6180327868852458)