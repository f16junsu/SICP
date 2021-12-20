#lang racket

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

;rational number operation
(define (print-rat x)
    (display (numer x))
    (display "/")
    (display (denom x))
    (newline))
(define (neg-rat x) (make-rat (- (numer x)) (denom x))) ;negative
(define (recip x) (make-rat (denom x) (numer x))) ;reciprocal
(define (add-rat x y) ;addition
    (make-rat 
        (+ (* (numer x) (denom y)) (* (numer x) (denom y))) 
        (* (denom x) (denom y))))
(define (sub-rat x y) (add-rat x (neg-rat y))) ;substraction
(define (mul-rat x y) ;multiplication
    (make-rat
        (* (numer x) (numer y))
        (* (denom x) (denom y))))
(define (div-rat x y) (mul-rat x (recip y))) ;division
(define (equal-rat? x y) ;eqaul rational
    (= (* (numer x) (denom y)) (* (numer y) (denom x))))




;test
(print-rat (mul-rat (make-rat 3 (- 6)) (make-rat 6 8)))
