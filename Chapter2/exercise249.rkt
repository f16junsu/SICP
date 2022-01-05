#lang racket
 (#%require sicp-pict)

;vector
(define (make-vect x y) (cons x y))
(define (xcor-vect v) (car v))
(define (ycor-vect v) (cdr v))

(define (add-vect v1 v2)
    (make-vect (+ (xcor-vect v1) (xcor-vect v2))
               (+ (ycor-vect v1) (ycor-vect v2))))
(define (sub-vect v1 v2)
    (make-vect (- (xcor-vect v1) (xcor-vect v2))
               (- (ycor-vect v1) (ycor-vect v2))))
(define (scale-vect s v)
    (make-vect (* s (xcor-vect v)) (* s (ycor-vect v))))

;frame
(define (make-frame originv edge1v edge2v)
    (list originv edge1v edge2v))
(define (origin-frame f) (car f))
(define (edge1-frame f) (car (cdr f)))
(define (edge2-frame f) (car (cdr (cdr f))))
(define (frame-coord-map frame)
    (lambda (v) (add-vect (origin-frame frame)
                    (add-vect (scale-vect (xcor-vect v) (edge1-frame frame))
                        (scale-vect (ycor-vect v) (edge2-frame frame))))))

;segment
(define (make-segment v1 v2) (cons v1 v2))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))



;a.
(define outline-painter (segments->painter 
                    (list (segment (vect 0.0 0.0) (vect 1.0 0.0))
                          (segment (vect 1.0 0.0) (vect 1.0 1.0))
                          (segment (vect 1.0 1.0) (vect 0.0 1.0))
                          (segment (vect 0.0 1.0) (vect 0.0 0.0)))))
;b.
(define X-painter (segments->painter
                    (list (segment (vect 0.0 0.0) (vect 1.0 1.0))
                          (segment (vect 0.0 1.0) (vect 1.0 0.0)))))
;c.
(define diamond-painter (segments->painter 
                            (list (segment (vect 0.0 0.5) (vect 0.5 1.0)) 
                                (segment (vect 0.5 1.0) (vect 1.0 0.5)) 
                                (segment (vect 1.0 0.5) (vect 0.5 0.0)) 
                                (segment (vect 0.5 0.0) (vect 0.0 0.5))))) 
;d.
(define wave-painter (segments->painter
                        (list
                            (segment (vect .25 0) (vect .35 .5)) 
                            (segment (vect .35 .5) (vect .3 .6)) 
                            (segment (vect .3 .6) (vect .15 .4)) 
                            (segment (vect .15 .4) (vect 0 .65)) 
                            (segment (vect 0 .65) (vect 0 .85)) 
                            (segment (vect 0 .85) (vect .15 .6)) 
                            (segment (vect .15 .6) (vect .3 .65)) 
                            (segment (vect .3 .65) (vect .4 .65)) 
                            (segment (vect .4 .65) (vect .35 .85)) 
                            (segment (vect .35 .85) (vect .4 1)) 
                            (segment (vect .4 1) (vect .6 1)) 
                            (segment (vect .6 1) (vect .65 .85)) 
                            (segment (vect .65 .85) (vect .6 .65)) 
                            (segment (vect .6 .65) (vect .75 .65)) 
                            (segment (vect .75 .65) (vect 1 .35)) 
                            (segment (vect 1 .35) (vect 1 .15)) 
                            (segment (vect 1 .15) (vect .6 .45)) 
                            (segment (vect .6 .45) (vect .75 0)) 
                            (segment (vect .75 0) (vect .6 0)) 
                            (segment (vect .6 0) (vect .5 .3)) 
                            (segment (vect .5 .3) (vect .4 0)) 
                            (segment (vect .4 0) (vect .25 0)))))