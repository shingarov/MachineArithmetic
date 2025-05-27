Class {
	#name : #SemUpdate,
	#superclass : #SMTSem,
	#category : #'Refinements-Theories'
}

{ #category : #yoneda }
SemUpdate class >> apply: functionName to: args ofZ3sorts: argSorts returning: aZ3Sort [
	| z3datatype tuple newValue |
	self assert: args size = 2.
	tuple := args first.
	newValue := args second.
	
	self assert: (tuple isKindOf: Z3Tuple).
	self assert: tuple sort = argSorts first.
	self assert: newValue sort = argSorts second.
	self assert: aZ3Sort = tuple sort.

	^tuple updateFieldNamed: functionName fieldNameToUpdate to: newValue
]
