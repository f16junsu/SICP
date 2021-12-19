#lang racket

;To implement Fermat test
(define (expmod base exp m) ;밑 지수 법
    (cond ((= exp 0) 1)
          ((even? exp) (remainder (sqr (expmod base (/ exp 2) m)) m))
          (else (remainder (* base (expmod base (- exp 1) m)) m))))
(define (fermat-test n)
    (define (try-it a) (= (expmod a n n) a))
    (try-it (+ 1 (random (- n 1)))))

;prime procedure with Fermat test
(define (fast-prime? n times)
    (cond ((= times 0) #t)
          ((fermat-test n) (fast-prime? n (- times 1)))
          (else #f)))
(define (prime? n) (fast-prime? n 100))

;measuring time procedure
(define (timed-prime-test n)
    (newline)
    (display n)
    (start-prime-test n (current-inexact-milliseconds)))
(define (start-prime-test n start-time)
    (if (prime? n)
        (report-prime (- (current-inexact-milliseconds) start-time))
        (display "It's not a prime number.")))
(define (report-prime elapsed-time) 
    (display " *** ")
    (display elapsed-time))
    

;Main
#| (define (iter a b c f) (f a) (f b) (f c))
(iter 1009 1013 1019 timed-prime-test)
(iter 10007 10009 10037 timed-prime-test)
(iter 100003 100019 100043 timed-prime-test)
(iter 10000019 10000079 10000103 timed-prime-test)
(iter 100000007 100000037 100000039 timed-prime-test)
(iter 1000000007 1000000009 1000000021 timed-prime-test) |#
(expmod 3 560 561)