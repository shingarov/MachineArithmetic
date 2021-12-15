Extension { #name : #Association }

{ #category : #'*DepthFirstSearch' }
Association >> reverse [
	^self value -> self key
]
