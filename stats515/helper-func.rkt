#lang racket
(require plot)

;;---------------------Permutations and Combinations---------------------

;; bfac : number -> number -> number
;; Gives the bounded factorial of numbers between
;; start and end as : start * (start + 1) * ... * (end - 1) * end
(define (bfac start end)
  (define (bfh start end acc)
    (if (= start end) acc (bfh (- start 1)  end (* start acc))))
  (cond
    [(< start end) (error "upper limit must be greater than lower limit -- BFAC")]
    [(bfh start end 1)]))

;; comb : number -> number -> number
;; Takes two numbers (up) and (low) and gives
;; up "choose" low
(define (comb up low)
  (cond
    [(= low 0) 1]
    [(< up low) (error "upper limit must be greater than lower limit -- COMB")]
    [(/ (perm up low) (bfac low 1))]))

;; perm : number -> number -> number
;; Takes two numbers (up) and (low) and gives
;; up "choose" low ordered
(define (perm up low)
  (cond
    [(= low 0) 1]
    [(< up low) (error "upper limit must be greater than lower limit -- PERM")]
    [else (bfac up (- up low))]))


;;---------------------Summations and Products---------------------

;; acc-temp : (number -> number -> number) -> number ->
;;             number -> (number -> number) -> number -> number -> number
;; defines the template of sigma and and pi
;; takes operation, accumulator, function, lower limit, upper limit
(define (acc-temp op end func low up)
  (define (acc-h func low up acc)
    (cond
      [(> low up) acc]
      [else (acc-h func (+ low 1) up (op acc (func low)))]))
  (acc-h func low up end))

;; sum : (number -> number) -> number -> number -> number
;; Sigma summation of f (x) such that
;; f(x-low) + f(x-low + 1) + ... + f(x-end - 1) + f(x-end)
(define (sum func low up) (acc-temp + 0 func low up))

;; prod : (number -> number) -> number -> number -> number
;; Pi of f (x) such that
;; f(x-low) * f(x-low + 1) * ... * f(x-end - 1) * f(x-end)
(define (prod func low up) (acc-temp * 1 func low up))


;;---------------------Distributions---------------------

;; number -> (number -> number)
;; Consumes a number to give a function which gives
;; the nth term of the geometric distribution with
;; success probability p
(define (geo-dist p)
  (λ(term)
    (if (> term 0)
        (* (expt (- 1 p) (- term 1)) p) (error "Term for geometric distribution must be greater than 0 -- GEO-DIST"))))

;; number -> number -> (number -> number)
;; Consumes a number to give a function which gives
;; the nth term of the binomial distribution with
;; success probability p
(define (bin-dist n p)
  (λ(term)
    (cond
      [(< term 0) (error "Term for binomial distribution cannot be less than 0 -- BIN-DIST")]
      [(> term n) 0]
      [else (* (comb n term) (expt p term) (expt (- 1 p) (- n term)))])))

;; value of the constant 'e'
(define e 2.7182818284590452353602874713527)

;; number -> number -> (number -> number)
;; Consumes a number to give a function which gives
;; the nth term of the poisson distribution with
;; average success of lam
(define (poi-dist lam)
  (λ(term)
    (cond
      [(< term 0) (error "Term for binomial distribution cannot be less than 0 -- POI-DIST")]
      [else (/ (* (expt e (- lam)) (expt lam term)) (bfac term 0))])))

(define (hyper N n r)
  (λ(y)
    (cond
      [(> y r) (error "Term for hyper geometric dist connot be more than r -- HYPER")]
      [else (/ (* (comb r y) (comb (- N r) (- n y))) (comb N n))])))
        

;; Filtering function for discrete probability distributions
;; consumes a distribution
(define (plot-filter dist)
  (λ(x)
    (dist (if(integer? x) x (floor x)) )))


;; Using plot-filter to generate graphs
;;(define ques (bin-dist 100 0.2))
;;(define pques (plot-filter ques))
;;(plot (function pques 0 100 #:label "y ~ B(100,0.2)"))