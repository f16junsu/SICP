# Exercise2
* * *
### Exercise 2.1
```racket
;GCD
(define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))

;rational number definition
(define (make-rat n d)
    (let ((n_ (abs n)) (d_ (abs d)) (g (abs (gcd n d)))) 
        (if (< (* n d) 0) 
            (cons (/ (- n_) g) (/ d_ g)) 
            (cons (/ n_ g) (/ d_ g)))))
(define (numer x) (car x))
(define (denom x) (cdr x))
```

### Exercise 2.2
```racket
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
```
% 편의상 constructor는 중간에 -로, selector나 연산 프로시저는 중간에 _ 로 구분지었음.

### Exercise 2.3
a. version 1
```racket
;rectangle
(define (make-rectangle bottom-left-point top-right-point)
    (cons bottom-left-point top-right-point))
(define (bottom-left-point_rectangle r) (car r))
(define (top-right-point_rectangle r) (cdr r))

(define (width_rectangle r)
    (- (x_point (top-right-point_rectangle r)) (x_point (bottom-left-point_rectangle r))))
(define (height_rectangle r)
    (- (y_point (top-right-point_rectangle r)) (y_point (bottom-left-point_rectangle r))))

;perimeter and area
(define (perimeter_rectangle r)
    (* 2 (+ (width_rectangle r) (height_rectangle r))))
(define (area_rectangle r)
    (* (width_rectangle r) (height_rectangle r)))
```

b. version 2
```racket
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

;perimeter and area same as version 1
(define (perimeter_rectangle r)
    (* 2 (+ (width_rectangle r) (height_rectangle r))))
(define (area_rectangle r)
    (* (width_rectangle r) (height_rectangle r)))
```