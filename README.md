# Gerbil IO environments

## Installation

`gxpkg install github.com/thunknyc/gerbil-ioenv`

## Usage

`ioenv INPUT-PORT OUTPUT-PORT ERROR-PORT`

Create an IO environment.

`call-with-ioenv IOENV THUNK`

Bind `current-input-port`, `current-output-port`, and `current-error-port` parameters to the values
`with-ioenv IOENV E1 E2 ...`
`string-ioenv INPUT-STRING`
