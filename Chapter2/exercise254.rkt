#lang racket

(define (equal? v1 v2)
    (cond ((eq? v1 v2) #t)
          ((and (pair? v1) (pair? v2)) (and (equal? (car v1) (car v2)) (equal? (cdr v1) (cdr v2))))
          (else #f)))

(equal? '(this is a list) '(this (is a) list))