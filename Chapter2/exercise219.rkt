#lang racket

(define us-coins (list 50 25 10 5 1))
(define no-more? null?)
(define except-first-denomination cdr)
(define first-denomination car)

(define (cc amount coin-values)
    (cond ((= amount 0) 1)
          ((or (< amount 0) (no-more? coin-values)) 0)
          (else 
            (+ (cc amount
                    (except-first-denomination coin-values))
               (cc (- amount
                        (first-denomination coin-values)) coin-values)))))

(cc 100 us-coins)