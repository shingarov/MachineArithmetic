Extension { #name : #Object }

{ #category : #'*PreSmalltalks' }
Object >> K [
	^[ :y | self ]
]

{ #category : #'*PreSmalltalks' }
Object >> at: index nonDestructivePut: value [
	^self copy
		at: index put: value;
		yourself
]

{ #category : #'*PreSmalltalks' }
Object >> defaultMetavarTyping [
	(self respondsTo: #metavars) ifFalse: [ ^#() ].
	^(self metavars selectByKey: [ :ivarName | self allInstVarNames includes: ivarName ]) associations
]

{ #category : #'*PreSmalltalks' }
Object >> instVarTyping [
	^self defaultMetavarTyping
]

{ #category : #'*PreSmalltalks' }
Object >> maybe: _ f: aBlock [
	"Haskell's analog of #ifNil:.
	 The 'maybe' function takes a default value, a function, and a 'Maybe'
	 value.  If the 'Maybe' value is 'Nothing', the function returns the
	 default value.  Otherwise, it applies the function to the value inside
	 the 'Just' and returns the result.
	
	 maybe :: b -> (a -> b) -> Maybe a -> b
	"
	^aBlock value: self
]

{ #category : #'*PreSmalltalks' }
Object >> maybeToList [
	^{self}
]

{ #category : #'*PreSmalltalks' }
Object >> printStructOn: aStream [
	aStream nextPutAll: self class name.
	aStream nextPutAll: ' ('.	
	self class instVarNames do: [ :iv |
		(self instVarNamed: iv) printOn: aStream
 ] separatedBy: [ 	aStream nextPutAll: ') (' ].
	aStream nextPutAll: ')'
]
