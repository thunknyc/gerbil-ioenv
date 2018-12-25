(import :gerbil/core
        :std/srfi/1)

(export make-ioenv ioenv?
        ioenv-input ioenv-output ioenv-error
        io-apply
        call-with-ioenv with-ioenv let-ioenv
        string-ioenv)

(defstruct ioenv (input output error) final: #t)

(def (string-ioenv input)
  (make-ioenv (open-input-string input) (open-output-string) (open-output-string)))

(def (call-with-ioenv ioenv thunk)
  (parameterize ((current-input-port (ioenv-input ioenv))
                 (current-output-port (ioenv-output ioenv))
                 (current-error-port (ioenv-error ioenv)))
    (thunk)))

(defrules with-ioenv ()
  ((_ ioenv e es ...)
   (call-with-ioenv ioenv (lambda () e es ...))))

(defrules let-ioenv ()
  ((_ ((in inval)
       (out outval)
       (err errval))
      (val io-expr)
      expr1 exprn ...)
   (let* ((in inval)
          (out outval)
          (err errval))
     (let (val (with-ioenv (ioenv in out err) io-expr))
       expr1 exprn ...))))

(def (fix-args args)
  (if (null? args) args
      (let*-values (((inline rest) (split-at args (1- (length args)))))
        (append inline (car rest)))))

(def (io-apply input-string proc . args)
  (let-ioenv ((in (open-input-string input-string))
              (out (open-output-string))
              (err (open-output-string)))
             (result (apply proc (fix-args args)))
             `((result . ,result)
               (output . ,(get-output-string out))
               (error . ,(get-output-string err)))))
