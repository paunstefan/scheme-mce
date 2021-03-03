# scheme-mce
Metacircular evaluator for Scheme/LISP started from SICP example

## What is it

This is an evaluator (interpreter) for a very basic version of LISP,
written in less than 100 lines of Scheme. It is mostly copied from 
the Structure and Interpretation of Computer Programs course.
It can theoretically do any computation, but this version lacks 
features such as defines or mutation.

It is called a metacircular evaluator because it is an evaluator for
LISP written in itself (in this case, I used the Racket dialect of Scheme).

## How to use
You need to have a Scheme implementation, I used Racket, but any should work. Then run the sicp-mce.rkt file to load the definitions and you can 
use them in the REPL my calling the `my-eval` function.

```scheme
(my-eval '((lambda (x) (+ x 1)) 42) (initial-env))
```

### More
The evaluator is extended and made better in the main branch of the repo. 
I'm keeping this one to keep a record of the simplest evaluator.
