#lang racket

(define (fast-expt-iter b n)
    (define (iter a k pow)
        (cond ((= pow 0) a)
              ((even? pow) (iter a (sqr k) (/ pow 2)))
              (else (iter (* a k) k (- pow 1)))))
    (iter 1 b n))

(fast-expt-iter 2 10)