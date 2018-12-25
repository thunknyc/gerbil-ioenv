(import :gerbil/core)

(export make-ioenv ioenv?
        ioenv-input ioenv-output ioenv-error
        call-with-ioenv with-ioenv
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
