Class {
	#name : #SemCtor,
	#superclass : #SMTSem,
	#category : #'Refinements-Theories'
}

{ #category : #yoneda }
SemCtor class >> apply: constructorName to: args ofZ3sorts: argSorts returning: targetZ3DatatypeSort [
	| constructor |
	self assert: (targetZ3DatatypeSort isKindOf: Z3DatatypeSort).
	constructor := targetZ3DatatypeSort constructorNamed: constructorName.
	self assert: constructor domain = argSorts.
	self assert: constructor range = targetZ3DatatypeSort.
	^constructor valueWithArguments: args
]
