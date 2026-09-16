; nvim-treesitter does not ship a Prisma indent query, so its indentexpr needs
; these captures to indent schema blocks and multiline attribute expressions.
[
  (statement_block)
  (enum_block)
  (arguments)
  (array)
] @indent.begin

; The Prisma grammar wraps an unfinished attribute call in ERROR until its
; closing delimiter is typed, which is precisely when insert-mode indentation
; is needed.
(ERROR
  [
    "("
    "["
  ] @indent.begin)

[
  "}"
  ")"
  "]"
] @indent.branch
