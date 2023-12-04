Extension { #name : #SequenceableCollection }

{ #category : #'*Refinements' }
SequenceableCollection >> flatten [
	| first rest |
	self isEmpty ifTrue: [ ^self ].
	"Horrible Algol.  Please please rewrite."
	first := self first.
	rest := self allButFirst.
	"I am either a bunch of Cstrs, or of Preds."
	(first isKindOf: HCstr)
		ifTrue: [ "instance Flatten [Cstr a]"
			(first isKindOf: CstrAnd) ifTrue: [ ^first conjuncts flatten, rest flatten ].
			first := first flatten.
			rest := rest flatten.
			((first isKindOf: CstrHead) and: [(first pred isKindOf: HReft) and: [first pred expr isTautoPred]]) ifTrue: [ ^rest flatten ].
			^{first}, rest
		] ifFalse: [ "instance Flatten [Pred]"
			(first isKindOf: HPred) ifFalse: [ self error ].
			(first isKindOf: HPredAnd) ifTrue: [ ^first ps flatten, rest flatten ].
			first := first flatten.
			rest := rest flatten.
			((first isKindOf: HReft) and: [first expr isTautoPred]) ifTrue: [ ^rest flatten ].
			^{first}, rest
		]

]
