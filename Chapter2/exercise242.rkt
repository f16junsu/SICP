#lang racket

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

;filter
(define (filter predicate sequence)
    (cond ((null? sequence) '())
          ((predicate (car sequence))
                (cons (car sequence) (filter predicate (cdr sequence))))
          (else (filter predicate (cdr sequence)))))

;flatmap
(define (flatmap proc seq) (accumulate append '() (map proc seq)))



;exercise implementation
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


;test
(define (print-list li)
    (define (displayl o) (display o) (newline))
    (if (null? li)
        (newline)
        (begin (displayl (car li)) (print-list (cdr li)))))

(accumulate (lambda (x y) (+ 1 y)) 0 (queens 11))