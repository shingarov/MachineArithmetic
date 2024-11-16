Extension { #name : #Z3DatatypeSort }

{ #category : #'*MathNotation' }
Z3DatatypeSort >> printString [
	^self unsafeName
]

{ #category : #'*MathNotation' }
Z3DatatypeSort >> unsafeName [
	^self name getString decodeUnsafe
]
