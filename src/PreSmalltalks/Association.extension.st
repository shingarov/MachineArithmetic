Extension { #name : #Association }

{ #category : #'*PreSmalltalks' }
Association >> swap [
	^self value -> self key
]

{ #category : #'*PreSmalltalks' }
Association >> toTriple [
	"Assume I am x->y->z, answer {x.y.z}"
	^{ self key key . self key value . self value }
]
