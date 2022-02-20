Extension { #name : #SequenceableCollection }

{ #category : #'*PreSmalltalks' }
SequenceableCollection >> group [
	^self groupBy: [ :a :b | a = b ]
]

{ #category : #'*PreSmalltalks' }
SequenceableCollection >> groupBy: equalityTestBlock [
	| ys_zs |
	self isEmpty ifTrue: [^#()].
	ys_zs := self allButFirst span: [ :x | equalityTestBlock value: x value: self first ].
	^Array
		with: (self species with: self first withAll: ys_zs first)
		withAll: (ys_zs last groupBy: equalityTestBlock)

]

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
SequenceableCollection >> span: aPredicate [
	"Answer an Array pair of the same species as the receiver where
	 the first element is the longest prefix (possibly empty) of elements that satisfy aPredicate,
	 and the second element is the remainder of the list"
	self isEmpty ifTrue: [ ^Array with: self species new with: self species new  ].
	^(aPredicate value: self first)
		ifTrue: [ | ys_zs |
			ys_zs := self allButFirst span: aPredicate.
			Array with: (self species with: self first), ys_zs first with: ys_zs last ]
		ifFalse: [ Array with: self species new with: self ]
]

{ #category : #'*PreSmalltalks' }
SequenceableCollection >> zip: anotherCollection [
	self size = anotherCollection size ifFalse: [ self error ].
	^self collectWithIndex: [ :elem :j | elem -> (anotherCollection at: j) ]
]
