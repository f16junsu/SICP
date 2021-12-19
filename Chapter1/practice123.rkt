#lang racket

;divisor
(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-divisor)
    (cond ((> (sqr test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b) (= (remainder b a) 0))

;prime procedure
(define (prime? n) (= (smallest-divisor n) n))

;measuring time procedure
(define (timed-prime-test n)
    (newline)
    (display n)
    (start-prime-test n (current-inexact-milliseconds)))
(define (start-prime-test n start-time)
    (if (prime? n)
        (report-prime (- (current-inexact-milliseconds) start-time))
        '()))
(define (report-prime elapsed-time) 
    (display " *** ")
    (display elapsed-time))

;divisor procedure improved
(define (next n) (if (= n 2) 3 (+ n 2)))
(define (smallest-divisor2 n) (find-divisor2 n 2))
(define (find-divisor2 n test-divisor)
    (cond ((> (sqr test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor2 n (next test-divisor)))))

;prime procedure improved
(define (prime2? n) (= (smallest-divisor2 n) n))

;measuring time procedure improved
(define (timed-prime-test2 n)
    (newline)
    (display n)
    (start-prime-test2 n (current-inexact-milliseconds)))
(define (start-prime-test2 n start-time)
    (if (prime2? n)
        (report-prime (- (current-inexact-milliseconds) start-time))
        '()))

;searching primes procedure
(define (search-for-primes start end cnt)
    (cond ((= cnt 0) (display "All Found"))
          ((= start end) (display "Not enough range")) 
          ((prime? start) (display start) (display " ") (search-for-primes (+ start 2) end (- cnt 1)))
          (else (search-for-primes (+ start 2) end cnt))))

;(search-for-primes 10000001 99999999 3) 10000019 10000079 10000103
;(search-for-primes 100000001 999999999 3) 100000007 100000037 100000039
;(search-for-primes 1000000001 9999999999 3) 1000000007 1000000009 1000000021
;(search-for-primes 10000000001 99999999999 3) 10000000019 10000000033 10000000061
(define (iter2 f g a b c) (f a) (g a) (f b) (g b) (f c) (g c))
(iter2 timed-prime-test timed-prime-test2 10000019 10000079 10000103)
(iter2 timed-prime-test timed-prime-test2 100000007 100000037 100000039)
(iter2 timed-prime-test timed-prime-test2 1000000007 1000000009 1000000021)
(iter2 timed-prime-test timed-prime-test2 10000000019 10000000033 10000000061)
