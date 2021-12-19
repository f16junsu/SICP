#lang racket

(define (expmod base exp m) ;밑 지수 법
    (cond ((= exp 0) 1)
          ((even? exp) (remainder (sqr (expmod base (/ exp 2) m)) m))
          (else (remainder (* base (expmod base (- exp 1) m)) m))))

(define (test start n)
    (cond ((= start n) (display "end") (newline))
          ((= (expmod start n n) start) 
            (display start) (newline) (test (+ start 1) n))
          (else (test (+ start 1) n))))

(test 1 1000)