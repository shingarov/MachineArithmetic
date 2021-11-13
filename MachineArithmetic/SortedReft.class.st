Class {
	#name : #SortedReft,
	#superclass : #Object,
	#instVars : [
		'sr_sort',
		'sr_reft'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'as yet unclassified' }
SortedReft >> evaluate: e in: aBindEnv [
	| p boundArg boundArgSort |
	p := sr_reft expr evaluateIn: aBindEnv.
	p isBool ifFalse: [ self error: 'Non-bool constraint' ].
	boundArg := self sr_reft symbol.
	boundArgSort := aBindEnv sortOf: boundArg.
	^p substitute: (boundArgSort mkConst: boundArg) with: e
]

{ #category : #printing }
SortedReft >> printOn: aStream [ 
	aStream nextPutAll: '{ '.
	aStream nextPutAll: self sr_reft symbol.
	aStream nextPutAll: ' : '.
	self sr_sort printOn: aStream.
	aStream nextPutAll: ' | '.
	self sr_reft expr printOn: aStream.
	aStream nextPutAll: ' }'.
]

{ #category : #'as yet unclassified' }
SortedReft >> shiftSR: i [ 
	^self copy
		sr_reft: (self sr_reft shiftR: i);
		yourself
]

{ #category : #accessing }
SortedReft >> sr_reft [
	^ sr_reft
]

{ #category : #accessing }
SortedReft >> sr_reft: anObject [
	sr_reft := anObject
]

{ #category : #accessing }
SortedReft >> sr_sort [
	^ sr_sort
]

{ #category : #accessing }
SortedReft >> sr_sort: anObject [
	sr_sort := anObject
]

{ #category : #'as yet unclassified' }
SortedReft >> top [
	^self "????"
]

{ #category : #'as yet unclassified' }
SortedReft >> trueSortedReft [
	^self
]

{ #category : #'as yet unclassified' }
SortedReft >> updSortedReft_kve: kve p: p [
	^SortedReft new
		sr_sort: self sr_sort;
		sr_reft: (self sr_reft copy
		             expr: (p predExpr: kve);
		             yourself
			);
		yourself
]
