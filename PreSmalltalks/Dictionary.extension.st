Extension { #name : #Dictionary }

{ #category : #'*PreSmalltalks' }
Dictionary >> anyAt: elementOfKey ifAbsent: absentBlock [
	| key |
	key := self keys detect: [ :aKey | aKey includes: elementOfKey ]
		ifNone: [ ^absentBlock value ].
	^self at: key
]

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
Dictionary >> inserts: v at: k [
"
inserts ::  (Eq k, Hashable k) => k -> v -> M.HashMap k [v] -> M.HashMap k [v]
"
	| vs |
	vs := self at: k ifAbsent: [ #() ].
	^self copy
		at: k put: {v}, vs;
		yourself
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
Dictionary >> keysAtValue: value [ 
	"Answer the set of keys that correspond to the argument, v.
	 If there is none, answer ∅."

	^(self associations select: [ :association | value = association value ]) collect: #key
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
Dictionary >> rejectByKey: aBlock [ 
	"Evaluate aBlock with each of my values as the argument.
	 Collect into a new dictionary, only those associations for which aBlock evaluates to false."

	| newCollection |
	newCollection := self copyEmpty.
	self associationsDo: [ :each |
		(aBlock value: each key) ifFalse: [
			newCollection add: each copy ] ].
	^newCollection
]

{ #category : #'*PreSmalltalks' }
Dictionary >> replaceKey: key using: aBlock [
	"Destructively transform the value at key key by passing it through the one-argument block aBlock.
	 If the receiver does not include the key, pass nil to aBlock."
	| x |
	x := self at: key ifAbsent: [ nil ].
	self at: key put: (aBlock value: x)
]

{ #category : #'*PreSmalltalks' }
Dictionary >> selectByKey: aBlock [ 
	"Evaluate aBlock with each of my values as the argument.
	 Collect into a new dictionary, only those associations for which aBlock evaluates to true."

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
