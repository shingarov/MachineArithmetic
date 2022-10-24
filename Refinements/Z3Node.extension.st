Extension { #name : #Z3Node }

{ #category : #'*Refinements' }
Z3Node >> accept: aVisitor [ 
	^self "TODO: is this right? we introduced this for monomorphisation"
]

{ #category : #'*Refinements' }
Z3Node >> subst: aSubst [
	^aSubst applyTo: self
]

{ #category : #'*Refinements' }
Z3Node >> toZ3Node [
	^self

]
