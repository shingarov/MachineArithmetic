Extension { #name : #Z3BitVectorSort }

{ #category : #'*Refinements' }
Z3BitVectorSort >> isMono [
	^true
]

{ #category : #'*Refinements' }
Z3BitVectorSort >> sizeSort [
	^self length toSizeSort
]
