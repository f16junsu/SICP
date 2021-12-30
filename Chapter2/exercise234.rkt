#lang racket

;filter
(define (filter predicate sequence)
    (cond ((null? sequence) '())
          ((predicate (car sequence))
            (cons (car sequence)
                  (filter predicate (cdr sequence))))
          (else (filter predicate (cdr (sequence))))))

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

;enumerate-tree
(define (enumerate-tree tree)
    (cond ((null?) tree)
          ((not (pair? tree)) (list tree))
          (else (append (enumerate-tree (car tree)) (enumerate-tree (cdr tree))))))



;implementation
(define (horner-eval x coefficient-sequence)
    (accumulate (lambda (this-coeff higher-terms)
                    (+ this-coeff (* x higher-terms)))
                0
                coefficient-sequence))

;test
(horner-eval 2 (list 1 3 0 5 0 1))