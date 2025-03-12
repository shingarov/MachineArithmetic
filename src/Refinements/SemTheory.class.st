Class {
	#name : #SemTheory,
	#superclass : #SMTSem,
	#category : #'Refinements-Theories'
}

{ #category : #yoneda }
SemTheory class >> apply: f to: args ofZ3sorts: argSorts returning: aZ3Sort [
	| result |
	self assert: ((args zip: argSorts) allSatisfy: [ :arg_argSort | arg_argSort key sort = arg_argSort value ]).
	result := f value: args value: aZ3Sort.
	self assert: result sort = aZ3Sort.
	^result
]
