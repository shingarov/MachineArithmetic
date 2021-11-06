Extension { #name : #SequenceableCollection }

{ #category : #'*MachineArithmetic' }
SequenceableCollection >> flatConstraint [
	| first rest |
	self size = 0 ifTrue: [ ^self ].
	"Horrible Algol.  Please please rewrite."
	first := self first.
	rest := self allButFirst.
	"I am either a bunch of Cstrs, or of Preds."
	(first isKindOf: HCstr)
		ifTrue: [
			(first isKindOf: CstrAnd) ifTrue: [ ^first conjuncts flatConstraint, rest flatConstraint ].
			first := first flatConstraint.
			rest := rest flatConstraint.
			(((first isKindOf: CstrHead) and: [first pred isKindOf: DecidableRefinement]) and: [first pred isTauto]) ifTrue: [ ^rest flatConstraint ].
			^{first.}, rest
		] ifFalse: [
			(first isKindOf: HPredAnd) ifTrue: [ ^first conjuncts flatConstraint, rest flatConstraint ].
			first := first flatConstraint.
			rest := rest flatConstraint.
			((first pred isKindOf: DecidableRefinement) and: [first pred isTauto]) ifTrue: [ ^rest flatConstraint ].
			^{first.}, rest
		]

]

{ #category : #'*MachineArithmetic' }
SequenceableCollection >> possibleOrderings [
	self isEmpty ifTrue: [ ^OrderedCollection with: self species new ].
	^self
		inject: OrderedCollection new
		into: [ :soFar :anElement | soFar
				addAll: ((self copyWithout: anElement) possibleOrderings collect: [ :h | (self species with: anElement), h ]);
				yourself ]
]
