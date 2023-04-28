Extension { #name : #Z3BoolSort }

{ #category : #'*Refinements' }
Z3BoolSort >> containsFVar [
	^false
]

{ #category : #'*Refinements' }
Z3BoolSort >> functionSort [
	^nil
]

{ #category : #'*Refinements' }
Z3BoolSort >> guest [
	^self
]

{ #category : #'*Refinements' }
Z3BoolSort >> isMono [
	^true
]
