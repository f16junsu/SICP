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

(define (search-for-primes start end cnt)
    (cond ((= cnt 0) (display "All Found"))
          ((= start end) (display "Not enough range")) 
          ((prime? start) (display start) (display " ") (search-for-primes (+ start 2) end (- cnt 1)))
          (else (search-for-primes (+ start 2) end cnt))))

;(search-for-primes 1001 9999 3) 1009 1013 1019
;(search-for-primes 10001 99999 3) 10007 10009 10037
;(search-for-primes 100001 999999 3) 100003 100019 100043
;(search-for-primes 1000001 9999999 3) 1000003 1000033 1000037

;(search-for-primes 10000001 99999999 3) 10000019 10000079 10000103
;(search-for-primes 100000001 999999999 3) 100000007 100000037 100000039
;(search-for-primes 1000000001 9999999999 3) 1000000007 1000000009 1000000021
;(search-for-primes 10000000001 99999999999 3) 10000000019 10000000033 10000000061
(define (iter a b c f) (f a) (f b) (f c))
;(iter 1009 1013 1019 timed-prime-test)
;(iter 10007 10009 10037 timed-prime-test)
;(iter 100003 100019 100043 timed-prime-test)
;(iter 1000003 1000033 1000037 timed-prime-test)
(iter 10000019 10000079 10000103 timed-prime-test)
(iter 100000007 100000037 100000039 timed-prime-test)
(iter 1000000007 1000000009 1000000021 timed-prime-test)
(iter 10000000019 10000000033 10000000061 timed-prime-test)