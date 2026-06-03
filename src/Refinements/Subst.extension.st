Extension { #name : #Subst }

{ #category : #'*Refinements' }
Subst >> appSubst: sym [
	"appSubst :: Subst -> Symbol -> Expr"
	^self at: sym ifAbsent: (EVar of: sym)
]

{ #category : #'*Refinements' }
Subst class >> mkSubstNameToName: oldToNewVarNameAssocs [ 
	"Make a Subst from the argument which is a sequence of Associations of the form, varName->varName."
	| su |
	su := oldToNewVarNameAssocs collectAssociations: [ :old :new | old -> (EVar of: new) ].
	^self mkSubst: su
]

{ #category : #'*Refinements' }
Subst >> substitutionEnvironmentOver: anEvalEnv [
	| substs |
	"TODO: code duplication with DelayedSubst"
	
	substs := self associations collect: [ :ass |
		(anEvalEnv at: ass key) -> (anEvalEnv evaluate: ass value) ].
	^Dictionary newFromAssociations: substs
]
