Extension { #name : #Dictionary }

{ #category : #'*PreSmalltalks' }
Dictionary >> collectAssociations: aBlock [
	^self collect: [ :k_v |
		| k v |
		k := k_v key.
		v := k_v value.
		aBlock value: k value: v ]
]

{ #category : #'*PreSmalltalks' }
Dictionary >> groupBase: associations [ 
	^associations inject: self copy into: [ :soFar :thisAss |
		(soFar at: thisAss key) add: thisAss value.
		soFar ]
]

{ #category : #'*PreSmalltalks' }
Dictionary >> injectWithKey: thisValue into: ternaryBlock [
	^self associations inject: thisValue into: [ :z :ass | ternaryBlock value: z value: ass key value: ass value ]
]

{ #category : #'*PreSmalltalks' }
Dictionary >> keysAndValuesCollect: aBlock [
	^self associations collect: [ :kv | aBlock value: kv key value: kv value ]
]

{ #category : #'*PreSmalltalks' }
Dictionary >> keysAndValuesCollectMaybe: aBlock [
	^self associations collectMaybe: [ :kv | aBlock value: kv key value: kv value ]
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

{ #category : #'*PreSmalltalks' }
Dictionary >> selectByKey: aBlock [ 
	"Evaluate aBlock with each of my values as the argument. Collect into a new dictionary, only those associations for which aBlock evaluates to true."

	| newCollection |
	newCollection := self copyEmpty.
	self associationsDo: [ :each |
		(aBlock value: each key) ifTrue: [
			newCollection add: each copy ] ].
	^newCollection
]

{ #category : #'*PreSmalltalks' }
Dictionary >> withoutKeys: keysToReject [
	^self class newFromAssociations: (self associations reject: [ :k_v | keysToReject includes: k_v key ])

]
