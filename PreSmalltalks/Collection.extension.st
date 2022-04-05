Extension { #name : #Collection }

{ #category : #'*PreSmalltalks' }
Collection >> colject: thisValue into: binaryBlock [
	"This method behaves like a combination of #collect: and #inject:into:.
	It applies binaryBlock to each element of the receiver, passing an accumulating parameter
	from left to right, and answering a final value of this accumulator together with the new collection.
	This is similar to mapAccumL in Haskell."
	| blockResult rest |
	self size = 0 ifTrue: [ ^thisValue->self ].
	blockResult := binaryBlock value: thisValue value: self first.
	rest := self allButFirst colject: blockResult key into: binaryBlock.
	^rest key -> ( (self species with: blockResult value), rest value)
]

{ #category : #'*PreSmalltalks' }
Collection >> collectAndCat: aBlock [
	"Evaluate aBlock with each of the receiver's elements,
	 assuming aBlock will return a collection each time,
	 and concatenate the resulting lists.
	
	Cf. Data.Foldable.concatMap in Haskell.  Where this becomes interesting
	is with infinite lists, e.g.:
	  { 1 to: ∞.  10 to: ∞.  100 to: ∞.  1000 to: ∞. }
			collectAndCat: [ :a | a copyFrom: 1 to: 3 ]
	(viz. the test)."
	
	^(self collect: aBlock) inject: self species new into: [ :x :y | x, y ]
]

{ #category : #'*PreSmalltalks' }
Collection >> collectMaybe: aBlock [
	^self collect: aBlock thenReject: #isNil
]

{ #category : #'*PreSmalltalks' }
Collection >> collectPairs: aBlock [
	^self collect: [ :each | aBlock
		value: each first
		value: each second ]
]

{ #category : #'*PreSmalltalks' }
Collection >> collectTriples: aBlock [
	^self collect: [ :each | aBlock
		value: each first
		value: each second
		value: each third ]
]

{ #category : #'*PreSmalltalks' }
Collection >> folds: f base: a [
"self is a collection of b.
folds   :: (a -> b -> (c, a)) -> a -> [b] -> ([c], a)
"
	| step |
	step := [ :cs_acc :x |
		| acc cs c_x1 c x1|
		cs := cs_acc first.
		acc := cs_acc last.
		c_x1 := f value: acc value: x.
		c  := c_x1 first.
		x1 := c_x1 last.
		{ {c},cs . x1 } ].
	^self inject: { #() . a } into: step
]

{ #category : #'*PreSmalltalks' }
Collection >> groupAssociations [
	"This method is an extremely poor surrogate for proper object design,
	 and will be replaced soon, by something like MultiDictionary.
	
	Assume the receiver is a collection of Associations, such as
	  #( 'a'->1.  'a'->2.  'b'->3. ).
	Answer a dictionary associating each key to the set of values, so that
	  'a'->{1,2}, 'b'->{3}. "
	| answer |
	answer := Dictionary new.
	self do: [ :ass |
		| v |
		v := answer at: ass key ifAbsentPut: [Set new].
		v add: ass value ].
	^answer
]

{ #category : #'*PreSmalltalks' }
Collection >> groupList [
	^self groupAssociations associations 
]

{ #category : #'*PreSmalltalks' }
Collection >> partitionEithers [
	"Assume the receiver is a collection of Eithers;
	 separate the Lefts from the Rights, as a shepherd separates the sheep from the goats,
	 and answer the Association lefts->rights."
	| lefts rights |
	lefts := OrderedCollection new.
	rights := OrderedCollection new.
	self do: [ :either | either
				left: [ :x | lefts add: x ]
				right: [ :x | rights add: x ] ].
	^(lefts as: self species) -> (rights as: self species)
]

{ #category : #'*PreSmalltalks' }
Collection >> unzipAssociations [
	^{ self collect: #key . self collect: #value }
]
