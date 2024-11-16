Extension { #name : #Z3IntSort }

{ #category : #'*MathNotation' }
Z3IntSort >> printString [
	^self unsafeName
]

{ #category : #'*MathNotation' }
Z3IntSort >> unsafeName [
	^String with: Character zahlen
]
