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
(define (count-leaves t)
    (accumulate + 0 
        (map (lambda (tr) (cond ((null? tr) 0)
                                ((pair? tr) (count-leaves tr)) 
                                (else 1))) t)))

;test
(count-leaves (list (list 0 1) (list (list 2)) 3 (list 4 5) '()))