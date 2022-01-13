#lang racket

;record
(define (make-record-tree key value left right)
    (list (list key value) left right))
(define (key record) (caar record))
(define (value record) (cadar record))
(define (left-tree record) (cadr record))
(define (right-tree record) (caddr record))

;lookup
(define (lookup given-key record)
    (cond ((null? record) #f)
          ((equal? given-key (key record)) (value record))
          (else (let ((l-result (lookup given-key (left-tree record))))
                  (if (eq? l-result #f) 
                      (lookup given-key (right-tree record))
                      l-result)))))
    