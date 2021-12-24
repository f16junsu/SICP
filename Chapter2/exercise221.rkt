#lang racket

(define (square-list1 items)
    (if (null? items)
        '()
        (cons (sqr (car items)) (square-list1 (cdr items)))))

(define (square-list2 items)
    (map sqr items))

;test
(square-list1 (list 1 2 3))
(square-list2 (list 1 2 3))