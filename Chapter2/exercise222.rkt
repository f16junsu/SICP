#lang racket

(define (square-list items)
    (define (iter things answer)
        (if (null? things)
            answer
            (iter (cdr things)
                  (cons answer
                        (sqr (car things))))))
    (iter items '()))

;test
(square-list (list 1 2 3))