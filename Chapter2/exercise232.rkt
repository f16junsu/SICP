#lang racket

(define (append l1 l2)
    (if (null? l1) l2
        (cons (car l1) (append (cdr l1) l2))))

(define (subsets s)
    (if (null? s)
        (list '())
        (let ((rest (subsets (cdr s))))
            (append rest (map (lambda (l) (cons (car s) l)) rest)))))

(subsets (list 1 2 3))