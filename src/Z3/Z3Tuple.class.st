Class {
	#name : #Z3Tuple,
	#superclass : #Datatype,
	#category : #'Z3-Core'
}

{ #category : #accessing }
Z3Tuple >> get: aString [
	"Return given field's value. Note. that if multiple constructors define 
	 the 'field' with the same name, then this method throws an error. In 
	 that case, you may need to lookup the accessor and use it directly."

	| accessor |
	
	accessor := self sort accessorNamed: aString.
	^accessor value: self
]

{ #category : #accessing }
Z3Tuple >> updateFieldNamed: field to: value [
	"Update record field with a value.
	 The Z3 API docstring explains this as 'corresponding to the
	 'with' construct in OCaml.  What it meant here is OCaml's
	 'Record Update', section 11.7.4 in the OCaml manual,
	 https://ocaml.org/manual/5.3/expr.html
	 subsection 'Records':
	
	 The expression { expr with field1 [= expr1] ; … ; fieldn [= exprn] }
	 builds a fresh record with fields field1 … fieldn equal to expr1 … exprn,
	 and all other fields having the same value as in the record expr.
	 In other terms, it returns a shallow copy of the record expr, except
	 for the fields field1 … fieldn, which are initialized to expr1 … exprn.
	"

	| accessor valueAST |
	accessor := self sort accessorNamed: field.
	valueAST := accessor range cast: value.
	^ Z3 datatype_update_field: ctx _: accessor _: self _: valueAST
]
