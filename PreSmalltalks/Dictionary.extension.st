Extension { #name : #Dictionary }

{ #category : #'*PreSmalltalks' }
Dictionary >> injectWithKey: thisValue into: ternaryBlock [
	^self associations inject: thisValue into: [ :z :ass | ternaryBlock value: z value: ass key value: ass value ]
]

{ #category : #'*PreSmalltalks' }
Dictionary >> lookupSymbol: aString ifAbsent: aBlockClosure [ 
	^self at: aString ifAbsent: aBlockClosure
]

{ #category : #'*PreSmalltalks' }
Dictionary class >> newFromAssociations: anArray [ 

	"Each element of anArray is an Association."

	| newDictionary |

	newDictionary := self new: anArray size.
	1 to: anArray size do: [ :i| newDictionary at: (anArray at: i) key put: (anArray at: i) value ].
	^ newDictionary

	"  Dictionary newFromAssociations: {('Red'->Color red) . ('Blue'->Color blue) . ('Green'->Color green)}  "
]
