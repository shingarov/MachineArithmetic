Extension { #name : #SequenceableCollection }

{ #category : #'*MachineArithmetic' }
SequenceableCollection >> possibleOrderings [
	self isEmpty ifTrue: [ ^OrderedCollection with: self species new ].
	^self
		inject: OrderedCollection new
		into: [ :soFar :anElement | soFar
				addAll: ((self copyWithout: anElement) possibleOrderings collect: [ :h | (self species with: anElement), h ]);
				yourself ]
]
