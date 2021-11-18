Extension { #name : #ShallowRefinement }

{ #category : #'*MachineArithmetic-MathNotation' }
ShallowRefinement >> ∩ [ rhs 
	B = rhs ifTrue: [ ^self ].
	B = rhs base ifFalse: [ self error: 'Incoherent sorts' ].
	^B | [ :x | (e value: x) & (rhs predicate value: x) ]
]
