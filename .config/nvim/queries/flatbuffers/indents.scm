; The external grammar only ships highlighting queries; nvim-treesitter's
; indentexpr needs these captures to indent schema bodies and metadata.
[
  (type_decl)
  (enum_decl)
  (union_decl)
  (rpc_decl)
  (metadata)
  (object)
] @indent.begin

(type "[") @indent.begin
(value "[") @indent.begin

; Declarations include leading documentation, so their headers may start after
; the declaration node's first line but must remain at the top level.
(source_file (_ (documentation) @indent.zero))

[
  "table"
  "struct"
  "enum"
  "union"
  "rpc_service"
] @indent.zero

[
  "{"
  "}"
  ")"
  "]"
] @indent.branch
