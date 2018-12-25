# Gerbil IO environments

## Installation

`gxpkg install github.com/thunknyc/gerbil-ioenv`

## Usage

`ioenv INPUT-PORT OUTPUT-PORT ERROR-PORT`

Create an IO environment.

`call-with-ioenv IOENV THUNK`

Bind `current-input-port`, `current-output-port`, and
`current-error-port` parameters to the values associated with IOENV
and evaluate THUNK, with zero arguments.

`with-ioenv IOENV E1 E2 ...`

Syntactic sugar for `call-with-ioenv`. Bind `current-input-port`,
`current-output-port`, and `current-error-port` parameters to the
values associated with IOENV and evaluate E1, E2, etc.

`string-ioenv INPUT-STRING`

Return a new IO environment, with input from a string port initialized
with INPUT-STRING, and output and error associated with new string
output ports.
