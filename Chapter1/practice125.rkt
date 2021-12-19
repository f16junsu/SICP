#lang racket

;fast-expt procedure
(define (fast-expt a n)
    (cond ((= n 0) 1)
          ((even? n) (sqr (fast-expt a (/ n 2))))
          (else (* a (fast-expt a (- n 1))))))

;To implement Fermat test
(define (expmod base exp m) ;밑 지수 법
    (remainder (fast-expt base exp) m))
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
;(timed-prime-test 100043)
(prime? 561)