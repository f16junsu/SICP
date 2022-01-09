#lang racket

(define (deriv exp var)
    (cond ((number? exp) 0)
          ((variable? exp) (if (same-variable? exp var) 1 0))
          ((sum? exp) (make-sum (deriv (addend exp) var) (deriv (augend exp) var)))
          ((product? exp) (make-sum 
                            (make-product (multiplier exp) (deriv (multiplicand exp) var))
                            (make-product (deriv (multiplier exp) var) (multiplicand exp))))
          ((exponentiation? exp) (make-product (exponent exp)
                                    (make-product (make-exponentiation (base exp) (- (exponent exp) 1))
                                        (deriv (base exp) var))))
          (else (error "Unknown expression type: DERIV" exp))))

;filter
(define (filter predicate sequence)
    (cond ((null? sequence) '())
          ((predicate (car sequence))
            (cons (car sequence)
                  (filter predicate (cdr sequence))))
          (else (filter predicate (cdr sequence)))))
;accumulate
(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence) (accumulate op initial (cdr sequence)))))

;variable
(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2)))
;sum and product
(define (=number? exp num) (and (number? exp) (= exp num)))
(define (make-sum . l) ;l consists of at least two elements
    (let ((num-sum (accumulate (lambda (x y) (if (number? x) (+ x y) y)) 0 l)) ;숫자들만 모두 더한 것
          (filtered-list (filter (lambda (x) (not (number? x))) l))) ;숫자들을 제외한 리스트
        (cond ((null? filtered-list) num-sum)
              ((= 0 num-sum) (if (= (length filtered-list) 1) (car filtered-list) (cons '+ filtered-list)))
              (else (append (list '+ num-sum) filtered-list)))))
(define (make-product . l) 
    (let ((num-prodt (accumulate (lambda (x y) (if (number? x) (* x y) y)) 1 l))
          (filtered-list (filter (lambda (x) (not (number? x))) l)))
        (cond ((null? filtered-list) num-prodt)
              ((= 0 num-prodt) 0)
              ((= 1 num-prodt) (if (= (length filtered-list) 1) (car filtered-list) (cons '* filtered-list)))
              (else (append (list '* num-prodt) filtered-list)))))
(define (sum? x) (and (pair? x) (eq? (car x) '+)))
(define (addend s) (cadr s))
(define (augend s) (if (= (length s) 3) (caddr s) (cons '+ (cddr s))))
(define (product? x) (and (pair? x) (eq? (car x) '*)))
(define (multiplier p) (cadr p))
(define (multiplicand p) (if (= (length p) 3) (caddr p) (cons '* (cddr p))))
;exponentiation
(define (make-exponentiation exp n)
    (cond ((=number? n 0) 1)
          ((=number? n 1) exp)
          ((=number? exp 0) 0)
          (else (list '** exp n))))
(define (base exp) (cadr exp))
(define (exponent exp) (caddr exp))
(define (exponentiation? exp) (and (pair? exp) (eq? (car exp) '**)))

;preprocessor
(define (infix->prefix exp)
    (if (pair? exp)
        (list (cadr exp) (infix->prefix (car exp)) (infix->prefix (caddr exp)))
        exp))
(define (infix->prefix2 exp) ;accepts both infix and prefix forms
    (define (product-processor expre)
        (define (iter result rest)
            (cond ((null? rest) result)
                  ((and (< 2 (length rest)) (eq? '* (cadr rest))) 
                        (iter result (cons (list '* (infix->prefix2 (car rest)) (infix->prefix2 (caddr rest))) 
                                        (cdddr rest))))
                  (else (iter (append result (list (infix->prefix2 (car rest)))) (cdr rest)))))
        (iter '() expre))
    (cond ((not (pair? exp)) exp) ;if a simple symbol or number or an operator
          ((or (eq? (car exp) '+) (eq? (car exp) '*)) exp) ;if prefix form expression
          (else (let ((product-processed (product-processor exp)))
                    (cons '+ (filter (lambda (x) (not (eq? x '+))) product-processed))))))

;test
(deriv (infix->prefix2 '(x + 3 + y * (x + 2) * 4 + 5)) 'x)