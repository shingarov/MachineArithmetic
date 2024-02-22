Extension { #name : #SequenceableCollection }

{ #category : #'*PreSmalltalks' }
SequenceableCollection >> concat [
	"Like #flattened but non-recursive.
	
	 The species of the resulting collection is determined solely
	 by the species of the receiver's elements; {a.b.c} is simply a,b,c.
	
	 In the special case of empty receiver, answer #()."
	
	self isEmpty ifTrue: [^#()].
	^self allButFirst
		inject: self first
		into: [ :soFar :thisSubcollection | soFar, thisSubcollection ]
]

{ #category : #'*PreSmalltalks' }
SequenceableCollection >> foldr: f fromSeed: aB [
	"
	Take aB and the last item of the receiver (which is a list of a's)
	and apply the two-argument block f, then take the penultimate item and the result, and so on:
		foldr :: (a -> b -> b) -> b -> [a]  -> b
		           f              aB   self
	"
	self isEmpty ifTrue: [ ^aB ].
	^self allButLast
		foldr: f
		fromSeed: (f value: self last value: aB)
]

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
SequenceableCollection >> groupMap: f [
"
groupMap   :: (Eq k, Hashable k) => (a -> k) -> [a] -> M.HashMap k [a]
groupMap f = L.foldl' (\m x -> inserts (f x) x m) M.empty
"
	^self
		inject: Dictionary new
		into: [ :m :x | m inserts: x at: (f value: x) ]
]

{ #category : #'*PreSmalltalks' }
SequenceableCollection >> mapEither: f [
"
mapEither :: (a -> Either b c) -> [a] -> ([b], [c])
"
	| x xs ys_zs ys zs |
	self isEmpty ifTrue: [ ^self species new -> self species new ].
	x := self first.  xs := self allButFirst.
	ys_zs := xs mapEither: f.  ys := ys_zs key.  zs := ys_zs value.
	^(f value: x)
		left: [ :y | (self species with: y), ys -> zs ]
		right: [ :z | ys -> ((self species with: z), zs) ]
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

{ #category : #'*PreSmalltalks' }
SequenceableCollection >> zip: anotherCollection with: aBlock [
"
zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
"
	self size = anotherCollection size ifFalse: [ self error ].
	^self collectWithIndex: [ :elem :j | aBlock value: elem value: (anotherCollection at: j) ]
]
