#lang racket

(define (sigma x_n start end)
    (if (> start end) 
        0
        (+ (x_n start) (sigma x_n (+ start 1) end))))

(define (integral f a b n)
    (define h (/ (- b a) n))
    (define (x_n n)
        (if (even? n) 
            (* 2 (f (+ a (* n h))))
            (* 4 (f (+ a (* n h))))))
    (* (- (sigma x_n 0 n) (+ a b)) (/ h 3)))

(define (cube x) (* x x x))

(integral cube 0 1 100)
(integral cube 0 1 1000)