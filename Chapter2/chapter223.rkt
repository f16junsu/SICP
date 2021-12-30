#lang racket

;accumulate
(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence) (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq) (accumulate append '() (map proc seq)))

;enumerate-interval
(define (enumerate-interval low high)
    (if (> low high) 
        '() 
        (cons low (enumerate-interval (+ low 1) high))))

(accumulate
    append '() (map (lambda (i)
                    (map (lambda (j) (list i j))
                         (enumerate-interval 1 (- i 1))))
                    (enumerate-interval 1 6)))

(map (lambda (i)
                    (map (lambda (j) (list i j)) (enumerate-interval 1 (- i 1))))
                    (enumerate-interval 1 6))