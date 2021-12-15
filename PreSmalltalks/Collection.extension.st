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
