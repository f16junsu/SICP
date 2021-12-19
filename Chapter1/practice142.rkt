#lang racket

(define (compose f g)
    (lambda (x) (f (g x))))

(define (inc i) (+ i 1))
((compose sqr inc) 6)