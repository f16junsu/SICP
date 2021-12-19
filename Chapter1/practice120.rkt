#lang racket

(define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))

(gcd 206 40) ;with normal-order application
(gcd 40 (remainder 206 40))
if (= (remainder 206 40) 0) ;v
(gcd (remainder 206 40) (remainder 40 (remainder (206 40))))
if (= (remainder 40 (remainder (206 40))) 0) ;vv
(gcd (remainder 40 (remainder (206 40))) (remainder ((remainder 206 40)) (remainder 40 (remainder (206 40)))))
if (= (remainder ((remainder 206 40)) (remainder 40 (remainder (206 40)))) 0) ;vvvv
(gcd (remainder ((remainder 206 40)) (remainder 40 (remainder (206 40))))
    (remainder (remainder 40 (remainder (206 40))) (remainder ((remainder 206 40)) (remainder 40 (remainder (206 40))))))
if (= (remainder (remainder 40 (remainder (206 40))) (remainder ((remainder 206 40)) (remainder 40 (remainder (206 40)))))) ;조건식 #t, vvvvvvv
(remainder ((remainder 206 40)) (remainder 40 (remainder (206 40)))) ;결과, vvvv



(gcd 206 40)
(gcd 40 6)
(gcd 6 4)
(gcd 4 2) 
(gcd 2 0)