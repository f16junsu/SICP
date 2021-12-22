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

### Exercise 2.12
```racket
(define (make-center-percent c p)
    (make-center-width c ((/ (* c p) 100))))
(define (percent i)
    (* (/ (width i) (center i)) 100))
```

### Exercise 2.13
두 구간을 $i_1 = (c_1-w_1, c_1+w_1)$, $i_2 = (c_2-w_2, c_2+w_2)$라 하고 각 오차퍼센트를 $p_1 = {\frac{w_1}{c_1}} \times {100}$, $p_2 = \frac{w_2}{c_1} \times 100$이라 하자. 곱했을 때의 구간은 $i_3 = (c_1c_2-w_1c_2-w_2c_1+w_1w_2, c_1c_2+w_1c_2+w_2c_1+w_1w_2)$이다. 이로부터 오차퍼센트를 구하면 
$p_3 = \frac{w_1c_2+w_2c_1}{c_1c_2 + w_1w_2} \times 100$이다. 분자, 분모를 $c_1c_2$로 나눠주면 $p_3 = \frac{\frac{w_1}{c_1} + \frac{w_2}{c_2}}{1 + \frac{w_1w_2}{c_1c_2}} \times 100$이며 이를 정리하면 $p_3 = \frac{p_1 + p_2}{10^4 + p_1p_2}$이다. $10^4 \gg p_1p_2$이므로 어림잡아 $p_3 = \frac{p_1+p_2}{100}$이라고 할 수 있다.

### Exercise 2.14~2.16
대수적으로 성립하는 법칙들이 구간 산술에서는 성립하지 않는 것들이 많다. A / A와 A / B에 관한 것도 그렇다. 대수적으로  A / A는 1이지만 구간 산술에서는 그조차 범위가 생기게 된다. 단적으로 말해서, 구간 산술에서는 분배 법칙이나 교환 법칙 등이 성립하지 않기 때문에 대수적으로 같은 식이더라도 그 순서와 변수의 등장 개수에 따라 구간은 천차만별로 계산된다. 이 구간 산술 문제는 여러가지 연구를 통해 다양한 기법들이 개발되어 그 정확성을 높이고 있지만, 근본적으로는 해결 불가능한 문제로 보인다. 적어도 이 챕터에서 글쓴이는 이 수학적인 내용보다는 아무튼 어떤 데이터를 정의하는데 있어서 그 결과만 같다면 추상화를 할 수 있는 방법은 다양하다는 것을 얘기하고 있다.(경고대로, 이건 수학적으로 겁나 어려운 문제이다.)

### Exercise 2.17
```racket
(define (last-pair l)
    (if (null? (cdr l)) l (last-pair (cdr l))))
```

### Exercise 2.18
```racket
(define (append l1 l2)
    (if (null? (cdr l1)) 
        (cons (car l1) l2)
        (cons (car l1) (append (cdr l1) l2))))
        
(define (reverse l)
    (if (null? (cdr l)) l (append (reverse (cdr l)) (list (car l)))))
```
* 참고로 저 append 자리에 왜 cons를 쓰면 안되는 것인지는 다음 실행 결과를 보면 안다.
```racket
(cons (list 1 2) 3); '((1 2) 3)
```

### Exercise 2.19
```racket
(define no-more? null?)
(define except-first-denomination cdr)
(define first-denomination car)
```
* 의미 자체는 좀 덜 명확한 감이 있다. list 인자를 받는다는 것을 명시하는 것이 좋다.
### Exercise 2.20
```racket
(define (same-parity . ls)
    (define (recur filter l)
        (cond ((null? l) '())
              ((filter (car l)) (cons (car l) (recur filter (cdr l))))
              (else (recur filter (cdr l)))))
    (if (even? (car ls)) (recur even? ls) (recur odd? ls)))
```
* append와 다르게 cons는 첫번째 인자로써 리스트 앞에 붙일 원소를, 두번째 인자로써 첫번째 인자를 앞에 붙일 리스트가 건네야하기 때문에 재귀함수를 작성할때 주의해야 한다.