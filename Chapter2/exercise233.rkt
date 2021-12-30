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

(define (map1 p sequence)
    (accumulate (lambda (x y) (cons (p x) y)) '() sequence))

(define (append1 seq1 seq2)
    (accumulate cons seq2 seq1))

(define (length1 sequence)
    (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

;test
(map1 (lambda (x) (+ x 1)) (list 1 2 3 4))
(append1 (list 1 2 3) (list 4))
(length (list 1 2 3 4))