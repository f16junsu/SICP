#lang racket

;Recursive Process
(define (fr n)
    (if (< n 3)
        n
        (+ (fr (- n 1)) (* 2 (fr (- n 2))) (* 3 (fr (- n 3))))))

;Iterative Process
(define (fi n)
    (define (fi-iter cnt r1 r2 r3)
        (cond ((< n 3) n)
              ((= cnt n) (+ r1 (* 2 r2) (* 3 r3)))
              (else (fi-iter (+ 1 cnt) 
                (+ r1 (* 2 r2) (* 3 r3)) r1 r2))))
    (fi-iter 3 2 1 0))

(fr 5)
(fi 5)