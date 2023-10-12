Extension { #name : #Class }

{ #category : #'*MachineArithmetic-MathNotation' }
Class >> ∪ [ anotherClass
	"Join in the semilattice of classes partially-ordered by 'is-subclass-of'.
	
	SmallInteger ∪ Association >>> Magnitude
	"
	
	"Join of any two comparable elements is the 'bigger' one"
	self ⊆ anotherClass ifTrue: [ ^anotherClass ].
	anotherClass ⊆ self ifTrue: [ ^self ].

	^self superclass ∪ anotherClass
]

{ #category : #'*MachineArithmetic-MathNotation' }
Class >> ⊆ [ anotherClass
	"Answer whether the receiver is a subclass of anotherClass,
	 reflexive case included.
	
	Integer ⊆ Object >>> true
	Integer ⊆ String >>> false
	"

	self = anotherClass ifTrue: [ ^true ].
	^self superclass ⊆ anotherClass
]
