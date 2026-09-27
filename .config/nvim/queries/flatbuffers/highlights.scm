; The pinned grammar's highlight query uses the nonexistent enumval_decl node.
; Keep a local query with enum_val_decl so Neovim can compile the highlights.
[
  "include"
  "namespace"
  "attribute"
  "root_type"
  "file_extension"
  "file_identifier"
] @keyword

[
  "table"
  "struct"
  "union"
  "enum"
  "rpc_service"
] @keyword.type

[";" "." "," ":"] @punctuation.delimiter
["(" ")" "[" "]" "{" "}"] @punctuation.bracket
["=" (plus_token) (minus_token)] @operator

(type) @type.builtin
(type (full_ident) @type)
(string_constant) @string
(escape_sequence) @string.escape
(bool_constant) @boolean
[(inf_token) (nan_token)] @constant.builtin
(int_constant) @number
(float_constant) @number.float
(comment) @comment
(documentation) @comment.documentation

(attribute_decl attribute_name: (identifier) @attribute)
(field_and_value field_key: (identifier) @attribute)
(namespace_decl namespace_ident: (full_ident) @module)

(type_decl table_or_struct_name: (identifier) @type.definition)
(enum_decl enum_name: (identifier) @type.definition)
(union_decl union_name: (identifier) @type.definition)
(rpc_decl rpc_name: (identifier) @type.definition)
(root_decl root_type_ident: (identifier) @type)

(enum_val_decl enum_key: (identifier) @constant)
(field_decl field_key: (identifier) @variable.member)
(union_field_decl union_field_key: (identifier) @variable.member)
(union_decl field_without_type: (full_ident) @type)

(rpc_method
  rpc_method_name: (identifier) @function.method
  rpc_parameter: (identifier) @type
  rpc_return_type: (identifier) @type)
