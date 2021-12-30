#lang racket

;accumulate
(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence) (accumulate op initial (cdr sequence)))))

;enumerate-interval
(define (enumerate-interval low high)
    (if (> low high) 
        '() 
        (cons low (enumerate-interval (+ low 1) high))))

;filter
(define (filter predicate sequence)
    (cond ((null? sequence) '())
          ((predicate (car sequence))
                (cons (car sequence) (filter predicate (cdr sequence))))
          (else (filter predicate (cdr sequence)))))

;flatmap
(define (flatmap proc seq) (accumulate append '() (map proc seq)))

;prime?
(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-divisor)
    (cond ((> (sqr test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b) (= (remainder b a) 0))
(define (prime? n) (= (smallest-divisor n) n))



;implementatiion
(define (is-sum-prime? p) (prime? (+ (car p) (cadr p))))
(define (unique-pairs n)
    (flatmap 
        (lambda (i) (map (lambda (j) (list i j)) (enumerate-interval 1 (- i 1))))
        (enumerate-interval 1 n)))
(define (make-pair-sum p) (list (car p) (cadr p) (+ (car p) (cadr p))))

(define (prime-sum-pairs n)
    (map make-pair-sum (filter is-sum-prime? (unique-pairs n))))

(prime-sum-pairs 6)