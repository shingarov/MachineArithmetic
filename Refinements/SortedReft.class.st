Class {
	#name : #SortedReft,
	#superclass : #Object,
	#instVars : [
		'sr_sort',
		'sr_reft'
	],
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
SortedReft class >> go_sortedReftConcKVars: ps _: ks _: gs _: aList t: t [
	| x xs v p |
	aList isEmpty ifTrue: [ ^{ ps . ks . gs } ].
	x := aList first.
	xs := aList allButFirst.
	v := x key.
	p := x value.
	^(p isKindOf: PKVar)
		ifTrue: [ self go_sortedReftConcKVars: ps _: {KVSub vv: v sort: t kVar: p var subst: p s}, ks _: gs _: xs t: t ]
		"TODO: PGrad"
		ifFalse: [ self shouldBeImplemented ]
]

{ #category : #'as yet unclassified' }
SortedReft >> bind [
	^self sr_reft symbol -> self
]

{ #category : #'as yet unclassified' }
SortedReft >> concKVars: x [
	"Deconstruct a SortedReft.
	Split a SortedReft into its concrete and KVar components.
	sortedReftConcKVars :: Symbol -> SortedReft -> ([Pred], [KVSub], [KVSub])
	cf. Types/Utils.hs"
	| ves rs t |
	t := self sr_sort.
	rs := sr_reft conjuncts.
	ves := rs collect: [ :eachReft |
		| v p |
		v := eachReft symbol.
		p := eachReft expr.
		v -> (p subst1: (EVar of: x) for: v) ].
	^self class go_sortedReftConcKVars: #() _: #() _: #() _: ves t: t
]

{ #category : #'as yet unclassified' }
SortedReft >> evaluate: e in: aBindEnv [
	| p boundArg boundArgSort |
	p := sr_reft expr evaluateIn: aBindEnv.
	p isBool ifFalse: [ self error: 'Non-bool constraint' ].
	p := p simplify.
	p == Bool true  ifTrue: [^p].
	p == Bool false ifTrue: [^p].
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
