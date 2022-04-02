Extension { #name : #Object }

{ #category : #'*Refinements' }
Object >> dCut [
	^Elims
		cuts: (Set with: self)
		nonCuts: Set new
]

{ #category : #'*Refinements' }
Object >> dNonCut [
	^Elims
		cuts: Set new
		nonCuts: (Set with: self)
]

{ #category : #'*Refinements' }
Object >> isJunkFxEVar [
	^false
]

{ #category : #'*Refinements' }
Object >> subst: θ [
	self error: 'Dont know how to substitute in ', self class name
]
