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
	^(self collect: aBlock) inject: self species new into: [ :x :y | x, y ]
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
