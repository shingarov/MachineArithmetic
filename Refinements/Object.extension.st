Extension { #name : #Object }

{ #category : #'*Refinements' }
Object >> subst: θ [
	self error: 'Dont know how to substitute in ', self class name
]
