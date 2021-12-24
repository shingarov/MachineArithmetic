Extension { #name : #SequenceableCollection }

{ #category : #'*PreSmalltalks' }
SequenceableCollection >> nubOrd [
	"Answer myself with adjacent duplicates removed."
	| tail |
	self size > 1 ifFalse: [ ^self ].
	tail := self allButFirst.
	^self first = self second
		ifTrue: [ tail nubOrd ]
		ifFalse: [ (self species with: self first), tail nubOrd ]
]

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
SequenceableCollection >> sortedNub [
	^self sorted nubOrd
]

{ #category : #'*PreSmalltalks' }
SequenceableCollection >> zip: anotherCollection [
	self size = anotherCollection size ifFalse: [ self error ].
	^self collectWithIndex: [ :elem :j | elem -> (anotherCollection at: j) ]
]
