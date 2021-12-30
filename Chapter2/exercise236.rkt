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


;accumulate-n implementation
(define (accumulate-n op init seqs)
    (if (null? (car seqs))
        '()
        (cons (accumulate op init (map car seqs))
              (accumulate-n op init (map cdr seqs)))))

(define (firsts l) (if (null? l) '() (cons (car (car l)) (firsts (cdr l)))))
(define (lefters l) (if (null? l) '() (cons (cdr (car l)) (lefters (cdr l)))))

;test
(accumulate-n + 0 '((1 2 3) (4 5 6) (7 8 9) (10 11 12)))