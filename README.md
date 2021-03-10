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
You need to have a Scheme implementation, I used Racket, but any should work. You need to have the `sicp-mce.rkt` file, which exports the `eval-loop` function. In your file or in a REPL import the file and 
run the function.

```scheme
(require "sicp-mce.rkt")
(eval-loop)
```

### More
In the basic_sicp branch you can find the simplest variant of the evaluator.
