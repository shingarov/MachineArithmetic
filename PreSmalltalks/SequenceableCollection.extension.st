Extension { #name : #SequenceableCollection }

{ #category : #'*PreSmalltalks' }
SequenceableCollection >> possibleOrderings [
	self isEmpty ifTrue: [ ^OrderedCollection with: self species new ].
	^self
		inject: OrderedCollection new
		into: [ :soFar :anElement | soFar
				addAll: ((self copyWithout: anElement) possibleOrderings collect: [ :h | (self species with: anElement), h ]);
				yourself ]
]

{ #category : #'*PreSmalltalks' }
SequenceableCollection >> zip: anotherCollection [
	self size = anotherCollection size ifFalse: [ self error ].
	^self collectWithIndex: [ :elem :j | elem -> (anotherCollection at: j) ]
]
