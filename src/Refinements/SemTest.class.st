Class {
	#name : #SemTest,
	#superclass : #SMTSem,
	#category : #'Refinements-Theories'
}

{ #category : #yoneda }
SemTest class >> apply: functionName to: args ofZ3sorts: argSorts returning: aZ3Sort [
	| z3datatype functionNameParts recognizer |
	args size = 1 ifFalse: [ self error ].
	z3datatype := argSorts anyOne.
	self assert: (z3datatype isKindOf: Z3DatatypeSort).
	functionNameParts := functionName decodeUnsafe splitAt: 3.
	self assert: functionNameParts key = 'is$'.
	recognizer := z3datatype recognizerFor: functionNameParts value.
	self assert: aZ3Sort = Bool sort.
	^recognizer value: args first
]
