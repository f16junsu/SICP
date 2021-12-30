#lang racket

;filter
(define (filter predicate sequence)
    (cond ((null? sequence) '())
          ((predicate (car sequence))
            (cons (car sequence)
                  (filter predicate (cdr sequence))))
          (else (filter predicate (cdr (sequence))))))

;accumulate
(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence) (accumulate op initial (cdr sequence)))))

;enumerate-interval
(define (enumerate-interval low high)
    (if (> low high) 
        '() 
        (cons low (enumerate-interval (+ low 1) high))))

;enumerate-tree
(define (enumerate-tree tree)
    (cond ((null?) tree)
          ((not (pair? tree)) (list tree))
          (else (append (enumerate-tree (car tree)) (enumerate-tree (cdr tree))))))

;accumulate-n
(define (accumulate-n op init seqs)
    (if (null? (car seqs))
        '()
        (cons (accumulate op init (map car seqs))
              (accumulate-n op init (map cdr seqs)))))


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
#| (define (matrix-*-matrix m n)
    (let ((cols (transpose n))) 
         (map (lambda (v) 
                (accumulate 
                    (lambda (x y) (cons (dot-product v x) y)) 
                        '() cols)) m))) |#
(define (matrix-*-matrix m n)
    (let ((cols (transpose n)))
        (map (lambda (v) (matrix-*-vector cols v)) m)))


;test
(matrix-*-matrix '((4 1 -1) (3 2 0)) '((2 6) (1 -4) (5 -2)))