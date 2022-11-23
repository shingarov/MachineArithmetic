Extension { #name : #Z3IntSort }

{ #category : #'*Refinements' }
Z3IntSort >> checkNumeric: env tvSubst: θ [
	^θ
]

{ #category : #'*Refinements' }
Z3IntSort >> guest [
	^self
]

{ #category : #'*Refinements' }
Z3IntSort >> isMono [
	^true
]
