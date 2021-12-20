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
(define (start-point_segment s) (car s))
(define (end-point_segment s) (cdr s))

;segment operation
(define (midpoint_segment s)
    (define (average a b) (/ (+ a b) 2.0))
    (let ((p1 (start-point_segment s)) (p2 (end-point_segment s)))
        (make-point (average (x_point p1) (x_point p2))
                    (average (y_point p1) (y_point p2)))))

;rectangle
(define (make-rectangle left-segment bottom-segment) (cons left-segment bottom-segment))
(define (left_rectangle r) (car r))
(define (bottom_rectangle r) (cdr r))
(define (width_rectangle r)
    (let ((s (start-point_segment (bottom_rectangle r))) 
          (e (end-point_segment (bottom_rectangle r))))
        (- (x_point e) (x_point s))))
(define (height_rectangle r)
    (let ((s (start-point_segment (left_rectangle r)))
          (e (end-point_segment (left_rectangle r))))
          (- (y_point e) (y_point s))))

(define (perimeter_rectangle r)
    (* 2 (+ (width_rectangle r) (height_rectangle r))))
(define (area_rectangle r)
    (* (width_rectangle r) (height_rectangle r)))

;test
(let ((r (make-rectangle 
            (make-segment (make-point 2 3) (make-point 2 4))
            (make-segment (make-point 2 3) (make-point 3 3)))))
    (display (perimeter_rectangle r))
    (newline)
    (display (area_rectangle r)))