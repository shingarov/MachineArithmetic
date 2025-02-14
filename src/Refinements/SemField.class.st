Class {
	#name : #SemField,
	#superclass : #SMTSem,
	#category : #Refinements
}

{ #category : #yoneda }
SemField class >> apply: functionName to: args ofZ3sorts: argSorts returning: aZ3Sort [
	| z3datatype accessor |
	args size = 1 ifFalse: [ self error ].
	z3datatype := argSorts anyOne.
	self assert: (z3datatype isKindOf: Z3DatatypeSort).
	accessor := z3datatype accessorNamed: functionName.
	self assert: aZ3Sort = accessor range.
	^accessor value: args first
]
