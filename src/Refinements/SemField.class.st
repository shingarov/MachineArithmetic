Class {
	#name : #SemField,
	#superclass : #SMTSem,
	#category : #Refinements
}

{ #category : #yoneda }
SemField class >> apply: functionName to: args ofZ3sorts: argSorts returning: aZ3Sort [
	| z3datatype accessor |
	z3datatype := argSorts first.
	self assert: (z3datatype isKindOf: Z3DatatypeSort).
	accessor := z3datatype accessorNamed: functionName.
	self assert: aZ3Sort = accessor range.
	^accessor value: args first
]
