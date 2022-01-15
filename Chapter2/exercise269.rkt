#lang racket

;leaf ('leaf symbol weight)
(define (make-leaf symbol weight) (list 'leaf symbol weight))
(define (leaf? object) (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

;tree (left right symbols-list total-weight)
;left and right can be both leaf or tree
(define (make-code-tree left right)
    (list left
          right
          (append (symbols left) (symbols right))
          (+ (weight left) (weight right))))
(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))
(define (symbols tree)
    (if (leaf? tree)
        (list (symbol-leaf tree))
        (caddr tree)))
(define (weight tree)
    (if (leaf? tree)
        (weight-leaf tree)
        (cadddr tree)))

;decoding
(define (decode bits tree)
    (define (decode-1 bits current-branch)
        (if (null? bits)
            '()
            (let ((next-branch (choose-branch (car bits) current-branch)))
                (if (leaf? next-branch)
                    (cons (symbol-leaf next-branch) (decode-1 (cdr bits) tree))
                    (decode-1 (cdr bits) next-branch)))))
    (decode-1 bits tree))
(define (choose-branch bit branch)
    (cond ((= bit 0) (left-branch branch))
          ((= bit 1) (right-branch branch))
          (else (error "bad bit: CHOOSE-BRANCH" bit))))

;ordered set of pairs by weight
(define (adjoin-set x set)
    (cond ((null? set) (list x))
          ((< (weight x) (weight (car set))) (cons x set))
          (else (cons (car set) (adjoin-set x (cdr set))))))
(define (make-leaf-set pairs)
    (if (null? pairs)
        '()
        (let ((pair (car pairs)))
            (adjoin-set (make-leaf (car pair) (cadr pair))
                        (make-leaf-set (cdr pairs))))))


;encoding
(define (encode message tree)
    (if (null? message)
        '()
        (append (encode-symbol (car message) tree)
                (encode (cdr message) tree))))
(define (encode-symbol letter tree)
    (define (iter current-tree)
        (cond ((leaf? current-tree) '())
              ((memq letter (symbols (left-branch current-tree)))
                    (cons 0 (iter (left-branch current-tree))))
              ((memq letter (symbols (right-branch current-tree)))
                    (cons 1 (iter (right-branch current-tree))))
              (else (error "NO SYMBOL IN THE TREE"))))
    (iter tree))


;generating huffman tree
(define (generate-huffman-tree pairs)
    (successive-merge (make-leaf-set pairs)))
(define (successive-merge ordered-set)
    (if (null? (cdr ordered-set)) 
        (car ordered-set)
        (let ((merged (make-code-tree (car ordered-set) (cadr ordered-set)))
              (rest-set (cddr ordered-set)))
            (successive-merge (adjoin-set merged rest-set)))))

;sample
(define sample-tree
    (make-code-tree (make-leaf 'A 4)
                    (make-code-tree
                        (make-leaf 'B 2)
                        (make-code-tree
                            (make-leaf 'D 1)
                            (make-leaf 'C 1)))))
(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))


;test
(define sample-tree2 (generate-huffman-tree '((A 4) (B 2) (D 1) (C 1))))
(define message-code (encode '(A D A B B C A) sample-tree2))
(decode message-code sample-tree2)