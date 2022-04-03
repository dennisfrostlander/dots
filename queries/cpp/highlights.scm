((identifier) @cppConstant
 (.match? @cppConstant "^[A-Z][A-Z_]+$")
 (#set! "priority" 120)
)

((identifier) @gmacrosSubtle
 (.match? @gmacrosSubtle "ASSIGN_OR_RETURN|RETURN_IF_ERROR|Q?CHECK|ABSL_PREDICT|RET_CHECK(_OK|_FAIL)?|V?LOG")
 (set! "priority" 110)
)

((primitive_type) @cppExtraKeywords
 (.match? @cppExtraKeywords "void|bool|int64(_t)?")
 (#set! "priority" 110)
)

((function_declarator
      declarator: (qualified_identifier
        scope: (namespace_identifier) @cppFunctionDeclaration
        name: (identifier) @cppFunctionDeclaration))
 (#set! "priority" 110)
)

((namespace_definition
      name: (identifier) @cppNamespaceDefinition)
  (#set! "priority" 110)
)

((namespace_definition
      name: (namespace_definition_name) @cppNamespaceDefinitionName)
  (#set! "priority" 110)
)

((qualified_identifier
      name: (identifier) @cppQualifiedIdentifier)
 (#set! "priority" 110)
)
