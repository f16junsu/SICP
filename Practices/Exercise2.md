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

### Exercise 2.21
```racket
(define (square-list1 items)
    (if (null? items)
        '()
        (cons (sqr (car items)) (square-list1 (cdr items)))))

(define (square-list2 items)
    (map sqr items))
```
* 여기서 '()은 책에서 사용하는 nil과 같다. '연산자는 나중에 나올테지만 이는 표현식을 연산하지 않는다는 것을 의미한다. 즉 빈 리스트이다.

### Exercise 2.22
```racket
(define (square-list items)
    (define (iter things answer)
        (if (null? things)
            answer
            (iter (cdr things)
                  (cons (sqr (car things))
                        answer))))
    (iter items '()))
```
exercise 2.20에서 말했듯, 재귀나 반복문을 작성할 때 cons는 첫번째 인자를 두번째 인자(list)의 앞에 붙이는 것이기 때문에 순서에 주의해야된다.
```racket
(define (square-lis items)
    (define (iter things answer)
        (if (null? things)
            answer
            (iter (cdr things)
                  (cons answer
                        (sqr (car things))))))
    (iter items '()))
```
* 이와 같이 cons의 인자의 순서를 바꾸면 answer라는 리스트가 뒤의 있는 원소(리스트)의 앞에 붙여지기 때문에 원하지 않는 결과가 나올 것이다. 실제로 테스트 해보면 굉장히 특이한 꼴의 리스트가 나오는데 여기서 .은 파이썬의 언패키징이랑 비슷한 역할을 하는 것이 아닌가 하는 생각이 든다.

### Exercise 2.23
* 처음 생각한 아이디어
	- f를 그저 실행시키고 나머지 리스트에 대해 다시 iter하기 위해 begin을 사용...
```racket
(define (for-each2 f l)
    (define (iter ls)
        (if (null? ls) 
            #t
            (begin (f (car ls)) (iter (cdr ls)))))
    (iter l))
```
* begin을 사용하지 않기 위해 떠올린 아이디어
	- map을 사용하는데 f를 void가 아니게 하면 되지 않나라는 발상에 착안(사실 근데 함수 정의할때 implicit하게 begin이 들어있는거라 그닥 차이는 없다)
```racket
(define (for-each3 f l)
    (define (f-augmented p) (lambda (x) (p x) x))
    (map (f-augmented f) l))
```
* 여러 답들을 보니 구현할 수 있는 방법은 다양한 것 같다. 다만 근본적으로 map과 for-each는 다르다는 것을 얘기하고 싶었던 문제로 생각된다. 그래서 사실 for-each의 결과로는 무엇이 나와도 괜찮다고 한 이상 map의 구현 방식에 따라 아예 (define for-each map)을 해버려도 무방하다.

### Exercise 2.24
'(1 (2 (3 4)))

### Exercise 2.25
```racket
;a
(car (cdr (car (cdr (cdr '(1 3 (5 7) 9))))))
;b
(car (car '((7))))
;c
(define l (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7))))))); == '(1 (2 (3 (4 (5 (6 7))))))
(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr l))))))))))))
```

### Exercise 2.26
```racket
(define x (list 1 2 3))
(define y (list 4 5 6))

(append x y); '(1 2 3 4 5 6)
(cons x y); '((1 2 3) 4 5 6)
(list x y); '((1 2 3) (4 5 6))
```

### Exercise 2.27
```racket
(define (deep-reverse l)
    (cond ((pair? l) (append (deep-reverse (cdr l)) (list (deep-reverse (car l)))))
          (else l)))
```

### Exercise 2.28
```racket
(define (fringe l)
    (cond ((null? l) l)
          ((not (pair? l)) (list l))
          (else (append (fringe (car l)) (fringe (cdr l))))))
```
* 2.27과 2.28은 리스트 관련 알고리즘을 짤 때 cons와 append의 차이를 잘 생각해볼 수 있는 좋은 문제인것 같다. 특히 트리에 관해 재귀적으로 알고리즘을 구현할 때 연습해볼만 하다.

```racket
(define (make-mobile left right) (list left right))
(define (make-branch length structure) (list length structure))

;a.
(define (left-branch m) (car m))
(define (right-branch m) (car (cdr m)))
(define (branch-length b) (car b))
(define (branch-structure b) (car (cdr b)))

;b.
(define (total-weight m)
    (cond ((number? m) m);m이 사실 단일 branch의 weight일때
          ((not (pair? (left-branch m))) (total-weight (branch-structure m)));사실 m이 branch일때
          (else (+ (total-weight (left-branch m)) (total-weight (right-branch m))))))

;c.
(define (balanced? m)
    (cond ((number? m) #t) ;m이 그냥 weight일때
          ((not (pair? (left-branch m))) (balanced? (branch-structure m))) ;m이 사실 branch일때
          ((and (balanced? (left-branch m)) (balanced? (right-branch m))) ;양쪽 팔들이 각각 balanced일때
                (= (* (total-weight (left-branch m)) (branch-length (left-branch m)))
                   (* (total-weight (right-branch m)) (branch-length (right-branch m)))))
          (else #f)))
		  
;d. selector만 바꿔주면 된다.
(define (left-branch m) (car m))
(define (right-branch m) (cdr m))
(define (branch-length b) (car b))
(define (branch-structure b) (cdr b))
```

### Exercise 2.30
```racket
(define (square-tree l)
    (map (lambda (sub)
            (if (pair? sub)
                (square-tree sub)
                (sqr sub))) l))

(define (square-tree2 l)
    (cond ((null? l) l)
          ((not (pair? l)) (sqr l))
          (else (cons (square-tree2 (car l)) (square-tree2 (cdr l))))))
```

### Exercise 2.31
```racket
(define (tree-map pro t)
    (map (lambda (sub)
            (if (pair? sub)
                (tree-map pro sub)
                (pro sub))) t))
```

### Exercise 2.32
```racket
(define (subsets s)
    (if (null? s)
        (list '())
        (let ((rest (subsets (cdr s))))
            (append rest (map (lambda (l) (cons (car s) l)) rest)))))
```
* 재귀적인 알고리즘을 작성할 경우 이 알고리즘의 결과로 무엇이 나오는지 명시하는 것이 사고를 편하게 하는데 도움이 된다고 몇 번을 강조해도 지나치지 않은 것 같다. 어떤 집합의 부분집합은 한 원소를 포함하는 부분집합과 포함하지 않는 부분집합으로 나뉜다는 것을 이용한 알고리즘이다. 

### Exercise 2.33
```racket
(define (map1 p sequence)
    (accumulate (lambda (x y) (cons (p x) y)) '() sequence))

(define (append1 seq1 seq2)
    (accumulate cons seq2 seq1))

(define (length1 sequence)
    (accumulate (lambda (x y) (+ 1 y)) 0 sequence))
```

### Exercise 2.34
```racket
(define (horner-eval x coefficient-sequence)
    (accumulate (lambda (this-coeff higher-terms)
                    (+ this-coeff (* x higher-terms)))
                0
                coefficient-sequence))
```

### Exercise 2.35
```racket
(define (count-leaves t)
    (accumulate + 0 
        (map (lambda (tr) (cond ((null? tr) 0)
                                ((pair? tr) (count-leaves tr)) 
                                (else 1))) t)))
```

### Exercise 2.36
```racket
(define (accumulate-n op init seqs)
    (if (null? (car seqs))
        '()
        (cons (accumulate op init (map car seqs))
              (accumulate-n op init (map cdr seqs)))))
```

### Exercise 2.37
```racket
;dot-product
(define (dot-product v w)
    (accumulate + 0 (map * v w)))
;matrix-*-vector m v
(define (matrix-*-vector m v)
    (map (lambda (u) (dot-product u v)) m))
;transpose
(define (transpose mat)
    (accumulate-n cons '() mat))
;matrix-*-matrix
(define (matrix-*-matrix m n)
    (let ((cols (transpose n))) 
         (map (lambda (v) 
                (accumulate 
                    (lambda (x y) (cons (dot-product v x) y)) 
                        '() cols)) m)))
```
하지만 행렬의 곱과 행렬과 벡터의 곱의 관계를 잘 살펴보면 조금 더 간단하고 명확히 코드를 작성할 수 있다.
```racket
(define (matrix-*-matrix m n)
    (let ((cols (transpose n)))
        (map (lambda (v) (matrix-*-vector cols v)) m)))
```

### Exercise 2.38
```racket
(fold-right / 1 (list 1 2 3)); 3/2
(fold-left / 1 (list 1 2 3)); 1/6
(fold-right list '() (list 1 2 3)); '(1 (2 (3 ())))
(fold-left list '() (list 1 2 3)); '(((() 1) 2) 3)
```
fold-right과 fold-left의 결과가 같기 위해서는 op가 결합법칙과 교환법칙을 만족시켜야한다. 이유는 계산하는 순서를 들여다보면 알 수 있다.

### Exercise 2.39
```racket
(define (reverse-r sequence)
    (fold-right (lambda (x y) (append y (list x))) '() sequence))

(define (reverse-l sequence)
    (fold-left (lambda (x y) (cons y x)) '() sequence))
```

### Exercise 2.40
```racket
(define (is-sum-prime? p) (prime? (+ (car p) (cadr p))))
(define (unique-pairs n)
    (flatmap 
        (lambda (i) (map (lambda (j) (list i j)) (enumerate-interval 1 (- i 1))))
        (enumerate-interval 1 n)))
(define (make-pair-sum p) (list (car p) (cadr p) (+ (car p) (cadr p))))

(define (prime-sum-pairs n)
    (map make-pair-sum (filter is-sum-prime? (unique-pairs n))))
```

### Exercise 2.41
```racket
(define (unique-triples n)
    (flatmap (lambda (i)
                (flatmap (lambda (j) 
                            (map (lambda (k) (list i j k)) 
                                (enumerate-interval 1 (- j 1))))
                    (enumerate-interval 1 (- i 1))))
        (enumerate-interval 1 n)))

(define (sum-is-s-triples n s)
    (define (sum-s? t) (= (accumulate + 0 t) s))
    (filter sum-s? (unique-triples n)))
```
* 귀찮아서 합이 s가 되는 경우가 없는 경우라던지 그런 특이케이스들은 넘기기로 한다.

### Exercise 2.42
```racket
(define (queens board-size) ;coordination (row, column)
    (define (queen-cols k)
        (if (= k 0)
            (list empty-board)
            (filter (lambda (positions) (safe? k positions))
                (flatmap
                    (lambda (rest-of-queens) 
                        (map (lambda (new-row) (adjoin-position new-row k rest-of-queens))
                            (enumerate-interval 1 board-size)))
                    (queen-cols (- k 1))))))
    (queen-cols board-size))

(define empty-board '())
(define (adjoin-position r c li) (cons (list r c) li))
(define (safe? k li)
    (define (same-row? p t) (= (car p) (car t)))
    (define (same-col? p t) (= (cadr p) (cadr t)))
    (define (same-diag? p t) (= (abs (- (car p) (car t))) (abs (- (cadr p) (cadr t)))))
    (define (attacked? p t) (or (same-row? p t) (same-col? p t) (same-diag? p t)))
    (define (safe-iter t l)
        (cond ((null? l) #t)
              ((attacked? (car l) t) #f)
              (else (safe-iter t (cdr l)))))
    (safe-iter (car li) (cdr li))) ;새로 추가한 좌표만 다른 퀸들에 대해 확인
```
* 이 알고리즘의 경우 대칭을 고려하지 않고 모든 경우의 수가 나온다. 따라서 (queens 8)의 경우 총 92가지 경우가 나온다.

### Exercise 2.43
순서가 바뀐 경우 최하위 map에서 queen-cols를 호출하기 때문에 매 단계 n번의 호출이 일어난다.

### Exercise 2.44
```racket
(define (up-split painter n)
    (if (= n 0)
        painter
        (let ((smaller (up-split painter (- n 1))))
            (below painter (beside smaller smaller)))))
```
만약 command line에서 코드를 실행시키고 있다면 이 그림언어 연습문제에서 코드를 확인하는데 좀 불편할 수 있다. 한가지 방법은 racket이라는 언어(scheme의 방언)의 IDE인 DrRacket에서 sicp 패키지를 install하여 실행하는 것이다. 코드 전문은 다음과 같다.
```racket
#lang racket
;패키지 import
(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

(define (right-split painter n)
    (if (= n 0)
        painter
        (let ((smaller (right-split painter (- n 1))))
            (beside painter (below smaller smaller)))))

(define (corner-split painter n)
    (if (= n 0)
        painter
        (let ((up (up-split painter (- n 1))) (right (right-split painter (- n 1))))
            (let ((top-left (beside up up))
                  (bottom-right (below right right))
                  (corner (corner-split painter (- n 1))))
                (beside (below painter top-left)
                        (below bottom-right corner))))))

(define (up-split painter n)
    (if (= n 0)
        painter
        (let ((smaller (up-split painter (- n 1))))
            (below painter (beside smaller smaller)))))

;test
(paint (corner-split einstein 4))
```

### Exercise 2.45
```racket
(define (split proc1 proc2)
    (lambda (painter n) 
        (if (= n 0)
            painter
            (let ((smaller ((split proc1 proc2) painter (- n 1))))
                (proc1 painter (proc2 smaller smaller))))))
```

### Exercise 2.46
```racket
(define (make-vect x y) (cons x y))
(define (xcor-vect v) (car v))
(define (ycor-vect v) (cdr v))

(define (add-vect v1 v2)
    (make-vect (+ (xcor-vect v1) (xcor-vect v2))
               (+ (ycor-vect v1) (ycor-vect v2))))

(define (sub-vect v1 v2)
    (make-vect (- (xcor-vect v1) (xcor-vect v2))
               (- (ycor-vect v1) (ycor-vect v2))))

(define (scale-vect s v)
    (make-vect (* s (xcor-vect v)) (* s (ycor-vect v))))
```

### Exercise 2.47
```racket
;make-frame1의 경우
(define (origin-frame f) (car f))
(define (edge1-frame f) (car (cdr f)))
(define (edge2-frame f) (car (cdr (cdr f))))

;make-frame2의 경우
(define (origin-frame f) (car f))
(define (edge1-frame f) (car (cdr f)))
(define (edge2-frame f) (cdr (cdr f)))
```

### Exercise 2.48
```racket
(define (make-segment v1 v2) (cons v1 v2))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))
```

### Exercise 2.49
```racket
;a.
(define outline-painter (segments->painter 
                    (list (segment (vect 0.0 0.0) (vect 1.0 0.0))
                          (segment (vect 1.0 0.0) (vect 1.0 1.0))
                          (segment (vect 1.0 1.0) (vect 0.0 1.0))
                          (segment (vect 0.0 1.0) (vect 0.0 0.0)))))
;b.
(define X-painter (segments->painter
                    (list (segment (vect 0.0 0.0) (vect 1.0 1.0))
                          (segment (vect 0.0 1.0) (vect 1.0 0.0)))))
;c.
(define diamond-painter (segments->painter 
                            (list (segment (vect 0.0 0.5) (vect 0.5 1.0)) 
                                (segment (vect 0.5 1.0) (vect 1.0 0.5)) 
                                (segment (vect 1.0 0.5) (vect 0.5 0.0)) 
                                (segment (vect 0.5 0.0) (vect 0.0 0.5))))) 
;d.
(define wave-painter (segments->painter
                        (list
                            (segment (vect .25 0) (vect .35 .5)) 
                            (segment (vect .35 .5) (vect .3 .6)) 
                            (segment (vect .3 .6) (vect .15 .4)) 
                            (segment (vect .15 .4) (vect 0 .65)) 
                            (segment (vect 0 .65) (vect 0 .85)) 
                            (segment (vect 0 .85) (vect .15 .6)) 
                            (segment (vect .15 .6) (vect .3 .65)) 
                            (segment (vect .3 .65) (vect .4 .65)) 
                            (segment (vect .4 .65) (vect .35 .85)) 
                            (segment (vect .35 .85) (vect .4 1)) 
                            (segment (vect .4 1) (vect .6 1)) 
                            (segment (vect .6 1) (vect .65 .85)) 
                            (segment (vect .65 .85) (vect .6 .65)) 
                            (segment (vect .6 .65) (vect .75 .65)) 
                            (segment (vect .75 .65) (vect 1 .35)) 
                            (segment (vect 1 .35) (vect 1 .15)) 
                            (segment (vect 1 .15) (vect .6 .45)) 
                            (segment (vect .6 .45) (vect .75 0)) 
                            (segment (vect .75 0) (vect .6 0)) 
                            (segment (vect .6 0) (vect .5 .3)) 
                            (segment (vect .5 .3) (vect .4 0)) 
                            (segment (vect .4 0) (vect .25 0)))))
```
* segments->painter 프로시저를 직접 작성할 경우 draw-line이 없어서 프로시저를 사용할 수 없다. 대신 sicp 패키지에 segments->painter가 들어있기 때문에 이를 이용하였다. 이때 벡터는 vect프로시저로, 선분은 segment 프로시저로 만들 수 있다. wave 페인터는 도저히 만들 엄두가 안나 다른 답을 참고하였다...

### Exercise 2.50
```racket
(define (flip-horiz painter) 
   (transform-painter painter 
                      (make-vect 1.0 0.0) 
                      (make-vect 0.0 0.0) 
                      (make-vect 1.0 1.0))) 
  
(define (rotate180 painter) 
   (transform-painter painter 
                      (make-vect 1.0 1.0) 
                      (make-vect 0.0 1.0) 
                      (make-vect 1.0 0.0))) 
  
(define (rotate270 painter) 
   (transform-painter painter 
                      (make-vect 0.0 1.0) 
                      (make-vect 0.0 0.0) 
                      (make-vect 1.0 1.0))) 
```

### Exercise 2.51
```racket
(define (below painter1 painter2)
    (let ((split-point (make-vect 0.0 0.5)))
        (let ((paint-bottom
                (transform-painter
                 painter1
                 (make-vect 0.0 0.0)
                 split-point
                 (make-vect 1.0 0.0)))
              (paint-top
               (transform-painter
                painter2
                split-point
                (make-vect 0.0 1.0)
                (make-vect 1.0 0.5))))
            (lambda (frame) (paint-bottom frame) (paint-top frame)))))
			

(define (below2 painter1 painter2)
    (rotate270 (beside (rotate90 painter2) (rotate90 painter1))))
```
* 디버깅할 방법이 없지만 맞을 것이다...

### Exercise 2.52
