Extension { #name : #Z3Node }

{ #category : #'*Refinements' }
Z3Node >> accept: aVisitor [ 
	^self "TODO: is this right? we introduced this for monomorphisation"
]

{ #category : #'*Refinements' }
Z3Node >> applyExpr: θ [ 
	^self
]

{ #category : #'*Refinements' }
Z3Node >> elab: anElabEnv [ 
	^{ self . self sort }
]

{ #category : #'*Refinements' }
Z3Node >> kvarsExpr [
	^#()
]

{ #category : #'*Refinements' }
Z3Node >> smt2Cast: aZ3Sort [
	aZ3Sort = self sort ifFalse: [ self error ].
	^self
]

{ #category : #'*Refinements' }
Z3Node >> subst: aSubst [
	^aSubst applyTo: self
]

{ #category : #'*Refinements' }
Z3Node >> toZ3Node [
	^self

]
