((identifier) @gmacros
 (.match? @gmacros "^[A-Z][A-Z_]+$")
 (set! "priority" 110)
)

((identifier) @gmacrosSubtle
 (.match? @gmacrosSubtle "ASSIGN_OR_RETURN|RETURN_IF_ERROR|Q?CHECK|ABSL_PREDICT|RET_CHECK|V?LOG")
 (set! "priority" 110)
)

((primitive_type) @cppExtraKeywords
 (.eq? @cppExtraKeywords "void")
 (set! "priority" 110)
)

((function_declarator
      declarator: (qualified_identifier
        scope: (namespace_identifier) @cppFunctionDeclaration
        name: (identifier) @cppFunctionDeclaration))
 (set! "priority" 110)
)

(
  (function_declarator
    declarator: (identifier) @gmacroTest
    parameters: (parameter_list
      (parameter_declaration
        type: (type_identifier) @gmacroTestParameter
      )
    )
  )
  (.match? @gmacroTest "^TEST")
  (set! "priority" 110)
 )

((namespace_definition
      name: (identifier) @cppNamespaceDefinition)
  (set! "priority" 110)
)

((qualified_identifier
      name: (identifier) @cppQualifiedIdentifier)
 (set! "priority" 110)
)
