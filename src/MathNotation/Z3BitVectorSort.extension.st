Extension { #name : #Z3BitVectorSort }

{ #category : #'*MathNotation' }
Z3BitVectorSort >> unsafeName [
	^'bv:',self length printString
]
