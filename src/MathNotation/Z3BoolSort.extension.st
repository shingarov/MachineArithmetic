Extension { #name : #Z3BoolSort }

{ #category : #'*MathNotation' }
Z3BoolSort >> printString [
	^self unsafeName
]

{ #category : #'*MathNotation' }
Z3BoolSort >> unsafeName [
	^String with: (Character codePoint: 16r1D539)
]
