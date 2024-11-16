Extension { #name : #Z3RealSort }

{ #category : #'*MathNotation' }
Z3RealSort >> printString [
	^self unsafeName
]

{ #category : #'*MathNotation' }
Z3RealSort >> unsafeName [
	^String with: Character reals
]
