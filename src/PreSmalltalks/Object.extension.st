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
Object >> evaluate: aBlock until: aPredicate [
"
Start from self as the first iteration.  Feed self as the
argument to aBlock.  If the result satisfies aPredicate,
return it.  Otherwise, recurse into the next iteration using
the just-obtained result.

Equivalent to `until` in Haskell:
until :: (a->Bool) -> (a->a) -> a -> a
         aPredicate   aBlock   self

Example 1 from zvon:
  Input: until (> 100) (*2) 1
  Output: 128
Example 2 from zvon:
  Input: until odd ( `div` 2) 400
  Output: 25
"
	| result |
	result := aBlock value: self.
	^(aPredicate value: result)
		ifTrue: [ result ]
		ifFalse: [ result evaluate: aBlock until: aPredicate ]
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

{ #category : #'*PreSmalltalks' }
Object >> raisedTo: power [
	^power ==> self
]

{ #category : #'*PreSmalltalks' }
Object >> replicate: times [
	"Answer an Array of @times@ elements;
	 every element of the array is @self@."
	^(Array new: times)
		atAllPut: self;
		yourself
	
]
