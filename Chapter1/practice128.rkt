#lang racket

(define (expmod base exp m);밑 지수 법
    (define (check k)
        (define trivial? (or (= k 1) (= k (- m 1))))
        (if (and (= (remainder (sqr k) m) 1) (not trivial?)) 0 k))
    (cond ((= exp 0) 1)
          ((even? exp) (remainder (sqr (check (expmod base (/ exp 2) m))) m))
          (else (remainder (* base (expmod base (- exp 1) m)) m))))

(define (fermat-test n a)
    (define result (expmod a (- n 1) n))
    (if (= result 0) #f (= result 1)))

;(fermat-test 561 3)
(expmod 3 560 561)

