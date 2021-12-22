#lang racket

(define (same-parity . ls)
    (define (recur filter l)
        (cond ((null? l) '())
              ((filter (car l)) (cons (car l) (recur filter (cdr l))))
              (else (recur filter (cdr l)))))
    (if (even? (car ls)) (recur even? ls) (recur odd? ls)))

(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7 8)
(same-parity 1)