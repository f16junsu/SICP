#lang racket

(define (for-each2 f l)
    (define (iter ls)
        (if (null? ls) 
            #t
            (begin (f (car ls)) (iter (cdr ls)))))
    (iter l))


(define (for-each3 f l)
    (define (f-augmented p)
        (lambda (x) (p x) x))
    (map (f-augmented f) l))

;test
;(for-each3 (lambda (x) (display x) (newline)) (list 57 321 88))
(map (lambda (x) (display x) (newline)) (list 1 2 3))