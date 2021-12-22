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

### Exercise 2.4
* 다음과 같은 순서로 적용되어 car의 기능이 수행된다.
```racket
(car (cons 3 6))
((cons 3 6) (lambda (p q) p))
((lambda (m) (m 3 6)) (lambda (p q) p))
((lambda (p q) p) 3 6)
3
```
* cdr은 다음과 같다.
```racket
(define (cdr z)
    (z (lambda (p q) q)))
```

### Exercise 2.5
```racket
(define (cons2 a b)
    (* (expt 2 a) (expt 3 b)))

(define (car z) (exp-num z 2))
(define (cdr z) (exp-num z 3))

(define (exp-num num k)
    (if (= (remainder num k) 0)
        (+ 1 (exp-num (/ num k) k))
        0))
```

### Exercise 2.6
```racket
(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n)
    (lambda (f) (lambda (x) (f ((n f) x)))))
(define one (lambda (f) (lambda (x) (f x))))
(define two (lambda (f) (lambda (x) (f (f x)))))
(define (add a b) (lambda (f) (lambda (x) ((a f) ((b f) x)))))
```

### Exercise 2.7
```racket
(define (lower-bound i) (car i))
(define (upper-bound i) (cdr i))
```

### Exercise 2.8
```racket
(define (sub-interval x y)
    (add-interval x (make-interval (- (upper-bound y)) (- (lower-bound y)))))
```

### Exercise 2.9
Trivial

### Exercise 2.10
```racket
(define (div-interval x y)
    (let ((ly (lower-bound y)) (uy (upper-bound y)))
        (if (<= (* ly uy) 0)
            (error "Spans 0 in dividing interval")
            (mul-interval x (make-interval (/ 1.0 uy) (/ 1.0 ly))))))
```

### Exercise 2.11
```racket
(define (mul-interval x y)
    (define (check i)
        (let ((l (lower-bound i)) (u (upper-bound i)))
            (cond ((>= l 0) 1)
                  ((< u 0) -1)
                  (else 0))))
    (let ((lx (lower-bound x)) (ux (upper-bound x))
          (ly (lower-bound y)) (uy (upper-bound y))
          (tx (check x)) (ty (check y)))
        (cond ((and (= tx 1) (= ty 1)) (make-interval (* lx ly) (* ux uy)))
              ((and (= tx 1) (= ty 0)) (make-interval (* ux ly) (* ux uy)))
              ((and (= tx 1) (= ty -1)) (make-interval (* ux ly) (* lx uy)))
              ((and (= tx 0) (= ty 1)) (make-interval (* lx uy) (* ux uy)))
              ((and (= tx 0) (= ty 0)) (make-interval (min (* ux ly) (* lx uy))
                                                      (max (* ux uy) (* lx ly))))
              ((and (= tx 0) (= ty -1)) (make-interval (* ux ly) (* lx ly)))
              ((and (= tx -1) (= ty 1)) (make-interval (* lx uy) (* ux ly)))
              ((and (= tx -1) (= ty 0)) (make-interval (* lx uy) (* lx ly)))
              ((and (= tx -1) (= ty -1)) (make-interval (* ux uy) (* lx ly))))))
```
* 구간의 부호 종류를 1, 0, -1로 표시하여 총 9개의 케이스로 나누었다.
