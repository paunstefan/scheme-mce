#lang scheme
;; Eval kernel

; Main eval function
; basic functionality is dispatched from here
(define (my-eval exp env)
  (cond
    ((number? exp) exp)
    ((symbol? exp) (lookup exp env))
    ((eq? (car exp) 'quote) (cadr exp))
    ((eq? (car exp) 'lambda)
     (list 'closure (cdr exp) env))
    ((eq? (car exp) 'cond)
     (evcond (cdr exp) env))
    (else (my-apply (my-eval (car exp) env)
                    (evlist (cdr exp) env)))))

; Applicator for functions
(define (my-apply proc args)
  (cond
    ((primitive-op? proc)
         (apply proc args))
    ((eq? (car proc) 'closure)
     (my-eval (cadadr proc)
           (bind (caadr proc)
                 args
                 (caddr proc))))
    (else error)))

(define (evlist l env)
  (cond
    ((eq? l '()) '())
    (else
     (cons (my-eval (car l) env)
           (evlist (cdr l) env)))))

(define (evcond clauses env)
  (cond
    ((eq? clauses '()) '())
    ((eq? (caar clauses) 'else)
     (eval (cadar clauses) env))
    ((false? (eval (caar clauses) env))
     (evcond (cdr clauses) env))
    (else
     (eval (cadar clauses) env))))


;; Environment
(define (bind vars vals env)
  (cons (pair-up vars vals)
        env))

(define (pair-up vars vals)
  (cond
    ((eq? vars '())
     (cond
       ((eq? vals '()) '())
       (else (error "Vars & vals not the same length"))))
    ((eq? vals '()) (error "Vals empty"))
    (else
     (cons (cons (car vars)
                 (car vals))
           (pair-up (cdr vars)
                    (cdr vals))))))

(define (lookup sym env)
  (cond
    ((eq? env '()) (error "Unbound variable"))
    (else
     ((lambda (vcell)
        (cond ((eq? vcell '())
               (lookup sym
                       (cdr env)))
              (else (cdr vcell))))
      (assq sym (car env))))))

(define (assq sym alist)
  (cond
    ((eq? alist '()) '())
    ((eq? sym (caar alist))
     (car alist))
    (else
     (assq sym (cdr alist)))))


;; Utilities
(define (primitive-op? datum)
  (procedure? datum))


;; Initial setup
(define primitive-procedure-names
  '(+ - / * cons car cdr eq? equal? list null?))

(define primitive-procedure-objects
  (list + - / * cons car cdr eq? equal? list null?))

(define (initial-env)
  (bind primitive-procedure-names primitive-procedure-objects '()))