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
Object >> mapKVars: aBlock [
	^self mapKVars1: [ :kv1__ |
		| kv1 |
		kv1 := kv1__ first.
		aBlock value: kv1 ]
]

{ #category : #'*Refinements' }
Object >> printStringInHotel: h [
	^self printString
]

{ #category : #'*Refinements' }
Object >> subst: θ [
	self error: 'Dont know how to substitute in ', self class name
]
