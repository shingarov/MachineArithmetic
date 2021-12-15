Extension { #name : #SequenceableCollection }

{ #category : #'*Refinements' }
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
			((first isKindOf: CstrHead) and: [first pred isTauto]) ifTrue: [ ^rest flatConstraint ].
			^{first.}, rest
		] ifFalse: [
			(first isKindOf: HPredAnd) ifTrue: [ ^first conjuncts flatConstraint, rest flatConstraint ].
			first := first flatConstraint.
			rest := rest flatConstraint.
			((first isKindOf: DecidableRefinement) and: [first isTauto]) ifTrue: [ ^rest flatConstraint ].
			^{first.}, rest
		]

]
