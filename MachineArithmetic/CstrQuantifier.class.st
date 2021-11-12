Class {
	#name : #CstrQuantifier,
	#superclass : #HCstr,
	#instVars : [
		'bind',
		'p'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'instance creation' }
CstrQuantifier class >> bind: b p: p [
	(p isKindOf: HCstr) ifFalse: [ self error ].
	^self basicNew 
		bind: b;
		p: p;
		yourself 
]

{ #category : #'instance creation' }
CstrQuantifier class >> new [
	^self shouldNotImplement
]

{ #category : #accessing }
CstrQuantifier >> bind [
	^ bind
]

{ #category : #accessing }
CstrQuantifier >> bind: anObject [
	bind := anObject
]

{ #category : #logic }
CstrQuantifier >> boundKVars [
	^ self bind p pKVars, self p boundKVars
]

{ #category : #GT }
CstrQuantifier >> children [ 
	^Array with: p
]

{ #category : #accessing }
CstrQuantifier >> flatConstraint [ 
	^self class 
		bind: (HBind x: bind x τ: bind τ p: bind p flatConstraint)
		p: p flatConstraint
]

{ #category : #'as yet unclassified' }
CstrQuantifier >> isTauto [
	self subclassResponsibility 
]

{ #category : #printing }
CstrQuantifier >> mathSymbol [
	self subclassResponsibility
]

{ #category : #accessing }
CstrQuantifier >> p [
	^ p
]

{ #category : #accessing }
CstrQuantifier >> p: anObject [
	p := anObject
]

{ #category : #printing }
CstrQuantifier >> printMeatOn: aStream [
	aStream nextPut: self mathSymbol.
	self bind printOn: aStream.
	aStream nextPutAll: ' : ...'
]

{ #category : #'term rewriting' }
CstrQuantifier >> pruneTauts [ 
	^self class 
		bind: bind p: p pruneTauts
]

{ #category : #logic }
CstrQuantifier >> uniq1: α [
	| x newC |
	x := bind x.
	(α hasSeen: x)
		ifTrue: [ 
			| newX |
			newX := x varSubscript: (α timesSeen: x).
			α notice: x.
			newC := (self rename: x to: newX renamer: α) uniq1: α.
			α notice: newX.
			^newC
	 ] ifFalse: [ 
			newC := self class
				bind: (HBind x: x τ: bind τ p: (bind p uniq1: α))
				p: (p uniq1: α).
			α notice: x.
			^newC
	 ]
	
]

{ #category : #'as yet unclassified' }
CstrQuantifier >> uniq: anAlphaRenamer [
	(anAlphaRenamer hasSeen: bind x)
		ifTrue: [  ]
		ifFalse: [  ]
]
