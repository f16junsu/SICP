#lang racket

(define (append x y)
    (if (null? x) y (cons (car x) (append (cdr x) y))))

(define (deep-reverse l)
    (cond ((pair? l) (append (deep-reverse (cdr l)) (list (deep-reverse (car l)))))
          (else l)))

;test
(deep-reverse '((1 2 3) (4 5 (6 7))))