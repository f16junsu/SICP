#lang racket

;point
(define (make-point x y) (cons x y))
(define (x_point point) (car point))
(define (y_point point) (cdr point))

;segment
(define (make-segment p1 p2) (cons p1 p2))
(define (start_segment s) (car s))
(define (end_segment s) (cdr s))

;segment operation
(define (midpoint_segment s)
    (define (average a b) (/ (+ a b) 2.0))
    (let ((p1 (start_segment s)) (p2 (end_segment s)))
        (make-point (average (x_point p1) (x_point p2))
                    (average (y_point p1) (y_point p2)))))
(define (print-point p)
    (display "(")
    (display (x_point p))
    (display ",")
    (display (y_point p))
    (display ")")
    (newline))





;test
(define p1 (make-point 2 4))
(define p2 (make-point 4 8))
(define mid (midpoint_segment (make-segment p1 p2)))

(print-point p1)
(print-point p2)
(print-point mid)