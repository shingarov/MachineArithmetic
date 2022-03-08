Extension { #name : #Z3Node }

{ #category : #'*Refinements' }
Z3Node >> subst1: anAST for: variableName [
	^self subst: (Subst mkSubst: {variableName->anAST})
]

{ #category : #'*Refinements' }
Z3Node >> subst: aSubst [
	^aSubst applyTo: self
]
