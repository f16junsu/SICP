#lang racket

(define (cont-frac n d k)
    (define (recur s)
        (if (= s k)
            (/ (n s) (d s))
            (/ (n s) (+ (d s) (recur (+ s 1))))))
    (recur 1))

(define euler-e 
    (+ 2 (cont-frac (lambda (x) 1.0)
               (lambda (x)
                    (if (= 2 (remainder x 3))
                        (* 2 (+ 1 (quotient x 3)))
                        1))
                15)))
(display euler-e)