; extends

; Give docstring captures higher priority than @string (default 100)
(expression_statement
  (string
    (string_content) @spell) @string.documentation
  (#set! priority 101))
