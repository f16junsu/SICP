#lang racket

(define (append x y)
    (if (null? x) y (cons (car x) (append (cdr x) y))))

(define (fringe l)
    (cond ((null? l) l)
          ((not (pair? l)) (list l))
          (else (append (fringe (car l)) (fringe (cdr l))))))

;test
(fringe '((1 2 3) (4 5 (6 7))))