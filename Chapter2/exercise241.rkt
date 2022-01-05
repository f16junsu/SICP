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



;exercise implementation
(define (unique-triples n)
    (flatmap (lambda (i)
                (flatmap (lambda (j) 
                            (map (lambda (k) (list i j k)) 
                                (enumerate-interval 1 (- j 1))))
                    (enumerate-interval 1 (- i 1))))
        (enumerate-interval 1 n)))

(define (sum-is-s-triples n s)
    (define (sum-s? t) (= (accumulate + 0 t) s))
    (filter sum-s? (unique-triples n)))


;test
(sum-is-s-triples 7 12)