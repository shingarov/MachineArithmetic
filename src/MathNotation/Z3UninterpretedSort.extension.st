Extension { #name : #Z3UninterpretedSort }

{ #category : #'*MathNotation' }
Z3UninterpretedSort >> printOn: aStream [
	aStream nextPutAll: self unsafeName
]

{ #category : #'*MathNotation' }
Z3UninterpretedSort >> unsafeName [
	^self name asString decodeUnsafe
]
