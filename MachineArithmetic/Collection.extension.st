Extension { #name : #Collection }

{ #category : #'*MachineArithmetic' }
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

{ #category : #'*MachineArithmetic' }
Collection >> inEnvironment: env [
	^self collect: [ :anElement | anElement inEnvironment: env ]
]

{ #category : #'*MachineArithmetic' }
Collection >> selectAssuming: prereq in: aSolver [
	"Collect into a new collection like the receiver, only those elements for which aBlock evaluates to true. Answer the new collection."
	^aSolver bracket: [
		aSolver assert: prereq.
		self select: [ :element | aSolver bracket: [ 
				aSolver isValid: element ]]
	]
]

{ #category : #'*MachineArithmetic' }
Collection >> withoutNils [
	^self reject: [ :x | x isNil ]
]
