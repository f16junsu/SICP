#lang racket

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
;test case
#| (define m (make-mobile (make-branch 1 3) 
                       (make-branch 1 (make-mobile (make-branch 1 2) (make-branch 1 4)))))
(total-weight m) |#

;c.
(define (balanced? m)
    (cond ((number? m) #t) ;m이 그냥 weight일때
          ((not (pair? (left-branch m))) (balanced? (branch-structure m))) ;m이 사실 branch일때
          ((and (balanced? (left-branch m)) (balanced? (right-branch m))) ;양쪽 팔들이 각각 balanced일때
                (= (* (total-weight (left-branch m)) (branch-length (left-branch m)))
                   (* (total-weight (right-branch m)) (branch-length (right-branch m)))))
          (else #f)))

;test case
(define m (make-mobile (make-branch 1 3) 
                       (make-branch 1 (make-mobile (make-branch 1 2) (make-branch 1 4)))))
(define n (make-mobile (make-branch 4 3)
                       (make-branch 2 (make-mobile (make-branch 1 4) (make-branch 2 2)))))
(balanced? m)
(balanced? n)
;d.

