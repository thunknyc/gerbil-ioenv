# Gerbil IO environments

This module is useful if you need to evaluate expressions and control
their IO environment.

## Installation

`gxpkg install github.com/thunknyc/gerbil-ioenv`

## Usage

`io-apply INPUT-STRING PROC ARG ... REST-ARGS`

> Apply ARG ... REST-ARGS to PROC in a dynamic environment where
  CURRENT-INPUT-PORT has been bound to a string input port initialized
  with INPUT-STRING and return an association list containing three
  keys: `'result`, `'output`, and `'error`. The `'result` key is
  associated with the result of the evaluation whereas the `'output`
  and `'error` keys are associated with the output to CURRENT-OUTPUT-
  and CURRENT-ERROR-PORT, respectively.

```
let-ioenv ((INPUT-PORT-NAME INPUT-PORT)
           (OUTPUT-PORT-NAME OUTPUT-PORT)
           (ERROR-PORT-NAME OUTPUT-PORT))
    (NAME BOUND-EXPR)
 EXPR ...
```

> Bind to INPUT-PORT-NAME etc. the associated values. Evaluate
  BOUND-EXPR within a dynamic environment in which CURRENT-INPUT-PORT
  etc. have been bound to those values. Bind the resulting value to
  NAME and evalute EXPR ...
>
> An example:
```
(let-ioenv ((in (open-input-string "(+ 1 1)"))
            (out (open-output-string))
            (err (open-output-string)))
    (val (begin (displayln (eval (read))) 'done))
  (list val (get-output-string out)))

;; => '(done "2\n")
```

`ioenv INPUT-PORT OUTPUT-PORT ERROR-PORT`

> Create an IO environment.

`call-with-ioenv IOENV THUNK`

> Bind `current-input-port`, `current-output-port`, and
  `current-error-port` parameters to the values associated with IOENV
  and evaluate THUNK, with zero arguments.

`with-ioenv IOENV E1 E2 ...`

> Syntactic sugar for `call-with-ioenv`. Bind `current-input-port`,
  `current-output-port`, and `current-error-port` parameters to the
  values associated with IOENV and evaluate E1, E2, etc.

`string-ioenv INPUT-STRING`

> Return a new IO environment, with input from a string port
  initialized with INPUT-STRING, and output and error associated with
  new string output ports.
