#lang racket

(define (tree-map pro t)
    (map (lambda (sub)
            (if (pair? sub)
                (tree-map pro sub)
                (pro sub))) t))

(define (square-tree tree) (tree-map sqr tree))

;test
(square-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))