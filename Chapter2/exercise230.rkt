#lang racket

(define (square-tree l)
    (map (lambda (sub)
            (if (pair? sub)
                (square-tree sub)
                (sqr sub))) l))

(define (square-tree2 l)
    (cond ((null? l) l)
          ((not (pair? l)) (sqr l))
          (else (cons (square-tree2 (car l)) (square-tree2 (cdr l))))))
;test
(square-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))
(square-tree2 (list 1 (list 2 (list 3 4) 5) (list 6 7)))