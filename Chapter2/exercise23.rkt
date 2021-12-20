#lang racket

;point
(define (make-point x y) (cons x y))
(define (x_point point) (car point))
(define (y_point point) (cdr point))

;point operation
(define (print-point p)
    (display "(")
    (display (x_point p))
    (display ",")
    (display (y_point p))
    (display ")")
    (newline))

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

;rectangle
(define (make-rectangle bottom-left-point top-right-point)
    (cons bottom-left-point top-right-point))
(define (bottom-left-point_rectangle r) (car r))
(define (top-right-point_rectangle r) (cdr r))
#| (define (bottom-right-point_rectangle r)
    (make-point 
        (x_point (top-right-point_rectangle r)) 
        (y_point (bottom-left-point_rectangle r))))
(define (top-left-point_rectangle r)
    (make-point
        (x_point (bottom-left-point_rectangle r))
        (y_point (top-right-point_rectangle r)))) |#
(define (width_rectangle r)
    (- (x_point (top-right-point_rectangle r)) (x_point (bottom-left-point_rectangle r))))
(define (height_rectangle r)
    (- (y_point (top-right-point_rectangle r)) (y_point (bottom-left-point_rectangle r))))

(define (perimeter_rectangle r)
    (* 2 (+ (width_rectangle r) (height_rectangle r))))
(define (area_rectangle r)
    (* (width_rectangle r) (height_rectangle r)))


;test
(let ((r (make-rectangle 
            (make-point 2 3)
            (make-point 3 4))))
    (display (perimeter_rectangle r))
    (newline)
    (display (area_rectangle r)))